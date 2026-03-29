import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

enum OrderStatusEnum {
  @JsonValue('ordered')
  ordered,
  @JsonValue('accepted')
  accepted,
  @JsonValue('packing')
  packing,
  @JsonValue('outfordelivery')
  outForDelivery,
  @JsonValue('delivered')
  delivered,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('undelivered')
  undelivered,
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

extension OrderStatusX on OrderStatusEnum {
  bool get isCurrent =>
      this == OrderStatusEnum.ordered ||
      this == OrderStatusEnum.accepted ||
      this == OrderStatusEnum.packing ||
      this == OrderStatusEnum.outForDelivery ||
      this == OrderStatusEnum.delivered;

  bool get isCompleted =>
      this == OrderStatusEnum.cancelled ||
      this == OrderStatusEnum.undelivered;

  String get label {
    switch (this) {
      case OrderStatusEnum.ordered:
        return 'Ordered';
      case OrderStatusEnum.accepted:
        return 'Accepted';
      case OrderStatusEnum.packing:
        return 'Packing';
      case OrderStatusEnum.outForDelivery:
        return 'Out for delivery';
      case OrderStatusEnum.delivered:
        return 'Delivered';
      case OrderStatusEnum.cancelled:
        return 'Cancelled';
      case OrderStatusEnum.undelivered:
        return 'Undelivered';
    }
  }
}
