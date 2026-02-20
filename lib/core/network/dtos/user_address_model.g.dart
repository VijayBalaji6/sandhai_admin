// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserAddressModel _$UserAddressModelFromJson(Map<String, dynamic> json) =>
    _UserAddressModel(
      id: json['id'] as String,
      userPhone: json['user_phone'] as String,
      addressLine: json['address_line'] as String,
      pincode: json['pincode'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isDefault: json['is_default'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$UserAddressModelToJson(_UserAddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_phone': instance.userPhone,
      'address_line': instance.addressLine,
      'pincode': instance.pincode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_default': instance.isDefault,
      'created_at': instance.createdAt?.toIso8601String(),
    };
