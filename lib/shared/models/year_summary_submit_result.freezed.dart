// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year_summary_submit_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearSummarySubmitResult {
  @JsonKey(name: 'is_perfect')
  bool get isPerfect;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  @JsonKey(name: 'full_summary', defaultValue: <String>[])
  List<String> get fullSummary;
  @JsonKey(name: 'quiz_unlocked')
  bool get quizUnlocked;

  /// Create a copy of YearSummarySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YearSummarySubmitResultCopyWith<YearSummarySubmitResult> get copyWith =>
      _$YearSummarySubmitResultCopyWithImpl<YearSummarySubmitResult>(
          this as YearSummarySubmitResult, _$identity);

  /// Serializes this YearSummarySubmitResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YearSummarySubmitResult &&
            (identical(other.isPerfect, isPerfect) ||
                other.isPerfect == isPerfect) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality()
                .equals(other.fullSummary, fullSummary) &&
            (identical(other.quizUnlocked, quizUnlocked) ||
                other.quizUnlocked == quizUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isPerfect, completedAt,
      const DeepCollectionEquality().hash(fullSummary), quizUnlocked);

  @override
  String toString() {
    return 'YearSummarySubmitResult(isPerfect: $isPerfect, completedAt: $completedAt, fullSummary: $fullSummary, quizUnlocked: $quizUnlocked)';
  }
}

/// @nodoc
abstract mixin class $YearSummarySubmitResultCopyWith<$Res> {
  factory $YearSummarySubmitResultCopyWith(YearSummarySubmitResult value,
          $Res Function(YearSummarySubmitResult) _then) =
      _$YearSummarySubmitResultCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_perfect') bool isPerfect,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      @JsonKey(name: 'full_summary', defaultValue: <String>[])
      List<String> fullSummary,
      @JsonKey(name: 'quiz_unlocked') bool quizUnlocked});
}

/// @nodoc
class _$YearSummarySubmitResultCopyWithImpl<$Res>
    implements $YearSummarySubmitResultCopyWith<$Res> {
  _$YearSummarySubmitResultCopyWithImpl(this._self, this._then);

  final YearSummarySubmitResult _self;
  final $Res Function(YearSummarySubmitResult) _then;

  /// Create a copy of YearSummarySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPerfect = null,
    Object? completedAt = freezed,
    Object? fullSummary = null,
    Object? quizUnlocked = null,
  }) {
    return _then(YearSummarySubmitResult(
      isPerfect: null == isPerfect
          ? _self.isPerfect
          : isPerfect // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fullSummary: null == fullSummary
          ? _self.fullSummary
          : fullSummary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quizUnlocked: null == quizUnlocked
          ? _self.quizUnlocked
          : quizUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [YearSummarySubmitResult].
extension YearSummarySubmitResultPatterns on YearSummarySubmitResult {
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
    TResult Function(_YearSummarySubmitResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummarySubmitResult() when $default != null:
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
    TResult Function(_YearSummarySubmitResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummarySubmitResult():
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
    TResult? Function(_YearSummarySubmitResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummarySubmitResult() when $default != null:
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
            @JsonKey(name: 'is_perfect') bool isPerfect,
            @JsonKey(name: 'completed_at') DateTime? completedAt,
            @JsonKey(name: 'full_summary', defaultValue: <String>[])
            List<String> fullSummary,
            @JsonKey(name: 'quiz_unlocked') bool quizUnlocked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummarySubmitResult() when $default != null:
        return $default(_that.isPerfect, _that.completedAt, _that.fullSummary,
            _that.quizUnlocked);
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
            @JsonKey(name: 'is_perfect') bool isPerfect,
            @JsonKey(name: 'completed_at') DateTime? completedAt,
            @JsonKey(name: 'full_summary', defaultValue: <String>[])
            List<String> fullSummary,
            @JsonKey(name: 'quiz_unlocked') bool quizUnlocked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummarySubmitResult():
        return $default(_that.isPerfect, _that.completedAt, _that.fullSummary,
            _that.quizUnlocked);
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
            @JsonKey(name: 'is_perfect') bool isPerfect,
            @JsonKey(name: 'completed_at') DateTime? completedAt,
            @JsonKey(name: 'full_summary', defaultValue: <String>[])
            List<String> fullSummary,
            @JsonKey(name: 'quiz_unlocked') bool quizUnlocked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummarySubmitResult() when $default != null:
        return $default(_that.isPerfect, _that.completedAt, _that.fullSummary,
            _that.quizUnlocked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _YearSummarySubmitResult implements YearSummarySubmitResult {
  const _YearSummarySubmitResult(
      {@JsonKey(name: 'is_perfect') this.isPerfect = false,
      @JsonKey(name: 'completed_at') this.completedAt,
      @JsonKey(name: 'full_summary', defaultValue: <String>[])
      List<String> fullSummary = const <String>[],
      @JsonKey(name: 'quiz_unlocked') this.quizUnlocked = false})
      : _fullSummary = fullSummary;
  factory _YearSummarySubmitResult.fromJson(Map<String, dynamic> json) =>
      _$YearSummarySubmitResultFromJson(json);

  @override
  @JsonKey(name: 'is_perfect')
  final bool isPerfect;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  final List<String> _fullSummary;
  @override
  @JsonKey(name: 'full_summary', defaultValue: <String>[])
  List<String> get fullSummary {
    if (_fullSummary is EqualUnmodifiableListView) return _fullSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fullSummary);
  }

  @override
  @JsonKey(name: 'quiz_unlocked')
  final bool quizUnlocked;

  /// Create a copy of YearSummarySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YearSummarySubmitResultCopyWith<_YearSummarySubmitResult> get copyWith =>
      __$YearSummarySubmitResultCopyWithImpl<_YearSummarySubmitResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YearSummarySubmitResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YearSummarySubmitResult &&
            (identical(other.isPerfect, isPerfect) ||
                other.isPerfect == isPerfect) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality()
                .equals(other._fullSummary, _fullSummary) &&
            (identical(other.quizUnlocked, quizUnlocked) ||
                other.quizUnlocked == quizUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isPerfect, completedAt,
      const DeepCollectionEquality().hash(_fullSummary), quizUnlocked);

  @override
  String toString() {
    return 'YearSummarySubmitResult(isPerfect: $isPerfect, completedAt: $completedAt, fullSummary: $fullSummary, quizUnlocked: $quizUnlocked)';
  }
}

/// @nodoc
abstract mixin class _$YearSummarySubmitResultCopyWith<$Res>
    implements $YearSummarySubmitResultCopyWith<$Res> {
  factory _$YearSummarySubmitResultCopyWith(_YearSummarySubmitResult value,
          $Res Function(_YearSummarySubmitResult) _then) =
      __$YearSummarySubmitResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_perfect') bool isPerfect,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      @JsonKey(name: 'full_summary', defaultValue: <String>[])
      List<String> fullSummary,
      @JsonKey(name: 'quiz_unlocked') bool quizUnlocked});
}

/// @nodoc
class __$YearSummarySubmitResultCopyWithImpl<$Res>
    implements _$YearSummarySubmitResultCopyWith<$Res> {
  __$YearSummarySubmitResultCopyWithImpl(this._self, this._then);

  final _YearSummarySubmitResult _self;
  final $Res Function(_YearSummarySubmitResult) _then;

  /// Create a copy of YearSummarySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isPerfect = null,
    Object? completedAt = freezed,
    Object? fullSummary = null,
    Object? quizUnlocked = null,
  }) {
    return _then(_YearSummarySubmitResult(
      isPerfect: null == isPerfect
          ? _self.isPerfect
          : isPerfect // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fullSummary: null == fullSummary
          ? _self._fullSummary
          : fullSummary // ignore: cast_nullable_to_non_nullable
              as List<String>,
      quizUnlocked: null == quizUnlocked
          ? _self.quizUnlocked
          : quizUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
