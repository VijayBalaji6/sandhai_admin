import '../core/api_result.dart';
import '../core/supabase_api.dart';
import '../dtos/order_item_model.dart';
import '../dtos/order_model.dart';

class OrdersRemoteDataSource {
  final SupabaseApi _api = SupabaseApi('orders');
  final SupabaseApi _orderItemsApi = SupabaseApi('order_items');

  Future<ApiResult<List<OrderModel>>> fetchOrders({
    String? orderBy,
    bool ascending = false,
    int? limit,
    int? offset,
  }) {
    return _api.getAll<OrderModel>(
      fromJson: OrderModel.fromJson,
      columns: '*',
      orderBy: orderBy ?? 'created_at',
      ascending: ascending,
      limit: limit,
      offset: offset,
    );
  }

  Future<ApiResult<OrderModel>> updateOrder({
    required String id,
    required Map<String, dynamic> payload,
  }) {
    return _api.update<OrderModel>(
      id: id,
      data: payload,
      fromJson: OrderModel.fromJson,
    );
  }

  Future<ApiResult<List<OrderItemModel>>> fetchOrderItems(String orderId) {
    return _orderItemsApi.getByField<OrderItemModel>(
      field: 'order_id',
      value: orderId,
      fromJson: OrderItemModel.fromJson,
      orderBy: 'created_at',
      ascending: true,
    );
  }
}

