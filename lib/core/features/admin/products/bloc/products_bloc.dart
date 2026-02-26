import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandhai_admin/core/network/dtos/product_model.dart';
import 'package:sandhai_admin/core/network/core/api_exception.dart';
import 'package:sandhai_admin/core/network/core/api_result.dart';
import 'package:sandhai_admin/core/network/repository/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({ProductsRepository? repository})
      : _repository = repository ?? ProductsRepository(),
        super(const ProductsState()) {
    on<ProductsFetchRequested>(_onFetchRequested);
    on<ProductsMessageCleared>(_onMessageCleared);
  }

  final ProductsRepository _repository;

  Future<void> _onFetchRequested(
    ProductsFetchRequested event,
    Emitter<ProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProductsStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    final ApiResult<List<ProductModel>> result =
        await _repository.fetchProducts(
      category: event.category,
      isActive: event.isActive,
      orderBy: 'created_at',
      ascending: false,
    );

    result.when(
      success: (List<ProductModel> products) {
        emit(
          state.copyWith(
            status: ProductsStatus.loaded,
            products: products,
            clearError: true,
            clearSuccess: true,
          ),
        );
      },
      failure: (ApiException exception) {
        emit(
          state.copyWith(
            status: ProductsStatus.failure,
            errorMessage: exception.message,
            clearSuccess: true,
          ),
        );
      },
    );
  }

  void _onMessageCleared(ProductsMessageCleared event, Emitter<ProductsState> emit) {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }
}
