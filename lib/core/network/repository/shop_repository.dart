import '../core/api_result.dart';
import '../data_source/shop_remote_data_source.dart';
import '../dtos/shop_model.dart';

class ShopRepository {
  ShopRepository({ShopRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? ShopRemoteDataSource();

  final ShopRemoteDataSource _remoteDataSource;

  Future<ApiResult<ShopModel>> fetchShop({String? id}) {
    if (id != null && id.trim().isNotEmpty) {
      return _remoteDataSource.fetchShopById(id.trim());
    }
    return _remoteDataSource.fetchShop();
  }

  Future<ApiResult<ShopModel>> updateShop(ShopModel shop) {
    final Map<String, dynamic> payload = Map<String, dynamic>.from(shop.toJson())
      ..remove('id')
      ..remove('created_at')
      ..remove('updated_at')
      ..['updated_at'] = DateTime.now().toIso8601String();

    return _remoteDataSource.updateShop(id: shop.id, payload: payload);
  }
}
