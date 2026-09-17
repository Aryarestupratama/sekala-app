// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year_summary_attempt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearSummaryAttempt {
  YearSummaryCompletion? get completion;
  @JsonKey(name: 'full_summary')
  List<String>? get fullSummary;
  @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
  List<YearSummaryPoint> get points;

  /// Create a copy of YearSummaryAttempt
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YearSummaryAttemptCopyWith<YearSummaryAttempt> get copyWith =>
      _$YearSummaryAttemptCopyWithImpl<YearSummaryAttempt>(
          this as YearSummaryAttempt, _$identity);

  /// Serializes this YearSummaryAttempt to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YearSummaryAttempt &&
            (identical(other.completion, completion) ||
                other.completion == completion) &&
            const DeepCollectionEquality()
                .equals(other.fullSummary, fullSummary) &&
            const DeepCollectionEquality().equals(other.points, points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      completion,
      const DeepCollectionEquality().hash(fullSummary),
      const DeepCollectionEquality().hash(points));

  @override
  String toString() {
    return 'YearSummaryAttempt(completion: $completion, fullSummary: $fullSummary, points: $points)';
  }
}

/// @nodoc
abstract mixin class $YearSummaryAttemptCopyWith<$Res> {
  factory $YearSummaryAttemptCopyWith(
          YearSummaryAttempt value, $Res Function(YearSummaryAttempt) _then) =
      _$YearSummaryAttemptCopyWithImpl;
  @useResult
  $Res call(
      {YearSummaryCompletion? completion,
      @JsonKey(name: 'full_summary') List<String>? fullSummary,
      @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
      List<YearSummaryPoint> points});

  $YearSummaryCompletionCopyWith<$Res>? get completion;
}

/// @nodoc
class _$YearSummaryAttemptCopyWithImpl<$Res>
    implements $YearSummaryAttemptCopyWith<$Res> {
  _$YearSummaryAttemptCopyWithImpl(this._self, this._then);

  final YearSummaryAttempt _self;
  final $Res Function(YearSummaryAttempt) _then;

  /// Create a copy of YearSummaryAttempt
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completion = freezed,
    Object? fullSummary = freezed,
    Object? points = null,
  }) {
    return _then(YearSummaryAttempt(
      completion: freezed == completion
          ? _self.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as YearSummaryCompletion?,
      fullSummary: freezed == fullSummary
          ? _self.fullSummary
          : fullSummary // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      points: null == points
          ? _self.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<YearSummaryPoint>,
    ));
  }

  /// Create a copy of YearSummaryAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YearSummaryCompletionCopyWith<$Res>? get completion {
    if (_self.completion == null) {
      return null;
    }

    return $YearSummaryCompletionCopyWith<$Res>(_self.completion!, (value) {
      return _then(_self.copyWith(completion: value));
    });
  }
}

/// Adds pattern-matching-related methods to [YearSummaryAttempt].
extension YearSummaryAttemptPatterns on YearSummaryAttempt {
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
    TResult Function(_YearSummaryAttempt value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryAttempt() when $default != null:
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
    TResult Function(_YearSummaryAttempt value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryAttempt():
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
    TResult? Function(_YearSummaryAttempt value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryAttempt() when $default != null:
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
            YearSummaryCompletion? completion,
            @JsonKey(name: 'full_summary') List<String>? fullSummary,
            @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
            List<YearSummaryPoint> points)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryAttempt() when $default != null:
        return $default(_that.completion, _that.fullSummary, _that.points);
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
            YearSummaryCompletion? completion,
            @JsonKey(name: 'full_summary') List<String>? fullSummary,
            @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
            List<YearSummaryPoint> points)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryAttempt():
        return $default(_that.completion, _that.fullSummary, _that.points);
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
            YearSummaryCompletion? completion,
            @JsonKey(name: 'full_summary') List<String>? fullSummary,
            @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
            List<YearSummaryPoint> points)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryAttempt() when $default != null:
        return $default(_that.completion, _that.fullSummary, _that.points);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _YearSummaryAttempt implements YearSummaryAttempt {
  const _YearSummaryAttempt(
      {this.completion,
      @JsonKey(name: 'full_summary') List<String>? fullSummary,
      @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
      List<YearSummaryPoint> points = const <YearSummaryPoint>[]})
      : _fullSummary = fullSummary,
        _points = points;
  factory _YearSummaryAttempt.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryAttemptFromJson(json);

  @override
  final YearSummaryCompletion? completion;
  final List<String>? _fullSummary;
  @override
  @JsonKey(name: 'full_summary')
  List<String>? get fullSummary {
    final value = _fullSummary;
    if (value == null) return null;
    if (_fullSummary is EqualUnmodifiableListView) return _fullSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<YearSummaryPoint> _points;
  @override
  @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
  List<YearSummaryPoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  /// Create a copy of YearSummaryAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YearSummaryAttemptCopyWith<_YearSummaryAttempt> get copyWith =>
      __$YearSummaryAttemptCopyWithImpl<_YearSummaryAttempt>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YearSummaryAttemptToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YearSummaryAttempt &&
            (identical(other.completion, completion) ||
                other.completion == completion) &&
            const DeepCollectionEquality()
                .equals(other._fullSummary, _fullSummary) &&
            const DeepCollectionEquality().equals(other._points, _points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      completion,
      const DeepCollectionEquality().hash(_fullSummary),
      const DeepCollectionEquality().hash(_points));

  @override
  String toString() {
    return 'YearSummaryAttempt(completion: $completion, fullSummary: $fullSummary, points: $points)';
  }
}

/// @nodoc
abstract mixin class _$YearSummaryAttemptCopyWith<$Res>
    implements $YearSummaryAttemptCopyWith<$Res> {
  factory _$YearSummaryAttemptCopyWith(
          _YearSummaryAttempt value, $Res Function(_YearSummaryAttempt) _then) =
      __$YearSummaryAttemptCopyWithImpl;
  @override
  @useResult
  $Res call(
      {YearSummaryCompletion? completion,
      @JsonKey(name: 'full_summary') List<String>? fullSummary,
      @JsonKey(name: 'points', defaultValue: <YearSummaryPoint>[])
      List<YearSummaryPoint> points});

  @override
  $YearSummaryCompletionCopyWith<$Res>? get completion;
}

/// @nodoc
class __$YearSummaryAttemptCopyWithImpl<$Res>
    implements _$YearSummaryAttemptCopyWith<$Res> {
  __$YearSummaryAttemptCopyWithImpl(this._self, this._then);

  final _YearSummaryAttempt _self;
  final $Res Function(_YearSummaryAttempt) _then;

  /// Create a copy of YearSummaryAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? completion = freezed,
    Object? fullSummary = freezed,
    Object? points = null,
  }) {
    return _then(_YearSummaryAttempt(
      completion: freezed == completion
          ? _self.completion
          : completion // ignore: cast_nullable_to_non_nullable
              as YearSummaryCompletion?,
      fullSummary: freezed == fullSummary
          ? _self._fullSummary
          : fullSummary // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      points: null == points
          ? _self._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<YearSummaryPoint>,
    ));
  }

  /// Create a copy of YearSummaryAttempt
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $YearSummaryCompletionCopyWith<$Res>? get completion {
    if (_self.completion == null) {
      return null;
    }

    return $YearSummaryCompletionCopyWith<$Res>(_self.completion!, (value) {
      return _then(_self.copyWith(completion: value));
    });
  }
}

// dart format on
