// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'case_study_submit_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CaseStudySubmitResult {
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  String get feedback;
  CaseStudyBadge? get badge;
  @JsonKey(name: 'year_completed')
  bool get yearCompleted;
  @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
  List<int> get newlyUnlockedVaccineIds;
  @JsonKey(name: 'border_unlocked')
  bool get borderUnlocked;

  /// Create a copy of CaseStudySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CaseStudySubmitResultCopyWith<CaseStudySubmitResult> get copyWith =>
      _$CaseStudySubmitResultCopyWithImpl<CaseStudySubmitResult>(
          this as CaseStudySubmitResult, _$identity);

  /// Serializes this CaseStudySubmitResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CaseStudySubmitResult &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.badge, badge) || other.badge == badge) &&
            (identical(other.yearCompleted, yearCompleted) ||
                other.yearCompleted == yearCompleted) &&
            const DeepCollectionEquality().equals(
                other.newlyUnlockedVaccineIds, newlyUnlockedVaccineIds) &&
            (identical(other.borderUnlocked, borderUnlocked) ||
                other.borderUnlocked == borderUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isCorrect,
      feedback,
      badge,
      yearCompleted,
      const DeepCollectionEquality().hash(newlyUnlockedVaccineIds),
      borderUnlocked);

  @override
  String toString() {
    return 'CaseStudySubmitResult(isCorrect: $isCorrect, feedback: $feedback, badge: $badge, yearCompleted: $yearCompleted, newlyUnlockedVaccineIds: $newlyUnlockedVaccineIds, borderUnlocked: $borderUnlocked)';
  }
}

/// @nodoc
abstract mixin class $CaseStudySubmitResultCopyWith<$Res> {
  factory $CaseStudySubmitResultCopyWith(CaseStudySubmitResult value,
          $Res Function(CaseStudySubmitResult) _then) =
      _$CaseStudySubmitResultCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_correct') bool isCorrect,
      String feedback,
      CaseStudyBadge? badge,
      @JsonKey(name: 'year_completed') bool yearCompleted,
      @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
      List<int> newlyUnlockedVaccineIds,
      @JsonKey(name: 'border_unlocked') bool borderUnlocked});

  $CaseStudyBadgeCopyWith<$Res>? get badge;
}

/// @nodoc
class _$CaseStudySubmitResultCopyWithImpl<$Res>
    implements $CaseStudySubmitResultCopyWith<$Res> {
  _$CaseStudySubmitResultCopyWithImpl(this._self, this._then);

  final CaseStudySubmitResult _self;
  final $Res Function(CaseStudySubmitResult) _then;

  /// Create a copy of CaseStudySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCorrect = null,
    Object? feedback = null,
    Object? badge = freezed,
    Object? yearCompleted = null,
    Object? newlyUnlockedVaccineIds = null,
    Object? borderUnlocked = null,
  }) {
    return _then(CaseStudySubmitResult(
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      feedback: null == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String,
      badge: freezed == badge
          ? _self.badge
          : badge // ignore: cast_nullable_to_non_nullable
              as CaseStudyBadge?,
      yearCompleted: null == yearCompleted
          ? _self.yearCompleted
          : yearCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      newlyUnlockedVaccineIds: null == newlyUnlockedVaccineIds
          ? _self.newlyUnlockedVaccineIds
          : newlyUnlockedVaccineIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      borderUnlocked: null == borderUnlocked
          ? _self.borderUnlocked
          : borderUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of CaseStudySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CaseStudyBadgeCopyWith<$Res>? get badge {
    if (_self.badge == null) {
      return null;
    }

    return $CaseStudyBadgeCopyWith<$Res>(_self.badge!, (value) {
      return _then(_self.copyWith(badge: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CaseStudySubmitResult].
extension CaseStudySubmitResultPatterns on CaseStudySubmitResult {
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
    TResult Function(_CaseStudySubmitResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudySubmitResult() when $default != null:
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
    TResult Function(_CaseStudySubmitResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudySubmitResult():
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
    TResult? Function(_CaseStudySubmitResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudySubmitResult() when $default != null:
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
            @JsonKey(name: 'is_correct') bool isCorrect,
            String feedback,
            CaseStudyBadge? badge,
            @JsonKey(name: 'year_completed') bool yearCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
            List<int> newlyUnlockedVaccineIds,
            @JsonKey(name: 'border_unlocked') bool borderUnlocked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudySubmitResult() when $default != null:
        return $default(
            _that.isCorrect,
            _that.feedback,
            _that.badge,
            _that.yearCompleted,
            _that.newlyUnlockedVaccineIds,
            _that.borderUnlocked);
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
            @JsonKey(name: 'is_correct') bool isCorrect,
            String feedback,
            CaseStudyBadge? badge,
            @JsonKey(name: 'year_completed') bool yearCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
            List<int> newlyUnlockedVaccineIds,
            @JsonKey(name: 'border_unlocked') bool borderUnlocked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudySubmitResult():
        return $default(
            _that.isCorrect,
            _that.feedback,
            _that.badge,
            _that.yearCompleted,
            _that.newlyUnlockedVaccineIds,
            _that.borderUnlocked);
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
            @JsonKey(name: 'is_correct') bool isCorrect,
            String feedback,
            CaseStudyBadge? badge,
            @JsonKey(name: 'year_completed') bool yearCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
            List<int> newlyUnlockedVaccineIds,
            @JsonKey(name: 'border_unlocked') bool borderUnlocked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudySubmitResult() when $default != null:
        return $default(
            _that.isCorrect,
            _that.feedback,
            _that.badge,
            _that.yearCompleted,
            _that.newlyUnlockedVaccineIds,
            _that.borderUnlocked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CaseStudySubmitResult implements CaseStudySubmitResult {
  const _CaseStudySubmitResult(
      {@JsonKey(name: 'is_correct') this.isCorrect = false,
      this.feedback = '',
      this.badge,
      @JsonKey(name: 'year_completed') this.yearCompleted = false,
      @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
      List<int> newlyUnlockedVaccineIds = const <int>[],
      @JsonKey(name: 'border_unlocked') this.borderUnlocked = false})
      : _newlyUnlockedVaccineIds = newlyUnlockedVaccineIds;
  factory _CaseStudySubmitResult.fromJson(Map<String, dynamic> json) =>
      _$CaseStudySubmitResultFromJson(json);

  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  @override
  @JsonKey()
  final String feedback;
  @override
  final CaseStudyBadge? badge;
  @override
  @JsonKey(name: 'year_completed')
  final bool yearCompleted;
  final List<int> _newlyUnlockedVaccineIds;
  @override
  @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
  List<int> get newlyUnlockedVaccineIds {
    if (_newlyUnlockedVaccineIds is EqualUnmodifiableListView)
      return _newlyUnlockedVaccineIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newlyUnlockedVaccineIds);
  }

  @override
  @JsonKey(name: 'border_unlocked')
  final bool borderUnlocked;

  /// Create a copy of CaseStudySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CaseStudySubmitResultCopyWith<_CaseStudySubmitResult> get copyWith =>
      __$CaseStudySubmitResultCopyWithImpl<_CaseStudySubmitResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CaseStudySubmitResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CaseStudySubmitResult &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.badge, badge) || other.badge == badge) &&
            (identical(other.yearCompleted, yearCompleted) ||
                other.yearCompleted == yearCompleted) &&
            const DeepCollectionEquality().equals(
                other._newlyUnlockedVaccineIds, _newlyUnlockedVaccineIds) &&
            (identical(other.borderUnlocked, borderUnlocked) ||
                other.borderUnlocked == borderUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      isCorrect,
      feedback,
      badge,
      yearCompleted,
      const DeepCollectionEquality().hash(_newlyUnlockedVaccineIds),
      borderUnlocked);

  @override
  String toString() {
    return 'CaseStudySubmitResult(isCorrect: $isCorrect, feedback: $feedback, badge: $badge, yearCompleted: $yearCompleted, newlyUnlockedVaccineIds: $newlyUnlockedVaccineIds, borderUnlocked: $borderUnlocked)';
  }
}

/// @nodoc
abstract mixin class _$CaseStudySubmitResultCopyWith<$Res>
    implements $CaseStudySubmitResultCopyWith<$Res> {
  factory _$CaseStudySubmitResultCopyWith(_CaseStudySubmitResult value,
          $Res Function(_CaseStudySubmitResult) _then) =
      __$CaseStudySubmitResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_correct') bool isCorrect,
      String feedback,
      CaseStudyBadge? badge,
      @JsonKey(name: 'year_completed') bool yearCompleted,
      @JsonKey(name: 'newly_unlocked_vaccine_ids', fromJson: _idsFromJson)
      List<int> newlyUnlockedVaccineIds,
      @JsonKey(name: 'border_unlocked') bool borderUnlocked});

  @override
  $CaseStudyBadgeCopyWith<$Res>? get badge;
}

/// @nodoc
class __$CaseStudySubmitResultCopyWithImpl<$Res>
    implements _$CaseStudySubmitResultCopyWith<$Res> {
  __$CaseStudySubmitResultCopyWithImpl(this._self, this._then);

  final _CaseStudySubmitResult _self;
  final $Res Function(_CaseStudySubmitResult) _then;

  /// Create a copy of CaseStudySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isCorrect = null,
    Object? feedback = null,
    Object? badge = freezed,
    Object? yearCompleted = null,
    Object? newlyUnlockedVaccineIds = null,
    Object? borderUnlocked = null,
  }) {
    return _then(_CaseStudySubmitResult(
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      feedback: null == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String,
      badge: freezed == badge
          ? _self.badge
          : badge // ignore: cast_nullable_to_non_nullable
              as CaseStudyBadge?,
      yearCompleted: null == yearCompleted
          ? _self.yearCompleted
          : yearCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      newlyUnlockedVaccineIds: null == newlyUnlockedVaccineIds
          ? _self._newlyUnlockedVaccineIds
          : newlyUnlockedVaccineIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
      borderUnlocked: null == borderUnlocked
          ? _self.borderUnlocked
          : borderUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of CaseStudySubmitResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CaseStudyBadgeCopyWith<$Res>? get badge {
    if (_self.badge == null) {
      return null;
    }

    return $CaseStudyBadgeCopyWith<$Res>(_self.badge!, (value) {
      return _then(_self.copyWith(badge: value));
    });
  }
}

// dart format on
