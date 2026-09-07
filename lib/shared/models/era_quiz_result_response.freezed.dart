// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_result_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizResultResponse {
  String? get message;
  @JsonKey(name: 'completed_at')
  String get completedAt;
  EraQuizScore get result;

  /// Create a copy of EraQuizResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizResultResponseCopyWith<EraQuizResultResponse> get copyWith =>
      _$EraQuizResultResponseCopyWithImpl<EraQuizResultResponse>(
          this as EraQuizResultResponse, _$identity);

  /// Serializes this EraQuizResultResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizResultResponse &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, completedAt, result);

  @override
  String toString() {
    return 'EraQuizResultResponse(message: $message, completedAt: $completedAt, result: $result)';
  }
}

/// @nodoc
abstract mixin class $EraQuizResultResponseCopyWith<$Res> {
  factory $EraQuizResultResponseCopyWith(EraQuizResultResponse value,
          $Res Function(EraQuizResultResponse) _then) =
      _$EraQuizResultResponseCopyWithImpl;
  @useResult
  $Res call(
      {String? message,
      @JsonKey(name: 'completed_at') String completedAt,
      EraQuizScore result});

  $EraQuizScoreCopyWith<$Res> get result;
}

/// @nodoc
class _$EraQuizResultResponseCopyWithImpl<$Res>
    implements $EraQuizResultResponseCopyWith<$Res> {
  _$EraQuizResultResponseCopyWithImpl(this._self, this._then);

  final EraQuizResultResponse _self;
  final $Res Function(EraQuizResultResponse) _then;

  /// Create a copy of EraQuizResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? completedAt = null,
    Object? result = null,
  }) {
    return _then(EraQuizResultResponse(
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: null == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as EraQuizScore,
    ));
  }

  /// Create a copy of EraQuizResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EraQuizScoreCopyWith<$Res> get result {
    return $EraQuizScoreCopyWith<$Res>(_self.result, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

/// Adds pattern-matching-related methods to [EraQuizResultResponse].
extension EraQuizResultResponsePatterns on EraQuizResultResponse {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_EraQuizResultResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizResultResponse() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_EraQuizResultResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizResultResponse():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_EraQuizResultResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizResultResponse() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String? message,
            @JsonKey(name: 'completed_at') String completedAt,
            EraQuizScore result)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizResultResponse() when $default != null:
        return $default(_that.message, _that.completedAt, _that.result);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String? message,
            @JsonKey(name: 'completed_at') String completedAt,
            EraQuizScore result)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizResultResponse():
        return $default(_that.message, _that.completedAt, _that.result);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String? message,
            @JsonKey(name: 'completed_at') String completedAt,
            EraQuizScore result)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizResultResponse() when $default != null:
        return $default(_that.message, _that.completedAt, _that.result);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizResultResponse implements EraQuizResultResponse {
  const _EraQuizResultResponse(
      {this.message,
      @JsonKey(name: 'completed_at') required this.completedAt,
      required this.result});
  factory _EraQuizResultResponse.fromJson(Map<String, dynamic> json) =>
      _$EraQuizResultResponseFromJson(json);

  @override
  final String? message;
  @override
  @JsonKey(name: 'completed_at')
  final String completedAt;
  @override
  final EraQuizScore result;

  /// Create a copy of EraQuizResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizResultResponseCopyWith<_EraQuizResultResponse> get copyWith =>
      __$EraQuizResultResponseCopyWithImpl<_EraQuizResultResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizResultResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizResultResponse &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, completedAt, result);

  @override
  String toString() {
    return 'EraQuizResultResponse(message: $message, completedAt: $completedAt, result: $result)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizResultResponseCopyWith<$Res>
    implements $EraQuizResultResponseCopyWith<$Res> {
  factory _$EraQuizResultResponseCopyWith(_EraQuizResultResponse value,
          $Res Function(_EraQuizResultResponse) _then) =
      __$EraQuizResultResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? message,
      @JsonKey(name: 'completed_at') String completedAt,
      EraQuizScore result});

  @override
  $EraQuizScoreCopyWith<$Res> get result;
}

/// @nodoc
class __$EraQuizResultResponseCopyWithImpl<$Res>
    implements _$EraQuizResultResponseCopyWith<$Res> {
  __$EraQuizResultResponseCopyWithImpl(this._self, this._then);

  final _EraQuizResultResponse _self;
  final $Res Function(_EraQuizResultResponse) _then;

  /// Create a copy of EraQuizResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = freezed,
    Object? completedAt = null,
    Object? result = null,
  }) {
    return _then(_EraQuizResultResponse(
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: null == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
      result: null == result
          ? _self.result
          : result // ignore: cast_nullable_to_non_nullable
              as EraQuizScore,
    ));
  }

  /// Create a copy of EraQuizResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EraQuizScoreCopyWith<$Res> get result {
    return $EraQuizScoreCopyWith<$Res>(_self.result, (value) {
      return _then(_self.copyWith(result: value));
    });
  }
}

// dart format on
