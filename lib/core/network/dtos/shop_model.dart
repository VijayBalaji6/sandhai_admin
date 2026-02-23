import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_model.freezed.dart';
part 'shop_model.g.dart';

@freezed
abstract class ShopModel with _$ShopModel {
  const factory ShopModel({
    required String id,
    @JsonKey(name: 'shop_name') required String shopName,
    @JsonKey(name: 'shop_description') String? shopDescription,
    required String phone,
    String? email,
    String? address,
    @JsonKey(name: 'serviceable_pincodes')
    required List<String> serviceablePinCodes,
    @JsonKey(name: 'opening_time') required String openingTime,
    @JsonKey(name: 'closing_time') required String closingTime,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'accepts_orders') @Default(true) bool acceptsOrders,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ShopModel;

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);
}
