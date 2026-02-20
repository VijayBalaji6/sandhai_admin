// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiResult<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiResult<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ApiResult<$T>()';
}


}

/// @nodoc
class $ApiResultCopyWith<T,$Res>  {
$ApiResultCopyWith(ApiResult<T> _, $Res Function(ApiResult<T>) __);
}


/// Adds pattern-matching-related methods to [ApiResult].
extension ApiResultPatterns<T> on ApiResult<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ApiSuccess<T> value)?  success,TResult Function( ApiFailure<T> value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ApiSuccess() when success != null:
return success(_that);case ApiFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ApiSuccess<T> value)  success,required TResult Function( ApiFailure<T> value)  failure,}){
final _that = this;
switch (_that) {
case ApiSuccess():
return success(_that);case ApiFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ApiSuccess<T> value)?  success,TResult? Function( ApiFailure<T> value)?  failure,}){
final _that = this;
switch (_that) {
case ApiSuccess() when success != null:
return success(_that);case ApiFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T data)?  success,TResult Function( ApiException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ApiSuccess() when success != null:
return success(_that.data);case ApiFailure() when failure != null:
return failure(_that.exception);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T data)  success,required TResult Function( ApiException exception)  failure,}) {final _that = this;
switch (_that) {
case ApiSuccess():
return success(_that.data);case ApiFailure():
return failure(_that.exception);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T data)?  success,TResult? Function( ApiException exception)?  failure,}) {final _that = this;
switch (_that) {
case ApiSuccess() when success != null:
return success(_that.data);case ApiFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class ApiSuccess<T> implements ApiResult<T> {
  const ApiSuccess(this.data);
  

 final  T data;

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiSuccessCopyWith<T, ApiSuccess<T>> get copyWith => _$ApiSuccessCopyWithImpl<T, ApiSuccess<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiSuccess<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'ApiResult<$T>.success(data: $data)';
}


}

/// @nodoc
abstract mixin class $ApiSuccessCopyWith<T,$Res> implements $ApiResultCopyWith<T, $Res> {
  factory $ApiSuccessCopyWith(ApiSuccess<T> value, $Res Function(ApiSuccess<T>) _then) = _$ApiSuccessCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$ApiSuccessCopyWithImpl<T,$Res>
    implements $ApiSuccessCopyWith<T, $Res> {
  _$ApiSuccessCopyWithImpl(this._self, this._then);

  final ApiSuccess<T> _self;
  final $Res Function(ApiSuccess<T>) _then;

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(ApiSuccess<T>(
freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class ApiFailure<T> implements ApiResult<T> {
  const ApiFailure(this.exception);
  

 final  ApiException exception;

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiFailureCopyWith<T, ApiFailure<T>> get copyWith => _$ApiFailureCopyWithImpl<T, ApiFailure<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiFailure<T>&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'ApiResult<$T>.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $ApiFailureCopyWith<T,$Res> implements $ApiResultCopyWith<T, $Res> {
  factory $ApiFailureCopyWith(ApiFailure<T> value, $Res Function(ApiFailure<T>) _then) = _$ApiFailureCopyWithImpl;
@useResult
$Res call({
 ApiException exception
});




}
/// @nodoc
class _$ApiFailureCopyWithImpl<T,$Res>
    implements $ApiFailureCopyWith<T, $Res> {
  _$ApiFailureCopyWithImpl(this._self, this._then);

  final ApiFailure<T> _self;
  final $Res Function(ApiFailure<T>) _then;

/// Create a copy of ApiResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(ApiFailure<T>(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as ApiException,
  ));
}


}

// dart format on
