part of 'orders_bloc.dart';

enum OrdersStatus { initial, loading, loaded, updating, failure }
enum OrdersFilterMode { all, currentOnly, completedOnly }

final class OrdersState extends Equatable {
  const OrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const [],
    this.filterMode = OrdersFilterMode.currentOnly,
    this.updatingOrderId,
    this.errorMessage,
    this.successMessage,
  });

  final OrdersStatus status;
  final List<OrderModel> orders;
  final OrdersFilterMode filterMode;
  final String? updatingOrderId;
  final String? errorMessage;
  final String? successMessage;

  OrdersState copyWith({
    OrdersStatus? status,
    List<OrderModel>? orders,
    OrdersFilterMode? filterMode,
    String? updatingOrderId,
    String? errorMessage,
    String? successMessage,
    bool clearUpdatingOrder = false,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      filterMode: filterMode ?? this.filterMode,
      updatingOrderId: clearUpdatingOrder
          ? null
          : (updatingOrderId ?? this.updatingOrderId),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        orders,
        filterMode,
        updatingOrderId,
        errorMessage,
        successMessage,
      ];
}

