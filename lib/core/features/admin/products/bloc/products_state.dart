part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, loaded, failure }

final class ProductsState extends Equatable {
  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.successMessage,
  });

  final ProductsStatus status;
  final List<ProductModel> products;
  final String? errorMessage;
  final String? successMessage;

  ProductsState copyWith({
    ProductsStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage:
          clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [status, products, errorMessage, successMessage];
}
