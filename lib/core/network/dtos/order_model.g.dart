// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => _OrderModel(
  id: json['id'] as String,
  userPhone: json['user_phone'] as String,
  addressId: json['address_id'] as String?,
  status:
      $enumDecodeNullable(_$OrderStatusEnumEnumMap, json['status']) ??
      OrderStatusEnum.ordered,
  totalAmount: (json['total_amount'] as num).toDouble(),
  paymentMethod: $enumDecode(
    _$PaymentMethodEnumEnumMap,
    json['payment_method'],
  ),
  paymentStatus:
      $enumDecodeNullable(_$PaymentStatusEnumEnumMap, json['payment_status']) ??
      PaymentStatusEnum.pending,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$OrderModelToJson(_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_phone': instance.userPhone,
      'address_id': instance.addressId,
      'status': _$OrderStatusEnumEnumMap[instance.status]!,
      'total_amount': instance.totalAmount,
      'payment_method': _$PaymentMethodEnumEnumMap[instance.paymentMethod]!,
      'payment_status': _$PaymentStatusEnumEnumMap[instance.paymentStatus]!,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$OrderStatusEnumEnumMap = {
  OrderStatusEnum.ordered: 'ordered',
  OrderStatusEnum.accepted: 'accepted',
  OrderStatusEnum.packing: 'packing',
  OrderStatusEnum.outForDelivery: 'outfordelivery',
  OrderStatusEnum.delivered: 'delivered',
  OrderStatusEnum.cancelled: 'cancelled',
  OrderStatusEnum.undelivered: 'undelivered',
};

const _$PaymentMethodEnumEnumMap = {
  PaymentMethodEnum.cod: 'cod',
  PaymentMethodEnum.online: 'online',
  PaymentMethodEnum.upi: 'upi',
};

const _$PaymentStatusEnumEnumMap = {
  PaymentStatusEnum.pending: 'pending',
  PaymentStatusEnum.paid: 'paid',
  PaymentStatusEnum.failed: 'failed',
  PaymentStatusEnum.refunded: 'refunded',
};
