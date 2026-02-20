// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductVariantModel _$ProductVariantModelFromJson(Map<String, dynamic> json) =>
    _ProductVariantModel(
      id: json['id'] as String,
      productId: json['product_id'] as String?,
      unitType: $enumDecode(_$UnitTypeEnumEnumMap, json['unit_type']),
      quantity: (json['quantity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ProductVariantModelToJson(
  _ProductVariantModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'product_id': instance.productId,
  'unit_type': _$UnitTypeEnumEnumMap[instance.unitType]!,
  'quantity': instance.quantity,
  'price': instance.price,
  'is_active': instance.isActive,
  'created_at': instance.createdAt?.toIso8601String(),
};

const _$UnitTypeEnumEnumMap = {
  UnitTypeEnum.kg: 'kg',
  UnitTypeEnum.g: 'g',
  UnitTypeEnum.piece: 'piece',
  UnitTypeEnum.dozen: 'dozen',
  UnitTypeEnum.bundle: 'bundle',
};
