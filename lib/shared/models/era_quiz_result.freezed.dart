// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizResult {
  int get correct;
  int get total;
  double get percentage;
  @JsonKey(name: 'completed_at')
  String get completedAt;
  String? get message;

  /// Create a copy of EraQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizResultCopyWith<EraQuizResult> get copyWith =>
      _$EraQuizResultCopyWithImpl<EraQuizResult>(
          this as EraQuizResult, _$identity);

  /// Serializes this EraQuizResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizResult &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, correct, total, percentage, completedAt, message);

  @override
  String toString() {
    return 'EraQuizResult(correct: $correct, total: $total, percentage: $percentage, completedAt: $completedAt, message: $message)';
  }
}

/// @nodoc
abstract mixin class $EraQuizResultCopyWith<$Res> {
  factory $EraQuizResultCopyWith(
          EraQuizResult value, $Res Function(EraQuizResult) _then) =
      _$EraQuizResultCopyWithImpl;
  @useResult
  $Res call(
      {int correct,
      int total,
      double percentage,
      @JsonKey(name: 'completed_at') String completedAt,
      String? message});
}

/// @nodoc
class _$EraQuizResultCopyWithImpl<$Res>
    implements $EraQuizResultCopyWith<$Res> {
  _$EraQuizResultCopyWithImpl(this._self, this._then);

  final EraQuizResult _self;
  final $Res Function(EraQuizResult) _then;

  /// Create a copy of EraQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? correct = null,
    Object? total = null,
    Object? percentage = null,
    Object? completedAt = null,
    Object? message = freezed,
  }) {
    return _then(EraQuizResult(
      correct: null == correct
          ? _self.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _self.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      completedAt: null == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizResult].
extension EraQuizResultPatterns on EraQuizResult {
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
    TResult Function(_EraQuizResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizResult() when $default != null:
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
    TResult Function(_EraQuizResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizResult():
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
    TResult? Function(_EraQuizResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizResult() when $default != null:
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
    TResult Function(int correct, int total, double percentage,
            @JsonKey(name: 'completed_at') String completedAt, String? message)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizResult() when $default != null:
        return $default(_that.correct, _that.total, _that.percentage,
            _that.completedAt, _that.message);
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
    TResult Function(int correct, int total, double percentage,
            @JsonKey(name: 'completed_at') String completedAt, String? message)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizResult():
        return $default(_that.correct, _that.total, _that.percentage,
            _that.completedAt, _that.message);
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
    TResult? Function(int correct, int total, double percentage,
            @JsonKey(name: 'completed_at') String completedAt, String? message)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizResult() when $default != null:
        return $default(_that.correct, _that.total, _that.percentage,
            _that.completedAt, _that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizResult implements EraQuizResult {
  const _EraQuizResult(
      {required this.correct,
      required this.total,
      required this.percentage,
      @JsonKey(name: 'completed_at') required this.completedAt,
      this.message});
  factory _EraQuizResult.fromJson(Map<String, dynamic> json) =>
      _$EraQuizResultFromJson(json);

  @override
  final int correct;
  @override
  final int total;
  @override
  final double percentage;
  @override
  @JsonKey(name: 'completed_at')
  final String completedAt;
  @override
  final String? message;

  /// Create a copy of EraQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizResultCopyWith<_EraQuizResult> get copyWith =>
      __$EraQuizResultCopyWithImpl<_EraQuizResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizResult &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, correct, total, percentage, completedAt, message);

  @override
  String toString() {
    return 'EraQuizResult(correct: $correct, total: $total, percentage: $percentage, completedAt: $completedAt, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizResultCopyWith<$Res>
    implements $EraQuizResultCopyWith<$Res> {
  factory _$EraQuizResultCopyWith(
          _EraQuizResult value, $Res Function(_EraQuizResult) _then) =
      __$EraQuizResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int correct,
      int total,
      double percentage,
      @JsonKey(name: 'completed_at') String completedAt,
      String? message});
}

/// @nodoc
class __$EraQuizResultCopyWithImpl<$Res>
    implements _$EraQuizResultCopyWith<$Res> {
  __$EraQuizResultCopyWithImpl(this._self, this._then);

  final _EraQuizResult _self;
  final $Res Function(_EraQuizResult) _then;

  /// Create a copy of EraQuizResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? correct = null,
    Object? total = null,
    Object? percentage = null,
    Object? completedAt = null,
    Object? message = freezed,
  }) {
    return _then(_EraQuizResult(
      correct: null == correct
          ? _self.correct
          : correct // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      percentage: null == percentage
          ? _self.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      completedAt: null == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
