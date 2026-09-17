// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year_summary_completion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearSummaryCompletion {
  @JsonKey(name: 'is_perfect')
  bool get isPerfect;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;

  /// Create a copy of YearSummaryCompletion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YearSummaryCompletionCopyWith<YearSummaryCompletion> get copyWith =>
      _$YearSummaryCompletionCopyWithImpl<YearSummaryCompletion>(
          this as YearSummaryCompletion, _$identity);

  /// Serializes this YearSummaryCompletion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YearSummaryCompletion &&
            (identical(other.isPerfect, isPerfect) ||
                other.isPerfect == isPerfect) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isPerfect, completedAt);

  @override
  String toString() {
    return 'YearSummaryCompletion(isPerfect: $isPerfect, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class $YearSummaryCompletionCopyWith<$Res> {
  factory $YearSummaryCompletionCopyWith(YearSummaryCompletion value,
          $Res Function(YearSummaryCompletion) _then) =
      _$YearSummaryCompletionCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_perfect') bool isPerfect,
      @JsonKey(name: 'completed_at') DateTime? completedAt});
}

/// @nodoc
class _$YearSummaryCompletionCopyWithImpl<$Res>
    implements $YearSummaryCompletionCopyWith<$Res> {
  _$YearSummaryCompletionCopyWithImpl(this._self, this._then);

  final YearSummaryCompletion _self;
  final $Res Function(YearSummaryCompletion) _then;

  /// Create a copy of YearSummaryCompletion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPerfect = null,
    Object? completedAt = freezed,
  }) {
    return _then(YearSummaryCompletion(
      isPerfect: null == isPerfect
          ? _self.isPerfect
          : isPerfect // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [YearSummaryCompletion].
extension YearSummaryCompletionPatterns on YearSummaryCompletion {
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
    TResult Function(_YearSummaryCompletion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryCompletion() when $default != null:
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
    TResult Function(_YearSummaryCompletion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryCompletion():
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
    TResult? Function(_YearSummaryCompletion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryCompletion() when $default != null:
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
    TResult Function(@JsonKey(name: 'is_perfect') bool isPerfect,
            @JsonKey(name: 'completed_at') DateTime? completedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryCompletion() when $default != null:
        return $default(_that.isPerfect, _that.completedAt);
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
    TResult Function(@JsonKey(name: 'is_perfect') bool isPerfect,
            @JsonKey(name: 'completed_at') DateTime? completedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryCompletion():
        return $default(_that.isPerfect, _that.completedAt);
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
    TResult? Function(@JsonKey(name: 'is_perfect') bool isPerfect,
            @JsonKey(name: 'completed_at') DateTime? completedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryCompletion() when $default != null:
        return $default(_that.isPerfect, _that.completedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _YearSummaryCompletion implements YearSummaryCompletion {
  const _YearSummaryCompletion(
      {@JsonKey(name: 'is_perfect') this.isPerfect = false,
      @JsonKey(name: 'completed_at') this.completedAt});
  factory _YearSummaryCompletion.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryCompletionFromJson(json);

  @override
  @JsonKey(name: 'is_perfect')
  final bool isPerfect;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  /// Create a copy of YearSummaryCompletion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YearSummaryCompletionCopyWith<_YearSummaryCompletion> get copyWith =>
      __$YearSummaryCompletionCopyWithImpl<_YearSummaryCompletion>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YearSummaryCompletionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YearSummaryCompletion &&
            (identical(other.isPerfect, isPerfect) ||
                other.isPerfect == isPerfect) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isPerfect, completedAt);

  @override
  String toString() {
    return 'YearSummaryCompletion(isPerfect: $isPerfect, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class _$YearSummaryCompletionCopyWith<$Res>
    implements $YearSummaryCompletionCopyWith<$Res> {
  factory _$YearSummaryCompletionCopyWith(_YearSummaryCompletion value,
          $Res Function(_YearSummaryCompletion) _then) =
      __$YearSummaryCompletionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_perfect') bool isPerfect,
      @JsonKey(name: 'completed_at') DateTime? completedAt});
}

/// @nodoc
class __$YearSummaryCompletionCopyWithImpl<$Res>
    implements _$YearSummaryCompletionCopyWith<$Res> {
  __$YearSummaryCompletionCopyWithImpl(this._self, this._then);

  final _YearSummaryCompletion _self;
  final $Res Function(_YearSummaryCompletion) _then;

  /// Create a copy of YearSummaryCompletion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isPerfect = null,
    Object? completedAt = freezed,
  }) {
    return _then(_YearSummaryCompletion(
      isPerfect: null == isPerfect
          ? _self.isPerfect
          : isPerfect // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
