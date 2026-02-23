// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => _ShopModel(
  id: json['id'] as String,
  shopName: json['shop_name'] as String,
  shopDescription: json['shop_description'] as String?,
  phone: json['phone'] as String,
  email: json['email'] as String?,
  address: json['address'] as String?,
  serviceablePinCodes: (json['serviceable_pincodes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  openingTime: json['opening_time'] as String,
  closingTime: json['closing_time'] as String,
  isActive: json['is_active'] as bool? ?? true,
  acceptsOrders: json['accepts_orders'] as bool? ?? true,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$ShopModelToJson(_ShopModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_name': instance.shopName,
      'shop_description': instance.shopDescription,
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'serviceable_pincodes': instance.serviceablePinCodes,
      'opening_time': instance.openingTime,
      'closing_time': instance.closingTime,
      'is_active': instance.isActive,
      'accepts_orders': instance.acceptsOrders,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
