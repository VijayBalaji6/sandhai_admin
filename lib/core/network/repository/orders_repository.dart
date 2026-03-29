import '../core/api_result.dart';
import '../data_source/orders_remote_data_source.dart';
import '../dtos/order_item_model.dart';
import '../dtos/order_model.dart';

class OrdersRepository {
  OrdersRepository({OrdersRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? OrdersRemoteDataSource();

  final OrdersRemoteDataSource _remoteDataSource;

  Future<ApiResult<List<OrderModel>>> fetchOrders() {
    return _remoteDataSource.fetchOrders(orderBy: 'created_at', ascending: false);
  }

  Future<ApiResult<OrderModel>> updateOrderStatus({
    required String id,
    required OrderStatusEnum status,
  }) {
    return _remoteDataSource.updateOrder(
      id: id,
      payload: <String, dynamic>{
        'status': _toDbStatus(status),
        'updated_at': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<ApiResult<List<OrderItemModel>>> fetchOrderItems(String orderId) {
    return _remoteDataSource.fetchOrderItems(orderId);
  }

  String _toDbStatus(OrderStatusEnum status) {
    switch (status) {
      case OrderStatusEnum.ordered:
        return 'ordered';
      case OrderStatusEnum.accepted:
        return 'accepted';
      case OrderStatusEnum.packing:
        return 'packing';
      case OrderStatusEnum.outForDelivery:
        return 'outfordelivery';
      case OrderStatusEnum.delivered:
        return 'delivered';
      case OrderStatusEnum.cancelled:
        return 'cancelled';
      case OrderStatusEnum.undelivered:
        return 'undelivered';
    }
  }
}

