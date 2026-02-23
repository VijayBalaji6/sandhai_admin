import '../core/api_result.dart';
import '../core/api_exception.dart';
import '../core/supabase_api.dart';
import '../dtos/shop_model.dart';

class ShopRemoteDataSource {
  final SupabaseApi _api = SupabaseApi('shop');

  Future<ApiResult<ShopModel>> fetchShop() async {
    final ApiResult<List<ShopModel>> result = await _api.getAll<ShopModel>(
      fromJson: ShopModel.fromJson,
      orderBy: 'created_at',
      ascending: true,
      limit: 1,
    );

    return result.when(
      success: (List<ShopModel> shops) {
        if (shops.isEmpty) {
          return const ApiResult.failure(
            ApiException(
              message: 'No shop data found.',
              statusCode: 404,
              code: 'SHOP_NOT_FOUND',
            ),
          );
        }
        return ApiResult.success(shops.first);
      },
      failure: ApiResult.failure,
    );
  }

  Future<ApiResult<ShopModel>> fetchShopById(String id) {
    return _api.getById<ShopModel>(id: id, fromJson: ShopModel.fromJson);
  }

  Future<ApiResult<ShopModel>> updateShop({
    required String id,
    required Map<String, dynamic> payload,
  }) {
    return _api.update<ShopModel>(
      id: id,
      data: payload,
      fromJson: ShopModel.fromJson,
    );
  }
}
