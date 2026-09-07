// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_score.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizScore {
  int get correct;
  int get total;
  double get percentage;

  /// Create a copy of EraQuizScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizScoreCopyWith<EraQuizScore> get copyWith =>
      _$EraQuizScoreCopyWithImpl<EraQuizScore>(
          this as EraQuizScore, _$identity);

  /// Serializes this EraQuizScore to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizScore &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, correct, total, percentage);

  @override
  String toString() {
    return 'EraQuizScore(correct: $correct, total: $total, percentage: $percentage)';
  }
}

/// @nodoc
abstract mixin class $EraQuizScoreCopyWith<$Res> {
  factory $EraQuizScoreCopyWith(
          EraQuizScore value, $Res Function(EraQuizScore) _then) =
      _$EraQuizScoreCopyWithImpl;
  @useResult
  $Res call({int correct, int total, double percentage});
}

/// @nodoc
class _$EraQuizScoreCopyWithImpl<$Res> implements $EraQuizScoreCopyWith<$Res> {
  _$EraQuizScoreCopyWithImpl(this._self, this._then);

  final EraQuizScore _self;
  final $Res Function(EraQuizScore) _then;

  /// Create a copy of EraQuizScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? correct = null,
    Object? total = null,
    Object? percentage = null,
  }) {
    return _then(EraQuizScore(
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
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizScore].
extension EraQuizScorePatterns on EraQuizScore {
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
    TResult Function(_EraQuizScore value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizScore() when $default != null:
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
    TResult Function(_EraQuizScore value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizScore():
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
    TResult? Function(_EraQuizScore value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizScore() when $default != null:
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
    TResult Function(int correct, int total, double percentage)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizScore() when $default != null:
        return $default(_that.correct, _that.total, _that.percentage);
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
    TResult Function(int correct, int total, double percentage) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizScore():
        return $default(_that.correct, _that.total, _that.percentage);
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
    TResult? Function(int correct, int total, double percentage)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizScore() when $default != null:
        return $default(_that.correct, _that.total, _that.percentage);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizScore implements EraQuizScore {
  const _EraQuizScore(
      {required this.correct, required this.total, required this.percentage});
  factory _EraQuizScore.fromJson(Map<String, dynamic> json) =>
      _$EraQuizScoreFromJson(json);

  @override
  final int correct;
  @override
  final int total;
  @override
  final double percentage;

  /// Create a copy of EraQuizScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizScoreCopyWith<_EraQuizScore> get copyWith =>
      __$EraQuizScoreCopyWithImpl<_EraQuizScore>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizScoreToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizScore &&
            (identical(other.correct, correct) || other.correct == correct) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, correct, total, percentage);

  @override
  String toString() {
    return 'EraQuizScore(correct: $correct, total: $total, percentage: $percentage)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizScoreCopyWith<$Res>
    implements $EraQuizScoreCopyWith<$Res> {
  factory _$EraQuizScoreCopyWith(
          _EraQuizScore value, $Res Function(_EraQuizScore) _then) =
      __$EraQuizScoreCopyWithImpl;
  @override
  @useResult
  $Res call({int correct, int total, double percentage});
}

/// @nodoc
class __$EraQuizScoreCopyWithImpl<$Res>
    implements _$EraQuizScoreCopyWith<$Res> {
  __$EraQuizScoreCopyWithImpl(this._self, this._then);

  final _EraQuizScore _self;
  final $Res Function(_EraQuizScore) _then;

  /// Create a copy of EraQuizScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? correct = null,
    Object? total = null,
    Object? percentage = null,
  }) {
    return _then(_EraQuizScore(
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
    ));
  }
}

// dart format on
