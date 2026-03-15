import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

enum ProductTypeEnum {
  @JsonValue('simple')
  simple,
  @JsonValue('bundle')
  bundle,
}

enum ProductCategoryEnum {
  @JsonValue('Fruit')
  fruit,
  @JsonValue('Vegetable')
  vegetable,
  @JsonValue('Dairy')
  dairy,
}

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    @JsonKey(name: 'product_category') required ProductCategoryEnum category,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'product_type')
    @Default(ProductTypeEnum.simple)
    ProductTypeEnum productType,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
