// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserAddressModel {

 String get id;@JsonKey(name: 'user_phone') String get userPhone;@JsonKey(name: 'address_line') String get addressLine; String get pincode; double? get latitude; double? get longitude;@JsonKey(name: 'is_default') bool get isDefault;@JsonKey(name: 'created_at') DateTime? get createdAt;
/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAddressModelCopyWith<UserAddressModel> get copyWith => _$UserAddressModelCopyWithImpl<UserAddressModel>(this as UserAddressModel, _$identity);

  /// Serializes this UserAddressModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAddressModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userPhone, userPhone) || other.userPhone == userPhone)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userPhone,addressLine,pincode,latitude,longitude,isDefault,createdAt);

@override
String toString() {
  return 'UserAddressModel(id: $id, userPhone: $userPhone, addressLine: $addressLine, pincode: $pincode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserAddressModelCopyWith<$Res>  {
  factory $UserAddressModelCopyWith(UserAddressModel value, $Res Function(UserAddressModel) _then) = _$UserAddressModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_phone') String userPhone,@JsonKey(name: 'address_line') String addressLine, String pincode, double? latitude, double? longitude,@JsonKey(name: 'is_default') bool isDefault,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class _$UserAddressModelCopyWithImpl<$Res>
    implements $UserAddressModelCopyWith<$Res> {
  _$UserAddressModelCopyWithImpl(this._self, this._then);

  final UserAddressModel _self;
  final $Res Function(UserAddressModel) _then;

/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userPhone = null,Object? addressLine = null,Object? pincode = null,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userPhone: null == userPhone ? _self.userPhone : userPhone // ignore: cast_nullable_to_non_nullable
as String,addressLine: null == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String,pincode: null == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAddressModel].
extension UserAddressModelPatterns on UserAddressModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAddressModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAddressModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAddressModel value)  $default,){
final _that = this;
switch (_that) {
case _UserAddressModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAddressModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserAddressModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_phone')  String userPhone, @JsonKey(name: 'address_line')  String addressLine,  String pincode,  double? latitude,  double? longitude, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAddressModel() when $default != null:
return $default(_that.id,_that.userPhone,_that.addressLine,_that.pincode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_phone')  String userPhone, @JsonKey(name: 'address_line')  String addressLine,  String pincode,  double? latitude,  double? longitude, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserAddressModel():
return $default(_that.id,_that.userPhone,_that.addressLine,_that.pincode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_phone')  String userPhone, @JsonKey(name: 'address_line')  String addressLine,  String pincode,  double? latitude,  double? longitude, @JsonKey(name: 'is_default')  bool isDefault, @JsonKey(name: 'created_at')  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserAddressModel() when $default != null:
return $default(_that.id,_that.userPhone,_that.addressLine,_that.pincode,_that.latitude,_that.longitude,_that.isDefault,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserAddressModel implements UserAddressModel {
  const _UserAddressModel({required this.id, @JsonKey(name: 'user_phone') required this.userPhone, @JsonKey(name: 'address_line') required this.addressLine, required this.pincode, this.latitude, this.longitude, @JsonKey(name: 'is_default') this.isDefault = false, @JsonKey(name: 'created_at') this.createdAt});
  factory _UserAddressModel.fromJson(Map<String, dynamic> json) => _$UserAddressModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_phone') final  String userPhone;
@override@JsonKey(name: 'address_line') final  String addressLine;
@override final  String pincode;
@override final  double? latitude;
@override final  double? longitude;
@override@JsonKey(name: 'is_default') final  bool isDefault;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;

/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAddressModelCopyWith<_UserAddressModel> get copyWith => __$UserAddressModelCopyWithImpl<_UserAddressModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserAddressModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAddressModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userPhone, userPhone) || other.userPhone == userPhone)&&(identical(other.addressLine, addressLine) || other.addressLine == addressLine)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userPhone,addressLine,pincode,latitude,longitude,isDefault,createdAt);

@override
String toString() {
  return 'UserAddressModel(id: $id, userPhone: $userPhone, addressLine: $addressLine, pincode: $pincode, latitude: $latitude, longitude: $longitude, isDefault: $isDefault, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserAddressModelCopyWith<$Res> implements $UserAddressModelCopyWith<$Res> {
  factory _$UserAddressModelCopyWith(_UserAddressModel value, $Res Function(_UserAddressModel) _then) = __$UserAddressModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_phone') String userPhone,@JsonKey(name: 'address_line') String addressLine, String pincode, double? latitude, double? longitude,@JsonKey(name: 'is_default') bool isDefault,@JsonKey(name: 'created_at') DateTime? createdAt
});




}
/// @nodoc
class __$UserAddressModelCopyWithImpl<$Res>
    implements _$UserAddressModelCopyWith<$Res> {
  __$UserAddressModelCopyWithImpl(this._self, this._then);

  final _UserAddressModel _self;
  final $Res Function(_UserAddressModel) _then;

/// Create a copy of UserAddressModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userPhone = null,Object? addressLine = null,Object? pincode = null,Object? latitude = freezed,Object? longitude = freezed,Object? isDefault = null,Object? createdAt = freezed,}) {
  return _then(_UserAddressModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userPhone: null == userPhone ? _self.userPhone : userPhone // ignore: cast_nullable_to_non_nullable
as String,addressLine: null == addressLine ? _self.addressLine : addressLine // ignore: cast_nullable_to_non_nullable
as String,pincode: null == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
