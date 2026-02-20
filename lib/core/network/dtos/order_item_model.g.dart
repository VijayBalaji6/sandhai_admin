// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    _OrderItemModel(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      productId: json['product_id'] as String,
      variantId: json['variant_id'] as String,
      unitType: $enumDecode(_$UnitTypeEnumEnumMap, json['unit_type']),
      quantity: (json['quantity'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      subtotal: (json['subtotal'] as num).toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$OrderItemModelToJson(_OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'product_id': instance.productId,
      'variant_id': instance.variantId,
      'unit_type': _$UnitTypeEnumEnumMap[instance.unitType]!,
      'quantity': instance.quantity,
      'price': instance.price,
      'subtotal': instance.subtotal,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$UnitTypeEnumEnumMap = {
  UnitTypeEnum.kg: 'kg',
  UnitTypeEnum.g: 'g',
  UnitTypeEnum.piece: 'piece',
  UnitTypeEnum.dozen: 'dozen',
  UnitTypeEnum.bundle: 'bundle',
};
