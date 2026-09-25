// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'case_study_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CaseStudyDetail {
  @JsonKey(name: 'case_study')
  CaseStudy get caseStudy;
  @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
  List<CaseStudyOption> get options;
  bool get completed;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;
  CaseStudyBadge? get badge;

  /// Create a copy of CaseStudyDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CaseStudyDetailCopyWith<CaseStudyDetail> get copyWith =>
      _$CaseStudyDetailCopyWithImpl<CaseStudyDetail>(
          this as CaseStudyDetail, _$identity);

  /// Serializes this CaseStudyDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CaseStudyDetail &&
            (identical(other.caseStudy, caseStudy) ||
                other.caseStudy == caseStudy) &&
            const DeepCollectionEquality().equals(other.options, options) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.badge, badge) || other.badge == badge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      caseStudy,
      const DeepCollectionEquality().hash(options),
      completed,
      completedAt,
      badge);

  @override
  String toString() {
    return 'CaseStudyDetail(caseStudy: $caseStudy, options: $options, completed: $completed, completedAt: $completedAt, badge: $badge)';
  }
}

/// @nodoc
abstract mixin class $CaseStudyDetailCopyWith<$Res> {
  factory $CaseStudyDetailCopyWith(
          CaseStudyDetail value, $Res Function(CaseStudyDetail) _then) =
      _$CaseStudyDetailCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'case_study') CaseStudy caseStudy,
      @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
      List<CaseStudyOption> options,
      bool completed,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      CaseStudyBadge? badge});

  $CaseStudyCopyWith<$Res> get caseStudy;
  $CaseStudyBadgeCopyWith<$Res>? get badge;
}

/// @nodoc
class _$CaseStudyDetailCopyWithImpl<$Res>
    implements $CaseStudyDetailCopyWith<$Res> {
  _$CaseStudyDetailCopyWithImpl(this._self, this._then);

  final CaseStudyDetail _self;
  final $Res Function(CaseStudyDetail) _then;

  /// Create a copy of CaseStudyDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caseStudy = null,
    Object? options = null,
    Object? completed = null,
    Object? completedAt = freezed,
    Object? badge = freezed,
  }) {
    return _then(CaseStudyDetail(
      caseStudy: null == caseStudy
          ? _self.caseStudy
          : caseStudy // ignore: cast_nullable_to_non_nullable
              as CaseStudy,
      options: null == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<CaseStudyOption>,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      badge: freezed == badge
          ? _self.badge
          : badge // ignore: cast_nullable_to_non_nullable
              as CaseStudyBadge?,
    ));
  }

  /// Create a copy of CaseStudyDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CaseStudyCopyWith<$Res> get caseStudy {
    return $CaseStudyCopyWith<$Res>(_self.caseStudy, (value) {
      return _then(_self.copyWith(caseStudy: value));
    });
  }

  /// Create a copy of CaseStudyDetail
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

/// Adds pattern-matching-related methods to [CaseStudyDetail].
extension CaseStudyDetailPatterns on CaseStudyDetail {
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
    TResult Function(_CaseStudyDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudyDetail() when $default != null:
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
    TResult Function(_CaseStudyDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyDetail():
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
    TResult? Function(_CaseStudyDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyDetail() when $default != null:
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
            @JsonKey(name: 'case_study') CaseStudy caseStudy,
            @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
            List<CaseStudyOption> options,
            bool completed,
            @JsonKey(name: 'completed_at') DateTime? completedAt,
            CaseStudyBadge? badge)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudyDetail() when $default != null:
        return $default(_that.caseStudy, _that.options, _that.completed,
            _that.completedAt, _that.badge);
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
            @JsonKey(name: 'case_study') CaseStudy caseStudy,
            @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
            List<CaseStudyOption> options,
            bool completed,
            @JsonKey(name: 'completed_at') DateTime? completedAt,
            CaseStudyBadge? badge)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyDetail():
        return $default(_that.caseStudy, _that.options, _that.completed,
            _that.completedAt, _that.badge);
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
            @JsonKey(name: 'case_study') CaseStudy caseStudy,
            @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
            List<CaseStudyOption> options,
            bool completed,
            @JsonKey(name: 'completed_at') DateTime? completedAt,
            CaseStudyBadge? badge)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyDetail() when $default != null:
        return $default(_that.caseStudy, _that.options, _that.completed,
            _that.completedAt, _that.badge);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CaseStudyDetail implements CaseStudyDetail {
  const _CaseStudyDetail(
      {@JsonKey(name: 'case_study') required this.caseStudy,
      @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
      List<CaseStudyOption> options = const <CaseStudyOption>[],
      this.completed = false,
      @JsonKey(name: 'completed_at') this.completedAt,
      this.badge})
      : _options = options;
  factory _CaseStudyDetail.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyDetailFromJson(json);

  @override
  @JsonKey(name: 'case_study')
  final CaseStudy caseStudy;
  final List<CaseStudyOption> _options;
  @override
  @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
  List<CaseStudyOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey()
  final bool completed;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;
  @override
  final CaseStudyBadge? badge;

  /// Create a copy of CaseStudyDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CaseStudyDetailCopyWith<_CaseStudyDetail> get copyWith =>
      __$CaseStudyDetailCopyWithImpl<_CaseStudyDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CaseStudyDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CaseStudyDetail &&
            (identical(other.caseStudy, caseStudy) ||
                other.caseStudy == caseStudy) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.badge, badge) || other.badge == badge));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      caseStudy,
      const DeepCollectionEquality().hash(_options),
      completed,
      completedAt,
      badge);

  @override
  String toString() {
    return 'CaseStudyDetail(caseStudy: $caseStudy, options: $options, completed: $completed, completedAt: $completedAt, badge: $badge)';
  }
}

/// @nodoc
abstract mixin class _$CaseStudyDetailCopyWith<$Res>
    implements $CaseStudyDetailCopyWith<$Res> {
  factory _$CaseStudyDetailCopyWith(
          _CaseStudyDetail value, $Res Function(_CaseStudyDetail) _then) =
      __$CaseStudyDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'case_study') CaseStudy caseStudy,
      @JsonKey(name: 'options', defaultValue: <CaseStudyOption>[])
      List<CaseStudyOption> options,
      bool completed,
      @JsonKey(name: 'completed_at') DateTime? completedAt,
      CaseStudyBadge? badge});

  @override
  $CaseStudyCopyWith<$Res> get caseStudy;
  @override
  $CaseStudyBadgeCopyWith<$Res>? get badge;
}

/// @nodoc
class __$CaseStudyDetailCopyWithImpl<$Res>
    implements _$CaseStudyDetailCopyWith<$Res> {
  __$CaseStudyDetailCopyWithImpl(this._self, this._then);

  final _CaseStudyDetail _self;
  final $Res Function(_CaseStudyDetail) _then;

  /// Create a copy of CaseStudyDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? caseStudy = null,
    Object? options = null,
    Object? completed = null,
    Object? completedAt = freezed,
    Object? badge = freezed,
  }) {
    return _then(_CaseStudyDetail(
      caseStudy: null == caseStudy
          ? _self.caseStudy
          : caseStudy // ignore: cast_nullable_to_non_nullable
              as CaseStudy,
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<CaseStudyOption>,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      badge: freezed == badge
          ? _self.badge
          : badge // ignore: cast_nullable_to_non_nullable
              as CaseStudyBadge?,
    ));
  }

  /// Create a copy of CaseStudyDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CaseStudyCopyWith<$Res> get caseStudy {
    return $CaseStudyCopyWith<$Res>(_self.caseStudy, (value) {
      return _then(_self.copyWith(caseStudy: value));
    });
  }

  /// Create a copy of CaseStudyDetail
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
