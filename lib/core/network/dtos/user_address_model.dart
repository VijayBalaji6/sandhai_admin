import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_address_model.freezed.dart';
part 'user_address_model.g.dart';

@freezed
abstract class UserAddressModel with _$UserAddressModel {
  const factory UserAddressModel({
    required String id,
    @JsonKey(name: 'user_phone') required String userPhone,
    @JsonKey(name: 'address_line') required String addressLine,
    required String pincode,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _UserAddressModel;

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      _$UserAddressModelFromJson(json);
}
