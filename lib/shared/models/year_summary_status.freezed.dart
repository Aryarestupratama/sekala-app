// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year_summary_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearSummaryStatus {
  int get id;
  @JsonKey(name: 'is_published')
  bool get isPublished;

  /// Create a copy of YearSummaryStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YearSummaryStatusCopyWith<YearSummaryStatus> get copyWith =>
      _$YearSummaryStatusCopyWithImpl<YearSummaryStatus>(
          this as YearSummaryStatus, _$identity);

  /// Serializes this YearSummaryStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YearSummaryStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isPublished);

  @override
  String toString() {
    return 'YearSummaryStatus(id: $id, isPublished: $isPublished)';
  }
}

/// @nodoc
abstract mixin class $YearSummaryStatusCopyWith<$Res> {
  factory $YearSummaryStatusCopyWith(
          YearSummaryStatus value, $Res Function(YearSummaryStatus) _then) =
      _$YearSummaryStatusCopyWithImpl;
  @useResult
  $Res call({int id, @JsonKey(name: 'is_published') bool isPublished});
}

/// @nodoc
class _$YearSummaryStatusCopyWithImpl<$Res>
    implements $YearSummaryStatusCopyWith<$Res> {
  _$YearSummaryStatusCopyWithImpl(this._self, this._then);

  final YearSummaryStatus _self;
  final $Res Function(YearSummaryStatus) _then;

  /// Create a copy of YearSummaryStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? isPublished = null,
  }) {
    return _then(YearSummaryStatus(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [YearSummaryStatus].
extension YearSummaryStatusPatterns on YearSummaryStatus {
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
    TResult Function(_YearSummaryStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryStatus() when $default != null:
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
    TResult Function(_YearSummaryStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryStatus():
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
    TResult? Function(_YearSummaryStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryStatus() when $default != null:
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
    TResult Function(int id, @JsonKey(name: 'is_published') bool isPublished)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryStatus() when $default != null:
        return $default(_that.id, _that.isPublished);
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
    TResult Function(int id, @JsonKey(name: 'is_published') bool isPublished)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryStatus():
        return $default(_that.id, _that.isPublished);
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
    TResult? Function(int id, @JsonKey(name: 'is_published') bool isPublished)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryStatus() when $default != null:
        return $default(_that.id, _that.isPublished);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _YearSummaryStatus implements YearSummaryStatus {
  const _YearSummaryStatus(
      {required this.id,
      @JsonKey(name: 'is_published') this.isPublished = false});
  factory _YearSummaryStatus.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryStatusFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'is_published')
  final bool isPublished;

  /// Create a copy of YearSummaryStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YearSummaryStatusCopyWith<_YearSummaryStatus> get copyWith =>
      __$YearSummaryStatusCopyWithImpl<_YearSummaryStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YearSummaryStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YearSummaryStatus &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, isPublished);

  @override
  String toString() {
    return 'YearSummaryStatus(id: $id, isPublished: $isPublished)';
  }
}

/// @nodoc
abstract mixin class _$YearSummaryStatusCopyWith<$Res>
    implements $YearSummaryStatusCopyWith<$Res> {
  factory _$YearSummaryStatusCopyWith(
          _YearSummaryStatus value, $Res Function(_YearSummaryStatus) _then) =
      __$YearSummaryStatusCopyWithImpl;
  @override
  @useResult
  $Res call({int id, @JsonKey(name: 'is_published') bool isPublished});
}

/// @nodoc
class __$YearSummaryStatusCopyWithImpl<$Res>
    implements _$YearSummaryStatusCopyWith<$Res> {
  __$YearSummaryStatusCopyWithImpl(this._self, this._then);

  final _YearSummaryStatus _self;
  final $Res Function(_YearSummaryStatus) _then;

  /// Create a copy of YearSummaryStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? isPublished = null,
  }) {
    return _then(_YearSummaryStatus(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
