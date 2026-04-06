part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

final class OrdersFetchRequested extends OrdersEvent {
  const OrdersFetchRequested({
    this.filterMode = OrdersFilterMode.currentOnly,
    this.shopId,
  });

  final OrdersFilterMode filterMode;

  /// When set, only orders for this shop are loaded (matches `orders.shop_id`).
  final String? shopId;

  @override
  List<Object?> get props => [filterMode, shopId];
}

final class OrderStatusAdvanced extends OrdersEvent {
  const OrderStatusAdvanced({
    required this.id,
    required this.currentStatus,
  });

  final String id;
  final OrderStatusEnum currentStatus;

  @override
  List<Object?> get props => [id, currentStatus];
}

final class OrderStatusSetRequested extends OrdersEvent {
  const OrderStatusSetRequested({required this.id, required this.status});

  final String id;
  final OrderStatusEnum status;

  @override
  List<Object?> get props => [id, status];
}

final class OrdersMessageCleared extends OrdersEvent {
  const OrdersMessageCleared();
}

