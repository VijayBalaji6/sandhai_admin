part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

final class ProductsFetchRequested extends ProductsEvent {
  const ProductsFetchRequested({this.category, this.isActive});

  final String? category;
  final bool? isActive;

  @override
  List<Object?> get props => [category, isActive];
}

final class ProductsCreateRequested extends ProductsEvent {
  const ProductsCreateRequested({
    required this.name,
    required this.category,
    required this.productType,
    required this.unitType,
    required this.quantity,
    required this.price,
    this.imageUrl,
    this.isActive = true,
  });

  final String name;
  final ProductCategoryEnum category;
  final String? imageUrl;
  final bool isActive;
  final ProductTypeEnum productType;
  final UnitTypeEnum unitType;
  final double quantity;
  final double price;

  @override
  List<Object?> get props => [
    name,
    category,
    imageUrl,
    isActive,
    productType,
    unitType,
    quantity,
    price,
  ];
}

final class ProductsMessageCleared extends ProductsEvent {
  const ProductsMessageCleared();
}
