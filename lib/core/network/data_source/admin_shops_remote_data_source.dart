import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/api_handler.dart';
import '../core/api_result.dart';
import '../dtos/shop_model.dart';

/// Loads shops linked to an admin via [admin_shop_mapping].
class AdminShopsRemoteDataSource {
  Future<ApiResult<List<ShopModel>>> fetchShopsForAdmin(String adminId) {
    return ApiHandler.guard(
      tag: 'admin_shop_mapping.fetchShopsForAdmin',
      action: () async {
        final dynamic response = await Supabase.instance.client
            .from('admin_shop_mapping')
            .select('shop_id, shop:shop(*)')
            .eq('admin_id', adminId.trim());

        if (response is! List<dynamic>) {
          return <ShopModel>[];
        }

        final List<ShopModel> shops = <ShopModel>[];
        for (final dynamic row in response) {
          if (row is! Map<String, dynamic>) continue;
          final dynamic shopJson = row['shop'];
          if (shopJson is Map<String, dynamic>) {
            shops.add(ShopModel.fromJson(shopJson));
          }
        }
        return shops;
      },
    );
  }
}
