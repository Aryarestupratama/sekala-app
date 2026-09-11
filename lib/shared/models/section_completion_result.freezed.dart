// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_completion_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SectionCompletionResult {
  @JsonKey(name: 'completed_at')
  String? get completedAt;
  @JsonKey(name: 'year_completed')
  bool get yearCompleted;
  @JsonKey(name: 'newly_unlocked_vaccine_ids')
  List<int> get newlyUnlockedVaccineIds;

  /// Create a copy of SectionCompletionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SectionCompletionResultCopyWith<SectionCompletionResult> get copyWith =>
      _$SectionCompletionResultCopyWithImpl<SectionCompletionResult>(
          this as SectionCompletionResult, _$identity);

  /// Serializes this SectionCompletionResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SectionCompletionResult &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.yearCompleted, yearCompleted) ||
                other.yearCompleted == yearCompleted) &&
            const DeepCollectionEquality().equals(
                other.newlyUnlockedVaccineIds, newlyUnlockedVaccineIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, completedAt, yearCompleted,
      const DeepCollectionEquality().hash(newlyUnlockedVaccineIds));

  @override
  String toString() {
    return 'SectionCompletionResult(completedAt: $completedAt, yearCompleted: $yearCompleted, newlyUnlockedVaccineIds: $newlyUnlockedVaccineIds)';
  }
}

/// @nodoc
abstract mixin class $SectionCompletionResultCopyWith<$Res> {
  factory $SectionCompletionResultCopyWith(SectionCompletionResult value,
          $Res Function(SectionCompletionResult) _then) =
      _$SectionCompletionResultCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'completed_at') String? completedAt,
      @JsonKey(name: 'year_completed') bool yearCompleted,
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds});
}

/// @nodoc
class _$SectionCompletionResultCopyWithImpl<$Res>
    implements $SectionCompletionResultCopyWith<$Res> {
  _$SectionCompletionResultCopyWithImpl(this._self, this._then);

  final SectionCompletionResult _self;
  final $Res Function(SectionCompletionResult) _then;

  /// Create a copy of SectionCompletionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completedAt = freezed,
    Object? yearCompleted = null,
    Object? newlyUnlockedVaccineIds = null,
  }) {
    return _then(SectionCompletionResult(
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      yearCompleted: null == yearCompleted
          ? _self.yearCompleted
          : yearCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      newlyUnlockedVaccineIds: null == newlyUnlockedVaccineIds
          ? _self.newlyUnlockedVaccineIds
          : newlyUnlockedVaccineIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [SectionCompletionResult].
extension SectionCompletionResultPatterns on SectionCompletionResult {
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
    TResult Function(_SectionCompletionResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionCompletionResult() when $default != null:
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
    TResult Function(_SectionCompletionResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionCompletionResult():
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
    TResult? Function(_SectionCompletionResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionCompletionResult() when $default != null:
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
            @JsonKey(name: 'completed_at') String? completedAt,
            @JsonKey(name: 'year_completed') bool yearCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionCompletionResult() when $default != null:
        return $default(_that.completedAt, _that.yearCompleted,
            _that.newlyUnlockedVaccineIds);
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
            @JsonKey(name: 'completed_at') String? completedAt,
            @JsonKey(name: 'year_completed') bool yearCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionCompletionResult():
        return $default(_that.completedAt, _that.yearCompleted,
            _that.newlyUnlockedVaccineIds);
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
            @JsonKey(name: 'completed_at') String? completedAt,
            @JsonKey(name: 'year_completed') bool yearCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionCompletionResult() when $default != null:
        return $default(_that.completedAt, _that.yearCompleted,
            _that.newlyUnlockedVaccineIds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SectionCompletionResult implements SectionCompletionResult {
  const _SectionCompletionResult(
      {@JsonKey(name: 'completed_at') this.completedAt,
      @JsonKey(name: 'year_completed') this.yearCompleted = false,
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds = const <int>[]})
      : _newlyUnlockedVaccineIds = newlyUnlockedVaccineIds;
  factory _SectionCompletionResult.fromJson(Map<String, dynamic> json) =>
      _$SectionCompletionResultFromJson(json);

  @override
  @JsonKey(name: 'completed_at')
  final String? completedAt;
  @override
  @JsonKey(name: 'year_completed')
  final bool yearCompleted;
  final List<int> _newlyUnlockedVaccineIds;
  @override
  @JsonKey(name: 'newly_unlocked_vaccine_ids')
  List<int> get newlyUnlockedVaccineIds {
    if (_newlyUnlockedVaccineIds is EqualUnmodifiableListView)
      return _newlyUnlockedVaccineIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newlyUnlockedVaccineIds);
  }

  /// Create a copy of SectionCompletionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SectionCompletionResultCopyWith<_SectionCompletionResult> get copyWith =>
      __$SectionCompletionResultCopyWithImpl<_SectionCompletionResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SectionCompletionResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SectionCompletionResult &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.yearCompleted, yearCompleted) ||
                other.yearCompleted == yearCompleted) &&
            const DeepCollectionEquality().equals(
                other._newlyUnlockedVaccineIds, _newlyUnlockedVaccineIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, completedAt, yearCompleted,
      const DeepCollectionEquality().hash(_newlyUnlockedVaccineIds));

  @override
  String toString() {
    return 'SectionCompletionResult(completedAt: $completedAt, yearCompleted: $yearCompleted, newlyUnlockedVaccineIds: $newlyUnlockedVaccineIds)';
  }
}

/// @nodoc
abstract mixin class _$SectionCompletionResultCopyWith<$Res>
    implements $SectionCompletionResultCopyWith<$Res> {
  factory _$SectionCompletionResultCopyWith(_SectionCompletionResult value,
          $Res Function(_SectionCompletionResult) _then) =
      __$SectionCompletionResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'completed_at') String? completedAt,
      @JsonKey(name: 'year_completed') bool yearCompleted,
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds});
}

/// @nodoc
class __$SectionCompletionResultCopyWithImpl<$Res>
    implements _$SectionCompletionResultCopyWith<$Res> {
  __$SectionCompletionResultCopyWithImpl(this._self, this._then);

  final _SectionCompletionResult _self;
  final $Res Function(_SectionCompletionResult) _then;

  /// Create a copy of SectionCompletionResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? completedAt = freezed,
    Object? yearCompleted = null,
    Object? newlyUnlockedVaccineIds = null,
  }) {
    return _then(_SectionCompletionResult(
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      yearCompleted: null == yearCompleted
          ? _self.yearCompleted
          : yearCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      newlyUnlockedVaccineIds: null == newlyUnlockedVaccineIds
          ? _self._newlyUnlockedVaccineIds
          : newlyUnlockedVaccineIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

// dart format on
