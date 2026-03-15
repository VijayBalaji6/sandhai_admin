import '../core/api_result.dart';
import '../data_source/product_variants_remote_data_source.dart';
import '../data_source/products_remote_data_source.dart';
import '../dtos/order_item_model.dart';
import '../dtos/product_model.dart';

class ProductsRepository {
  ProductsRepository({
    ProductsRemoteDataSource? remoteDataSource,
    ProductVariantsRemoteDataSource? variantsRemoteDataSource,
  }) : _remoteDataSource = remoteDataSource ?? ProductsRemoteDataSource(),
       _variantsRemoteDataSource =
           variantsRemoteDataSource ?? ProductVariantsRemoteDataSource();

  final ProductsRemoteDataSource _remoteDataSource;
  final ProductVariantsRemoteDataSource _variantsRemoteDataSource;

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

  Future<ApiResult<ProductModel>> createProductWithVariant({
    required String name,
    required ProductCategoryEnum category,
    required ProductTypeEnum productType,
    required UnitTypeEnum unitType,
    required double quantity,
    required double price,
    String? imageUrl,
    bool isActive = true,
  }) async {
    final ApiResult<ProductModel> createProductResult = await _remoteDataSource
        .createProduct(<String, dynamic>{
          'name': name.trim(),
          'product_category': _productCategoryToDbValue(category),
          'image_url': imageUrl?.trim().isEmpty ?? true
              ? null
              : imageUrl!.trim(),
          'is_active': isActive,
          'product_type': _productTypeToDbValue(productType),
        });

    if (createProductResult is ApiFailure<ProductModel>) {
      return ApiResult.failure(createProductResult.exception);
    }

    final ProductModel product =
        (createProductResult as ApiSuccess<ProductModel>).data;

    final ApiResult variantResult = await _variantsRemoteDataSource
        .createVariant(<String, dynamic>{
          'product_id': product.id,
          'unit_type': _unitTypeToDbValue(unitType),
          'quantity': quantity,
          'price': price,
          'is_active': isActive,
        });

    if (variantResult is ApiFailure) {
      // If variant insert fails, remove product to avoid orphan records.
      await _remoteDataSource.deleteProduct(product.id);
      return ApiResult.failure(variantResult.exception);
    }

    return ApiResult.success(product);
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

  String _productTypeToDbValue(ProductTypeEnum type) {
    switch (type) {
      case ProductTypeEnum.simple:
        return 'simple';
      case ProductTypeEnum.bundle:
        return 'bundle';
    }
  }

  String _productCategoryToDbValue(ProductCategoryEnum category) {
    switch (category) {
      case ProductCategoryEnum.fruit:
        return 'Fruit';
      case ProductCategoryEnum.vegetable:
        return 'Vegetable';
      case ProductCategoryEnum.dairy:
        return 'Dairy';
    }
  }

  String _unitTypeToDbValue(UnitTypeEnum type) {
    switch (type) {
      case UnitTypeEnum.kg:
        return 'kg';
      case UnitTypeEnum.g:
        return 'g';
      case UnitTypeEnum.piece:
        return 'piece';
      case UnitTypeEnum.dozen:
        return 'dozen';
      case UnitTypeEnum.bundle:
        return 'bundle';
    }
  }
}
