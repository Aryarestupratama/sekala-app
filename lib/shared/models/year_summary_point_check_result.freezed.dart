// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year_summary_point_check_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearSummaryPointCheckResult {
  @JsonKey(name: 'point_id')
  int get pointId;
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  @JsonKey(name: 'correct_option')
  YearSummaryOption get correctOption;

  /// Create a copy of YearSummaryPointCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YearSummaryPointCheckResultCopyWith<YearSummaryPointCheckResult>
      get copyWith => _$YearSummaryPointCheckResultCopyWithImpl<
              YearSummaryPointCheckResult>(
          this as YearSummaryPointCheckResult, _$identity);

  /// Serializes this YearSummaryPointCheckResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YearSummaryPointCheckResult &&
            (identical(other.pointId, pointId) || other.pointId == pointId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.correctOption, correctOption) ||
                other.correctOption == correctOption));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, pointId, isCorrect, correctOption);

  @override
  String toString() {
    return 'YearSummaryPointCheckResult(pointId: $pointId, isCorrect: $isCorrect, correctOption: $correctOption)';
  }
}

/// @nodoc
abstract mixin class $YearSummaryPointCheckResultCopyWith<$Res> {
  factory $YearSummaryPointCheckResultCopyWith(
          YearSummaryPointCheckResult value,
          $Res Function(YearSummaryPointCheckResult) _then) =
      _$YearSummaryPointCheckResultCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'point_id') int pointId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      @JsonKey(name: 'correct_option') YearSummaryOption correctOption});

  $YearSummaryOptionCopyWith<$Res> get correctOption;
}

/// @nodoc
class _$YearSummaryPointCheckResultCopyWithImpl<$Res>
    implements $YearSummaryPointCheckResultCopyWith<$Res> {
  _$YearSummaryPointCheckResultCopyWithImpl(this._self, this._then);

  final YearSummaryPointCheckResult _self;
  final $Res Function(YearSummaryPointCheckResult) _then;

  /// Create a copy of YearSummaryPointCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointId = null,
    Object? isCorrect = null,
    Object? correctOption = null,
  }) {
    return _then(YearSummaryPointCheckResult(
      pointId: null == pointId
          ? _self.pointId
          : pointId // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      correctOption: null == correctOption
          ? _self.correctOption
          : correctOption // ignore: cast_nullable_to_non_nullable
              as YearSummaryOption,
    ));
  }

  /// Create a copy of YearSummaryPointCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YearSummaryOptionCopyWith<$Res> get correctOption {
    return $YearSummaryOptionCopyWith<$Res>(_self.correctOption, (value) {
      return _then(_self.copyWith(correctOption: value));
    });
  }
}

/// Adds pattern-matching-related methods to [YearSummaryPointCheckResult].
extension YearSummaryPointCheckResultPatterns on YearSummaryPointCheckResult {
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
    TResult Function(_YearSummaryPointCheckResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPointCheckResult() when $default != null:
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
    TResult Function(_YearSummaryPointCheckResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPointCheckResult():
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
    TResult? Function(_YearSummaryPointCheckResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPointCheckResult() when $default != null:
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
            @JsonKey(name: 'point_id') int pointId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            @JsonKey(name: 'correct_option') YearSummaryOption correctOption)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPointCheckResult() when $default != null:
        return $default(_that.pointId, _that.isCorrect, _that.correctOption);
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
            @JsonKey(name: 'point_id') int pointId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            @JsonKey(name: 'correct_option') YearSummaryOption correctOption)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPointCheckResult():
        return $default(_that.pointId, _that.isCorrect, _that.correctOption);
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
            @JsonKey(name: 'point_id') int pointId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            @JsonKey(name: 'correct_option') YearSummaryOption correctOption)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPointCheckResult() when $default != null:
        return $default(_that.pointId, _that.isCorrect, _that.correctOption);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _YearSummaryPointCheckResult implements YearSummaryPointCheckResult {
  const _YearSummaryPointCheckResult(
      {@JsonKey(name: 'point_id') required this.pointId,
      @JsonKey(name: 'is_correct') required this.isCorrect,
      @JsonKey(name: 'correct_option') required this.correctOption});
  factory _YearSummaryPointCheckResult.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryPointCheckResultFromJson(json);

  @override
  @JsonKey(name: 'point_id')
  final int pointId;
  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  @override
  @JsonKey(name: 'correct_option')
  final YearSummaryOption correctOption;

  /// Create a copy of YearSummaryPointCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YearSummaryPointCheckResultCopyWith<_YearSummaryPointCheckResult>
      get copyWith => __$YearSummaryPointCheckResultCopyWithImpl<
          _YearSummaryPointCheckResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YearSummaryPointCheckResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YearSummaryPointCheckResult &&
            (identical(other.pointId, pointId) || other.pointId == pointId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.correctOption, correctOption) ||
                other.correctOption == correctOption));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, pointId, isCorrect, correctOption);

  @override
  String toString() {
    return 'YearSummaryPointCheckResult(pointId: $pointId, isCorrect: $isCorrect, correctOption: $correctOption)';
  }
}

/// @nodoc
abstract mixin class _$YearSummaryPointCheckResultCopyWith<$Res>
    implements $YearSummaryPointCheckResultCopyWith<$Res> {
  factory _$YearSummaryPointCheckResultCopyWith(
          _YearSummaryPointCheckResult value,
          $Res Function(_YearSummaryPointCheckResult) _then) =
      __$YearSummaryPointCheckResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'point_id') int pointId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      @JsonKey(name: 'correct_option') YearSummaryOption correctOption});

  @override
  $YearSummaryOptionCopyWith<$Res> get correctOption;
}

/// @nodoc
class __$YearSummaryPointCheckResultCopyWithImpl<$Res>
    implements _$YearSummaryPointCheckResultCopyWith<$Res> {
  __$YearSummaryPointCheckResultCopyWithImpl(this._self, this._then);

  final _YearSummaryPointCheckResult _self;
  final $Res Function(_YearSummaryPointCheckResult) _then;

  /// Create a copy of YearSummaryPointCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? pointId = null,
    Object? isCorrect = null,
    Object? correctOption = null,
  }) {
    return _then(_YearSummaryPointCheckResult(
      pointId: null == pointId
          ? _self.pointId
          : pointId // ignore: cast_nullable_to_non_nullable
              as int,
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      correctOption: null == correctOption
          ? _self.correctOption
          : correctOption // ignore: cast_nullable_to_non_nullable
              as YearSummaryOption,
    ));
  }

  /// Create a copy of YearSummaryPointCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YearSummaryOptionCopyWith<$Res> get correctOption {
    return $YearSummaryOptionCopyWith<$Res>(_self.correctOption, (value) {
      return _then(_self.copyWith(correctOption: value));
    });
  }
}

// dart format on
