import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

enum OrderStatusEnum {
  @JsonValue('ordered')
  ordered,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('packed')
  packed,
  @JsonValue('out_for_delivery')
  outForDelivery,
  @JsonValue('delivered')
  delivered,
  @JsonValue('cancelled')
  cancelled,
}

enum PaymentMethodEnum {
  @JsonValue('cod')
  cod,
  @JsonValue('online')
  online,
  @JsonValue('upi')
  upi,
}

enum PaymentStatusEnum {
  @JsonValue('pending')
  pending,
  @JsonValue('paid')
  paid,
  @JsonValue('failed')
  failed,
  @JsonValue('refunded')
  refunded,
}

@freezed
abstract class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    @JsonKey(name: 'user_phone') required String userPhone,
    @JsonKey(name: 'address_id') String? addressId,
    @JsonKey(name: 'delivery_address') required String deliveryAddress,
    @JsonKey(name: 'delivery_pincode') required String deliveryPincode,
    @JsonKey(name: 'delivery_latitude') double? deliveryLatitude,
    @JsonKey(name: 'delivery_longitude') double? deliveryLongitude,
    @Default(OrderStatusEnum.ordered) OrderStatusEnum status,
    @JsonKey(name: 'total_amount') required double totalAmount,
    @JsonKey(name: 'payment_method') required PaymentMethodEnum paymentMethod,
    @JsonKey(name: 'payment_status') @Default(PaymentStatusEnum.pending) PaymentStatusEnum paymentStatus,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
