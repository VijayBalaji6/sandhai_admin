import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/api_result.dart';
import '../data_source/admin_shops_remote_data_source.dart';
import '../data_source/shop_remote_data_source.dart';
import '../dtos/shop_model.dart';

class AdminShopsRepository {
  AdminShopsRepository({
    AdminShopsRemoteDataSource? adminShopsRemote,
    ShopRemoteDataSource? shopRemote,
  })  : _adminShopsRemote = adminShopsRemote ?? AdminShopsRemoteDataSource(),
        _shopRemote = shopRemote ?? ShopRemoteDataSource();

  final AdminShopsRemoteDataSource _adminShopsRemote;
  final ShopRemoteDataSource _shopRemote;

  /// When logged in, loads shops from [admin_shop_mapping]. When not logged in,
  /// falls back to a single shop (legacy / local dev).
  Future<ApiResult<List<ShopModel>>> loadAccessibleShops() async {
    final User? user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      final ApiResult<ShopModel> single = await _shopRemote.fetchShop();
      return single.when(
        success: (ShopModel shop) => ApiResult.success(<ShopModel>[shop]),
        failure: (exception) => ApiResult.failure(exception),
      );
    }

    final ApiResult<List<ShopModel>> mapped =
        await _adminShopsRemote.fetchShopsForAdmin(user.id);
    return mapped.when(
      success: (List<ShopModel> shops) {
        if (shops.isEmpty) {
          return _fallbackWhenNoMappings();
        }
        return ApiResult.success(shops);
      },
      failure: (exception) => ApiResult.failure(exception),
    );
  }

  /// If RLS returns nothing or mapping is empty, fall back to one shop (same as legacy).
  Future<ApiResult<List<ShopModel>>> _fallbackWhenNoMappings() async {
    final ApiResult<ShopModel> single = await _shopRemote.fetchShop();
    return single.when(
      success: (ShopModel shop) => ApiResult.success(<ShopModel>[shop]),
      failure: (exception) => ApiResult.failure(exception),
    );
  }
}
