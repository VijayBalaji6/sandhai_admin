// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderModel {

 String get id;@JsonKey(name: 'shop_id') String? get shopId;@JsonKey(name: 'user_phone') String get userPhone;@JsonKey(name: 'address_id') String? get addressId; OrderStatusEnum get status;@JsonKey(name: 'total_amount') double get totalAmount;@JsonKey(name: 'payment_method') PaymentMethodEnum get paymentMethod;@JsonKey(name: 'payment_status') PaymentStatusEnum get paymentStatus;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderModelCopyWith<OrderModel> get copyWith => _$OrderModelCopyWithImpl<OrderModel>(this as OrderModel, _$identity);

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.userPhone, userPhone) || other.userPhone == userPhone)&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shopId,userPhone,addressId,status,totalAmount,paymentMethod,paymentStatus,createdAt,updatedAt);

@override
String toString() {
  return 'OrderModel(id: $id, shopId: $shopId, userPhone: $userPhone, addressId: $addressId, status: $status, totalAmount: $totalAmount, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $OrderModelCopyWith<$Res>  {
  factory $OrderModelCopyWith(OrderModel value, $Res Function(OrderModel) _then) = _$OrderModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'shop_id') String? shopId,@JsonKey(name: 'user_phone') String userPhone,@JsonKey(name: 'address_id') String? addressId, OrderStatusEnum status,@JsonKey(name: 'total_amount') double totalAmount,@JsonKey(name: 'payment_method') PaymentMethodEnum paymentMethod,@JsonKey(name: 'payment_status') PaymentStatusEnum paymentStatus,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$OrderModelCopyWithImpl<$Res>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._self, this._then);

  final OrderModel _self;
  final $Res Function(OrderModel) _then;

/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shopId = freezed,Object? userPhone = null,Object? addressId = freezed,Object? status = null,Object? totalAmount = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,userPhone: null == userPhone ? _self.userPhone : userPhone // ignore: cast_nullable_to_non_nullable
as String,addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatusEnum,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethodEnum,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatusEnum,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderModel].
extension OrderModelPatterns on OrderModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrderModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrderModel value)  $default,){
final _that = this;
switch (_that) {
case _OrderModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrderModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'shop_id')  String? shopId, @JsonKey(name: 'user_phone')  String userPhone, @JsonKey(name: 'address_id')  String? addressId,  OrderStatusEnum status, @JsonKey(name: 'total_amount')  double totalAmount, @JsonKey(name: 'payment_method')  PaymentMethodEnum paymentMethod, @JsonKey(name: 'payment_status')  PaymentStatusEnum paymentStatus, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that.id,_that.shopId,_that.userPhone,_that.addressId,_that.status,_that.totalAmount,_that.paymentMethod,_that.paymentStatus,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'shop_id')  String? shopId, @JsonKey(name: 'user_phone')  String userPhone, @JsonKey(name: 'address_id')  String? addressId,  OrderStatusEnum status, @JsonKey(name: 'total_amount')  double totalAmount, @JsonKey(name: 'payment_method')  PaymentMethodEnum paymentMethod, @JsonKey(name: 'payment_status')  PaymentStatusEnum paymentStatus, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _OrderModel():
return $default(_that.id,_that.shopId,_that.userPhone,_that.addressId,_that.status,_that.totalAmount,_that.paymentMethod,_that.paymentStatus,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'shop_id')  String? shopId, @JsonKey(name: 'user_phone')  String userPhone, @JsonKey(name: 'address_id')  String? addressId,  OrderStatusEnum status, @JsonKey(name: 'total_amount')  double totalAmount, @JsonKey(name: 'payment_method')  PaymentMethodEnum paymentMethod, @JsonKey(name: 'payment_status')  PaymentStatusEnum paymentStatus, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _OrderModel() when $default != null:
return $default(_that.id,_that.shopId,_that.userPhone,_that.addressId,_that.status,_that.totalAmount,_that.paymentMethod,_that.paymentStatus,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrderModel implements OrderModel {
  const _OrderModel({required this.id, @JsonKey(name: 'shop_id') this.shopId, @JsonKey(name: 'user_phone') required this.userPhone, @JsonKey(name: 'address_id') this.addressId, this.status = OrderStatusEnum.ordered, @JsonKey(name: 'total_amount') required this.totalAmount, @JsonKey(name: 'payment_method') required this.paymentMethod, @JsonKey(name: 'payment_status') this.paymentStatus = PaymentStatusEnum.pending, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'shop_id') final  String? shopId;
@override@JsonKey(name: 'user_phone') final  String userPhone;
@override@JsonKey(name: 'address_id') final  String? addressId;
@override@JsonKey() final  OrderStatusEnum status;
@override@JsonKey(name: 'total_amount') final  double totalAmount;
@override@JsonKey(name: 'payment_method') final  PaymentMethodEnum paymentMethod;
@override@JsonKey(name: 'payment_status') final  PaymentStatusEnum paymentStatus;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrderModelCopyWith<_OrderModel> get copyWith => __$OrderModelCopyWithImpl<_OrderModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrderModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrderModel&&(identical(other.id, id) || other.id == id)&&(identical(other.shopId, shopId) || other.shopId == shopId)&&(identical(other.userPhone, userPhone) || other.userPhone == userPhone)&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.status, status) || other.status == status)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shopId,userPhone,addressId,status,totalAmount,paymentMethod,paymentStatus,createdAt,updatedAt);

@override
String toString() {
  return 'OrderModel(id: $id, shopId: $shopId, userPhone: $userPhone, addressId: $addressId, status: $status, totalAmount: $totalAmount, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$OrderModelCopyWith<$Res> implements $OrderModelCopyWith<$Res> {
  factory _$OrderModelCopyWith(_OrderModel value, $Res Function(_OrderModel) _then) = __$OrderModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'shop_id') String? shopId,@JsonKey(name: 'user_phone') String userPhone,@JsonKey(name: 'address_id') String? addressId, OrderStatusEnum status,@JsonKey(name: 'total_amount') double totalAmount,@JsonKey(name: 'payment_method') PaymentMethodEnum paymentMethod,@JsonKey(name: 'payment_status') PaymentStatusEnum paymentStatus,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$OrderModelCopyWithImpl<$Res>
    implements _$OrderModelCopyWith<$Res> {
  __$OrderModelCopyWithImpl(this._self, this._then);

  final _OrderModel _self;
  final $Res Function(_OrderModel) _then;

/// Create a copy of OrderModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shopId = freezed,Object? userPhone = null,Object? addressId = freezed,Object? status = null,Object? totalAmount = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_OrderModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,shopId: freezed == shopId ? _self.shopId : shopId // ignore: cast_nullable_to_non_nullable
as String?,userPhone: null == userPhone ? _self.userPhone : userPhone // ignore: cast_nullable_to_non_nullable
as String,addressId: freezed == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatusEnum,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethodEnum,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatusEnum,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
