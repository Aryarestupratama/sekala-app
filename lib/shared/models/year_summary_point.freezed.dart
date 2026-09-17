// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year_summary_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearSummaryPoint {
  int get id;
  int get order;
  List<YearSummaryOption> get options;

  /// Create a copy of YearSummaryPoint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YearSummaryPointCopyWith<YearSummaryPoint> get copyWith =>
      _$YearSummaryPointCopyWithImpl<YearSummaryPoint>(
          this as YearSummaryPoint, _$identity);

  /// Serializes this YearSummaryPoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YearSummaryPoint &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other.options, options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, order, const DeepCollectionEquality().hash(options));

  @override
  String toString() {
    return 'YearSummaryPoint(id: $id, order: $order, options: $options)';
  }
}

/// @nodoc
abstract mixin class $YearSummaryPointCopyWith<$Res> {
  factory $YearSummaryPointCopyWith(
          YearSummaryPoint value, $Res Function(YearSummaryPoint) _then) =
      _$YearSummaryPointCopyWithImpl;
  @useResult
  $Res call({int id, int order, List<YearSummaryOption> options});
}

/// @nodoc
class _$YearSummaryPointCopyWithImpl<$Res>
    implements $YearSummaryPointCopyWith<$Res> {
  _$YearSummaryPointCopyWithImpl(this._self, this._then);

  final YearSummaryPoint _self;
  final $Res Function(YearSummaryPoint) _then;

  /// Create a copy of YearSummaryPoint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? options = null,
  }) {
    return _then(YearSummaryPoint(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      options: null == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<YearSummaryOption>,
    ));
  }
}

/// Adds pattern-matching-related methods to [YearSummaryPoint].
extension YearSummaryPointPatterns on YearSummaryPoint {
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
    TResult Function(_YearSummaryPoint value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPoint() when $default != null:
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
    TResult Function(_YearSummaryPoint value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPoint():
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
    TResult? Function(_YearSummaryPoint value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPoint() when $default != null:
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
    TResult Function(int id, int order, List<YearSummaryOption> options)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPoint() when $default != null:
        return $default(_that.id, _that.order, _that.options);
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
    TResult Function(int id, int order, List<YearSummaryOption> options)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPoint():
        return $default(_that.id, _that.order, _that.options);
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
    TResult? Function(int id, int order, List<YearSummaryOption> options)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryPoint() when $default != null:
        return $default(_that.id, _that.order, _that.options);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _YearSummaryPoint implements YearSummaryPoint {
  const _YearSummaryPoint(
      {required this.id,
      this.order = 0,
      List<YearSummaryOption> options = const <YearSummaryOption>[]})
      : _options = options;
  factory _YearSummaryPoint.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryPointFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final int order;
  final List<YearSummaryOption> _options;
  @override
  @JsonKey()
  List<YearSummaryOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  /// Create a copy of YearSummaryPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YearSummaryPointCopyWith<_YearSummaryPoint> get copyWith =>
      __$YearSummaryPointCopyWithImpl<_YearSummaryPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YearSummaryPointToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YearSummaryPoint &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, order, const DeepCollectionEquality().hash(_options));

  @override
  String toString() {
    return 'YearSummaryPoint(id: $id, order: $order, options: $options)';
  }
}

/// @nodoc
abstract mixin class _$YearSummaryPointCopyWith<$Res>
    implements $YearSummaryPointCopyWith<$Res> {
  factory _$YearSummaryPointCopyWith(
          _YearSummaryPoint value, $Res Function(_YearSummaryPoint) _then) =
      __$YearSummaryPointCopyWithImpl;
  @override
  @useResult
  $Res call({int id, int order, List<YearSummaryOption> options});
}

/// @nodoc
class __$YearSummaryPointCopyWithImpl<$Res>
    implements _$YearSummaryPointCopyWith<$Res> {
  __$YearSummaryPointCopyWithImpl(this._self, this._then);

  final _YearSummaryPoint _self;
  final $Res Function(_YearSummaryPoint) _then;

  /// Create a copy of YearSummaryPoint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? options = null,
  }) {
    return _then(_YearSummaryPoint(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<YearSummaryOption>,
    ));
  }
}

// dart format on
