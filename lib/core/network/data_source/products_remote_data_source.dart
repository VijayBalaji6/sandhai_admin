import '../core/api_result.dart';
import '../core/supabase_api.dart';
import '../dtos/product_model.dart';

class ProductsRemoteDataSource {
  final SupabaseApi _api = SupabaseApi('products');

  Future<ApiResult<List<ProductModel>>> fetchProducts({
    String? category,
    bool? isActive,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    final Map<String, dynamic> filters = <String, dynamic>{};
    if (category != null && category.isNotEmpty) {
      filters['category'] = category;
    }
    if (isActive != null) {
      filters['is_active'] = isActive;
    }

    return _api.getAll<ProductModel>(
      fromJson: ProductModel.fromJson,
      columns: '*',
      filters: filters.isEmpty ? null : filters,
      orderBy: orderBy ?? 'created_at',
      ascending: ascending,
      limit: limit,
      offset: offset,
    );
  }

  Future<ApiResult<ProductModel>> fetchProductById(String id) {
    return _api.getById<ProductModel>(
      id: id,
      fromJson: ProductModel.fromJson,
    );
  }

  Future<ApiResult<ProductModel>> createProduct(Map<String, dynamic> data) {
    return _api.insert<ProductModel>(
      data: data,
      fromJson: ProductModel.fromJson,
    );
  }

  Future<ApiResult<ProductModel>> updateProduct({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return _api.update<ProductModel>(
      id: id,
      data: data,
      fromJson: ProductModel.fromJson,
    );
  }

  Future<ApiResult<void>> deleteProduct(String id) {
    return _api.delete(id: id);
  }
}
