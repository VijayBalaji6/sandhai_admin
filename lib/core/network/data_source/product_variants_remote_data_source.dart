import '../core/api_result.dart';
import '../core/supabase_api.dart';
import '../dtos/product_variant_model.dart';

class ProductVariantsRemoteDataSource {
  final SupabaseApi _api = SupabaseApi('product_variants');

  Future<ApiResult<ProductVariantModel>> createVariant(
    Map<String, dynamic> data,
  ) {
    return _api.insert<ProductVariantModel>(
      data: data,
      fromJson: ProductVariantModel.fromJson,
    );
  }
}
