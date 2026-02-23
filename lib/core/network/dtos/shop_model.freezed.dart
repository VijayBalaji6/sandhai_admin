// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ShopModel {

 String get id;@JsonKey(name: 'shop_name') String get shopName;@JsonKey(name: 'shop_description') String? get shopDescription; String get phone; String? get email; String? get address;@JsonKey(name: 'serviceable_pincodes') List<String> get serviceablePinCodes;@JsonKey(name: 'opening_time') String get openingTime;@JsonKey(name: 'closing_time') String get closingTime;@JsonKey(name: 'is_active') bool get isActive;@JsonKey(name: 'accepts_orders') bool get acceptsOrders;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShopModelCopyWith<ShopModel> get copyWith => _$ShopModelCopyWithImpl<ShopModel>(this as ShopModel, _$identity);

  /// Serializes this ShopModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopDescription, shopDescription) || other.shopDescription == shopDescription)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.serviceablePinCodes, serviceablePinCodes)&&(identical(other.openingTime, openingTime) || other.openingTime == openingTime)&&(identical(other.closingTime, closingTime) || other.closingTime == closingTime)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.acceptsOrders, acceptsOrders) || other.acceptsOrders == acceptsOrders)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shopName,shopDescription,phone,email,address,const DeepCollectionEquality().hash(serviceablePinCodes),openingTime,closingTime,isActive,acceptsOrders,createdAt,updatedAt);

@override
String toString() {
  return 'ShopModel(id: $id, shopName: $shopName, shopDescription: $shopDescription, phone: $phone, email: $email, address: $address, serviceablePinCodes: $serviceablePinCodes, openingTime: $openingTime, closingTime: $closingTime, isActive: $isActive, acceptsOrders: $acceptsOrders, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ShopModelCopyWith<$Res>  {
  factory $ShopModelCopyWith(ShopModel value, $Res Function(ShopModel) _then) = _$ShopModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'shop_name') String shopName,@JsonKey(name: 'shop_description') String? shopDescription, String phone, String? email, String? address,@JsonKey(name: 'serviceable_pincodes') List<String> serviceablePinCodes,@JsonKey(name: 'opening_time') String openingTime,@JsonKey(name: 'closing_time') String closingTime,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'accepts_orders') bool acceptsOrders,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$ShopModelCopyWithImpl<$Res>
    implements $ShopModelCopyWith<$Res> {
  _$ShopModelCopyWithImpl(this._self, this._then);

  final ShopModel _self;
  final $Res Function(ShopModel) _then;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shopName = null,Object? shopDescription = freezed,Object? phone = null,Object? email = freezed,Object? address = freezed,Object? serviceablePinCodes = null,Object? openingTime = null,Object? closingTime = null,Object? isActive = null,Object? acceptsOrders = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopDescription: freezed == shopDescription ? _self.shopDescription : shopDescription // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,serviceablePinCodes: null == serviceablePinCodes ? _self.serviceablePinCodes : serviceablePinCodes // ignore: cast_nullable_to_non_nullable
as List<String>,openingTime: null == openingTime ? _self.openingTime : openingTime // ignore: cast_nullable_to_non_nullable
as String,closingTime: null == closingTime ? _self.closingTime : closingTime // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,acceptsOrders: null == acceptsOrders ? _self.acceptsOrders : acceptsOrders // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ShopModel].
extension ShopModelPatterns on ShopModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShopModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShopModel value)  $default,){
final _that = this;
switch (_that) {
case _ShopModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShopModel value)?  $default,){
final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'shop_name')  String shopName, @JsonKey(name: 'shop_description')  String? shopDescription,  String phone,  String? email,  String? address, @JsonKey(name: 'serviceable_pincodes')  List<String> serviceablePinCodes, @JsonKey(name: 'opening_time')  String openingTime, @JsonKey(name: 'closing_time')  String closingTime, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'accepts_orders')  bool acceptsOrders, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
return $default(_that.id,_that.shopName,_that.shopDescription,_that.phone,_that.email,_that.address,_that.serviceablePinCodes,_that.openingTime,_that.closingTime,_that.isActive,_that.acceptsOrders,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'shop_name')  String shopName, @JsonKey(name: 'shop_description')  String? shopDescription,  String phone,  String? email,  String? address, @JsonKey(name: 'serviceable_pincodes')  List<String> serviceablePinCodes, @JsonKey(name: 'opening_time')  String openingTime, @JsonKey(name: 'closing_time')  String closingTime, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'accepts_orders')  bool acceptsOrders, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _ShopModel():
return $default(_that.id,_that.shopName,_that.shopDescription,_that.phone,_that.email,_that.address,_that.serviceablePinCodes,_that.openingTime,_that.closingTime,_that.isActive,_that.acceptsOrders,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'shop_name')  String shopName, @JsonKey(name: 'shop_description')  String? shopDescription,  String phone,  String? email,  String? address, @JsonKey(name: 'serviceable_pincodes')  List<String> serviceablePinCodes, @JsonKey(name: 'opening_time')  String openingTime, @JsonKey(name: 'closing_time')  String closingTime, @JsonKey(name: 'is_active')  bool isActive, @JsonKey(name: 'accepts_orders')  bool acceptsOrders, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _ShopModel() when $default != null:
return $default(_that.id,_that.shopName,_that.shopDescription,_that.phone,_that.email,_that.address,_that.serviceablePinCodes,_that.openingTime,_that.closingTime,_that.isActive,_that.acceptsOrders,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ShopModel implements ShopModel {
  const _ShopModel({required this.id, @JsonKey(name: 'shop_name') required this.shopName, @JsonKey(name: 'shop_description') this.shopDescription, required this.phone, this.email, this.address, @JsonKey(name: 'serviceable_pincodes') required final  List<String> serviceablePinCodes, @JsonKey(name: 'opening_time') required this.openingTime, @JsonKey(name: 'closing_time') required this.closingTime, @JsonKey(name: 'is_active') this.isActive = true, @JsonKey(name: 'accepts_orders') this.acceptsOrders = true, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): _serviceablePinCodes = serviceablePinCodes;
  factory _ShopModel.fromJson(Map<String, dynamic> json) => _$ShopModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'shop_name') final  String shopName;
@override@JsonKey(name: 'shop_description') final  String? shopDescription;
@override final  String phone;
@override final  String? email;
@override final  String? address;
 final  List<String> _serviceablePinCodes;
@override@JsonKey(name: 'serviceable_pincodes') List<String> get serviceablePinCodes {
  if (_serviceablePinCodes is EqualUnmodifiableListView) return _serviceablePinCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceablePinCodes);
}

@override@JsonKey(name: 'opening_time') final  String openingTime;
@override@JsonKey(name: 'closing_time') final  String closingTime;
@override@JsonKey(name: 'is_active') final  bool isActive;
@override@JsonKey(name: 'accepts_orders') final  bool acceptsOrders;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShopModelCopyWith<_ShopModel> get copyWith => __$ShopModelCopyWithImpl<_ShopModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShopModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShopModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopName, shopName) || other.shopName == shopName)&&(identical(other.shopDescription, shopDescription) || other.shopDescription == shopDescription)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._serviceablePinCodes, _serviceablePinCodes)&&(identical(other.openingTime, openingTime) || other.openingTime == openingTime)&&(identical(other.closingTime, closingTime) || other.closingTime == closingTime)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.acceptsOrders, acceptsOrders) || other.acceptsOrders == acceptsOrders)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shopName,shopDescription,phone,email,address,const DeepCollectionEquality().hash(_serviceablePinCodes),openingTime,closingTime,isActive,acceptsOrders,createdAt,updatedAt);

@override
String toString() {
  return 'ShopModel(id: $id, shopName: $shopName, shopDescription: $shopDescription, phone: $phone, email: $email, address: $address, serviceablePinCodes: $serviceablePinCodes, openingTime: $openingTime, closingTime: $closingTime, isActive: $isActive, acceptsOrders: $acceptsOrders, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ShopModelCopyWith<$Res> implements $ShopModelCopyWith<$Res> {
  factory _$ShopModelCopyWith(_ShopModel value, $Res Function(_ShopModel) _then) = __$ShopModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'shop_name') String shopName,@JsonKey(name: 'shop_description') String? shopDescription, String phone, String? email, String? address,@JsonKey(name: 'serviceable_pincodes') List<String> serviceablePinCodes,@JsonKey(name: 'opening_time') String openingTime,@JsonKey(name: 'closing_time') String closingTime,@JsonKey(name: 'is_active') bool isActive,@JsonKey(name: 'accepts_orders') bool acceptsOrders,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$ShopModelCopyWithImpl<$Res>
    implements _$ShopModelCopyWith<$Res> {
  __$ShopModelCopyWithImpl(this._self, this._then);

  final _ShopModel _self;
  final $Res Function(_ShopModel) _then;

/// Create a copy of ShopModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopName = null,Object? shopDescription = freezed,Object? phone = null,Object? email = freezed,Object? address = freezed,Object? serviceablePinCodes = null,Object? openingTime = null,Object? closingTime = null,Object? isActive = null,Object? acceptsOrders = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_ShopModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopName: null == shopName ? _self.shopName : shopName // ignore: cast_nullable_to_non_nullable
as String,shopDescription: freezed == shopDescription ? _self.shopDescription : shopDescription // ignore: cast_nullable_to_non_nullable
as String?,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,serviceablePinCodes: null == serviceablePinCodes ? _self._serviceablePinCodes : serviceablePinCodes // ignore: cast_nullable_to_non_nullable
as List<String>,openingTime: null == openingTime ? _self.openingTime : openingTime // ignore: cast_nullable_to_non_nullable
as String,closingTime: null == closingTime ? _self.closingTime : closingTime // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,acceptsOrders: null == acceptsOrders ? _self.acceptsOrders : acceptsOrders // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
