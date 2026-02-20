import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item_model.dart';

part 'product_variant_model.freezed.dart';
part 'product_variant_model.g.dart';

@freezed
abstract class ProductVariantModel with _$ProductVariantModel {
  const factory ProductVariantModel({
    required String id,
    @JsonKey(name: 'product_id') String? productId,
    @JsonKey(name: 'unit_type') required UnitTypeEnum unitType,
    required double quantity,
    required double price,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ProductVariantModel;

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantModelFromJson(json);
}
