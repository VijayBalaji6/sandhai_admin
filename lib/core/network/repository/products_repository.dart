import '../core/api_result.dart';
import '../data_source/products_remote_data_source.dart';
import '../dtos/product_model.dart';

class ProductsRepository {
  ProductsRepository({ProductsRemoteDataSource? remoteDataSource})
    : _remoteDataSource = remoteDataSource ?? ProductsRemoteDataSource();

  final ProductsRemoteDataSource _remoteDataSource;

  Future<ApiResult<List<ProductModel>>> fetchProducts({
    String? category,
    bool? isActive,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) async {
    final String? normalizedCategory = category?.trim();

    final ApiResult<List<ProductModel>> result = await _remoteDataSource
        .fetchProducts(
          category: (normalizedCategory == null || normalizedCategory.isEmpty)
              ? null
              : normalizedCategory,
          isActive: isActive,
          orderBy: orderBy,
          ascending: ascending,
          limit: limit,
          offset: offset,
        );

    return result.when(
      success: (List<ProductModel> products) => ApiResult.success(products),
      failure: (exception) => ApiResult.failure(exception),
    );
  }

  Future<ApiResult<ProductModel>> fetchProductById(String id) {
    return _remoteDataSource.fetchProductById(id);
  }

  Future<ApiResult<ProductModel>> createProduct(Map<String, dynamic> data) {
    return _remoteDataSource.createProduct(data);
  }

  Future<ApiResult<ProductModel>> updateProduct({
    required String id,
    required Map<String, dynamic> data,
  }) {
    return _remoteDataSource.updateProduct(id: id, data: data);
  }

  Future<ApiResult<void>> deleteProduct(String id) {
    return _remoteDataSource.deleteProduct(id);
  }
}
