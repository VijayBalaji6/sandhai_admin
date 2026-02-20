import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_model.freezed.dart';
part 'order_item_model.g.dart';

enum UnitTypeEnum {
  @JsonValue('kg')
  kg,
  @JsonValue('g')
  g,
  @JsonValue('piece')
  piece,
  @JsonValue('dozen')
  dozen,
  @JsonValue('bundle')
  bundle,
}

@freezed
abstract class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required String id,
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'variant_id') required String variantId,
    @JsonKey(name: 'unit_type') required UnitTypeEnum unitType,
    required double quantity,
    required double price,
    required double subtotal,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}
