import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/core/network/core/api_exception.dart';
import 'package:sandhai_admin/core/network/core/api_result.dart';
import 'package:sandhai_admin/core/network/dtos/order_model.dart';
import 'package:sandhai_admin/core/network/repository/orders_repository.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc({OrdersRepository? repository})
      : _repository = repository ?? OrdersRepository(),
        super(const OrdersState()) {
    on<OrdersFetchRequested>(_onFetchRequested);
    on<OrderStatusAdvanced>(_onStatusAdvanced);
    on<OrderStatusSetRequested>(_onStatusSetRequested);
    on<OrdersMessageCleared>(_onMessageCleared);
  }

  final OrdersRepository _repository;

  Future<void> _onFetchRequested(
    OrdersFetchRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(
      state.copyWith(
        status: OrdersStatus.loading,
        filterMode: event.filterMode,
        shopId: event.shopId,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final ApiResult<List<OrderModel>> result = await _repository.fetchOrders(
      shopId: event.shopId,
    );
    result.when(
      success: (orders) {
        final List<OrderModel> filtered = _filterOrders(
          orders,
          filterMode: event.filterMode,
        );
        emit(
          state.copyWith(
            status: OrdersStatus.loaded,
            orders: filtered,
            filterMode: event.filterMode,
            shopId: event.shopId,
            clearError: true,
            clearSuccess: true,
          ),
        );
      },
      failure: (ApiException exception) {
        emit(
          state.copyWith(
            status: OrdersStatus.failure,
            errorMessage: exception.message,
            filterMode: event.filterMode,
            shopId: event.shopId,
            clearSuccess: true,
          ),
        );
      },
    );
  }

  Future<void> _onStatusAdvanced(
    OrderStatusAdvanced event,
    Emitter<OrdersState> emit,
  ) async {
    final OrderStatusEnum? next = _nextStatus(event.currentStatus);
    if (next == null) return;
    add(OrderStatusSetRequested(id: event.id, status: next));
  }

  Future<void> _onStatusSetRequested(
    OrderStatusSetRequested event,
    Emitter<OrdersState> emit,
  ) async {
    emit(
      state.copyWith(
        status: OrdersStatus.updating,
        updatingOrderId: event.id,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final ApiResult<OrderModel> result = await _repository.updateOrderStatus(
      id: event.id,
      status: event.status,
    );

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            status: OrdersStatus.loaded,
            clearUpdatingOrder: true,
            successMessage: 'Order updated to ${event.status.label}',
            clearError: true,
          ),
        );
        add(
          OrdersFetchRequested(
            filterMode: state.filterMode,
            shopId: state.shopId,
          ),
        );
      },
      failure: (ApiException exception) {
        emit(
          state.copyWith(
            status: OrdersStatus.failure,
            clearUpdatingOrder: true,
            errorMessage: exception.message,
            clearSuccess: true,
          ),
        );
      },
    );
  }

  void _onMessageCleared(OrdersMessageCleared event, Emitter<OrdersState> emit) {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }

  List<OrderModel> _filterOrders(
    List<OrderModel> orders, {
    required OrdersFilterMode filterMode,
  }) {
    return orders.where((order) {
      switch (filterMode) {
        case OrdersFilterMode.all:
          return true;
        case OrdersFilterMode.currentOnly:
          return order.status.isCurrent;
        case OrdersFilterMode.completedOnly:
          return order.status.isCompleted;
      }
    }).toList();
  }

  OrderStatusEnum? _nextStatus(OrderStatusEnum current) {
    switch (current) {
      case OrderStatusEnum.ordered:
        return OrderStatusEnum.accepted;
      case OrderStatusEnum.accepted:
        return OrderStatusEnum.packing;
      case OrderStatusEnum.packing:
        return OrderStatusEnum.outForDelivery;
      case OrderStatusEnum.outForDelivery:
        return OrderStatusEnum.delivered;
      case OrderStatusEnum.delivered:
        return null;
      case OrderStatusEnum.cancelled:
      case OrderStatusEnum.undelivered:
        return null;
    }
  }
}

