part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

final class ProductsFetchRequested extends ProductsEvent {
  const ProductsFetchRequested({
    this.category,
    this.isActive,
  });

  final String? category;
  final bool? isActive;

  @override
  List<Object?> get props => [category, isActive];
}

final class ProductsMessageCleared extends ProductsEvent {
  const ProductsMessageCleared();
}
