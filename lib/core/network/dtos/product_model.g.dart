// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: $enumDecode(
        _$ProductCategoryEnumEnumMap,
        json['product_category'],
      ),
      imageUrl: json['image_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      productType:
          $enumDecodeNullable(_$ProductTypeEnumEnumMap, json['product_type']) ??
          ProductTypeEnum.simple,
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'product_category': _$ProductCategoryEnumEnumMap[instance.category]!,
      'image_url': instance.imageUrl,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'product_type': _$ProductTypeEnumEnumMap[instance.productType]!,
    };

const _$ProductCategoryEnumEnumMap = {
  ProductCategoryEnum.fruit: 'Fruit',
  ProductCategoryEnum.vegetable: 'Vegetable',
  ProductCategoryEnum.dairy: 'Dairy',
};

const _$ProductTypeEnumEnumMap = {
  ProductTypeEnum.simple: 'simple',
  ProductTypeEnum.bundle: 'bundle',
};
