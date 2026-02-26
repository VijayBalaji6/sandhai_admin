import '../core/api_result.dart';
import '../data_source/products_remote_data_source.dart';
import '../dtos/product_model.dart';

class ProductsRepository {
  ProductsRepository({ProductsRemoteDataSource? remoteDataSource})
      : _remoteDataSource =
            remoteDataSource ?? ProductsRemoteDataSource();

  final ProductsRemoteDataSource _remoteDataSource;

  Future<ApiResult<List<ProductModel>>> fetchProducts({
    String? category,
    bool? isActive,
    String? orderBy,
    bool ascending = true,
    int? limit,
    int? offset,
  }) {
    return _remoteDataSource.fetchProducts(
      category: category,
      isActive: isActive,
      orderBy: orderBy,
      ascending: ascending,
      limit: limit,
      offset: offset,
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
