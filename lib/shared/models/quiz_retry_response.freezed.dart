// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_retry_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizRetryResponse {
  String get message;
  @JsonKey(name: 'attempt_status')
  String get attemptStatus;

  /// Create a copy of QuizRetryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuizRetryResponseCopyWith<QuizRetryResponse> get copyWith =>
      _$QuizRetryResponseCopyWithImpl<QuizRetryResponse>(
          this as QuizRetryResponse, _$identity);

  /// Serializes this QuizRetryResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuizRetryResponse &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.attemptStatus, attemptStatus) ||
                other.attemptStatus == attemptStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, attemptStatus);

  @override
  String toString() {
    return 'QuizRetryResponse(message: $message, attemptStatus: $attemptStatus)';
  }
}

/// @nodoc
abstract mixin class $QuizRetryResponseCopyWith<$Res> {
  factory $QuizRetryResponseCopyWith(
          QuizRetryResponse value, $Res Function(QuizRetryResponse) _then) =
      _$QuizRetryResponseCopyWithImpl;
  @useResult
  $Res call(
      {String message, @JsonKey(name: 'attempt_status') String attemptStatus});
}

/// @nodoc
class _$QuizRetryResponseCopyWithImpl<$Res>
    implements $QuizRetryResponseCopyWith<$Res> {
  _$QuizRetryResponseCopyWithImpl(this._self, this._then);

  final QuizRetryResponse _self;
  final $Res Function(QuizRetryResponse) _then;

  /// Create a copy of QuizRetryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? attemptStatus = null,
  }) {
    return _then(QuizRetryResponse(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attemptStatus: null == attemptStatus
          ? _self.attemptStatus
          : attemptStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [QuizRetryResponse].
extension QuizRetryResponsePatterns on QuizRetryResponse {
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
    TResult Function(_QuizRetryResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizRetryResponse() when $default != null:
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
    TResult Function(_QuizRetryResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizRetryResponse():
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
    TResult? Function(_QuizRetryResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizRetryResponse() when $default != null:
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
    TResult Function(String message,
            @JsonKey(name: 'attempt_status') String attemptStatus)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizRetryResponse() when $default != null:
        return $default(_that.message, _that.attemptStatus);
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
    TResult Function(String message,
            @JsonKey(name: 'attempt_status') String attemptStatus)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizRetryResponse():
        return $default(_that.message, _that.attemptStatus);
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
    TResult? Function(String message,
            @JsonKey(name: 'attempt_status') String attemptStatus)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizRetryResponse() when $default != null:
        return $default(_that.message, _that.attemptStatus);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _QuizRetryResponse implements QuizRetryResponse {
  const _QuizRetryResponse(
      {required this.message,
      @JsonKey(name: 'attempt_status') required this.attemptStatus});
  factory _QuizRetryResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizRetryResponseFromJson(json);

  @override
  final String message;
  @override
  @JsonKey(name: 'attempt_status')
  final String attemptStatus;

  /// Create a copy of QuizRetryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuizRetryResponseCopyWith<_QuizRetryResponse> get copyWith =>
      __$QuizRetryResponseCopyWithImpl<_QuizRetryResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuizRetryResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuizRetryResponse &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.attemptStatus, attemptStatus) ||
                other.attemptStatus == attemptStatus));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, attemptStatus);

  @override
  String toString() {
    return 'QuizRetryResponse(message: $message, attemptStatus: $attemptStatus)';
  }
}

/// @nodoc
abstract mixin class _$QuizRetryResponseCopyWith<$Res>
    implements $QuizRetryResponseCopyWith<$Res> {
  factory _$QuizRetryResponseCopyWith(
          _QuizRetryResponse value, $Res Function(_QuizRetryResponse) _then) =
      __$QuizRetryResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String message, @JsonKey(name: 'attempt_status') String attemptStatus});
}

/// @nodoc
class __$QuizRetryResponseCopyWithImpl<$Res>
    implements _$QuizRetryResponseCopyWith<$Res> {
  __$QuizRetryResponseCopyWithImpl(this._self, this._then);

  final _QuizRetryResponse _self;
  final $Res Function(_QuizRetryResponse) _then;

  /// Create a copy of QuizRetryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? attemptStatus = null,
  }) {
    return _then(_QuizRetryResponse(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      attemptStatus: null == attemptStatus
          ? _self.attemptStatus
          : attemptStatus // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
