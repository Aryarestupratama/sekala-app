// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SectionSummary {
  int get id;
  String get title;
  int get order;
  bool get locked;
  bool get completed;

  /// Create a copy of SectionSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SectionSummaryCopyWith<SectionSummary> get copyWith =>
      _$SectionSummaryCopyWithImpl<SectionSummary>(
          this as SectionSummary, _$identity);

  /// Serializes this SectionSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SectionSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, order, locked, completed);

  @override
  String toString() {
    return 'SectionSummary(id: $id, title: $title, order: $order, locked: $locked, completed: $completed)';
  }
}

/// @nodoc
abstract mixin class $SectionSummaryCopyWith<$Res> {
  factory $SectionSummaryCopyWith(
          SectionSummary value, $Res Function(SectionSummary) _then) =
      _$SectionSummaryCopyWithImpl;
  @useResult
  $Res call({int id, String title, int order, bool locked, bool completed});
}

/// @nodoc
class _$SectionSummaryCopyWithImpl<$Res>
    implements $SectionSummaryCopyWith<$Res> {
  _$SectionSummaryCopyWithImpl(this._self, this._then);

  final SectionSummary _self;
  final $Res Function(SectionSummary) _then;

  /// Create a copy of SectionSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? order = null,
    Object? locked = null,
    Object? completed = null,
  }) {
    return _then(SectionSummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      locked: null == locked
          ? _self.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [SectionSummary].
extension SectionSummaryPatterns on SectionSummary {
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
    TResult Function(_SectionSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionSummary() when $default != null:
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
    TResult Function(_SectionSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionSummary():
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
    TResult? Function(_SectionSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionSummary() when $default != null:
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
            int id, String title, int order, bool locked, bool completed)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionSummary() when $default != null:
        return $default(
            _that.id, _that.title, _that.order, _that.locked, _that.completed);
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
            int id, String title, int order, bool locked, bool completed)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionSummary():
        return $default(
            _that.id, _that.title, _that.order, _that.locked, _that.completed);
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
            int id, String title, int order, bool locked, bool completed)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionSummary() when $default != null:
        return $default(
            _that.id, _that.title, _that.order, _that.locked, _that.completed);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SectionSummary implements SectionSummary {
  const _SectionSummary(
      {required this.id,
      required this.title,
      this.order = 0,
      this.locked = true,
      this.completed = false});
  factory _SectionSummary.fromJson(Map<String, dynamic> json) =>
      _$SectionSummaryFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  @JsonKey()
  final int order;
  @override
  @JsonKey()
  final bool locked;
  @override
  @JsonKey()
  final bool completed;

  /// Create a copy of SectionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SectionSummaryCopyWith<_SectionSummary> get copyWith =>
      __$SectionSummaryCopyWithImpl<_SectionSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SectionSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SectionSummary &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, order, locked, completed);

  @override
  String toString() {
    return 'SectionSummary(id: $id, title: $title, order: $order, locked: $locked, completed: $completed)';
  }
}

/// @nodoc
abstract mixin class _$SectionSummaryCopyWith<$Res>
    implements $SectionSummaryCopyWith<$Res> {
  factory _$SectionSummaryCopyWith(
          _SectionSummary value, $Res Function(_SectionSummary) _then) =
      __$SectionSummaryCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String title, int order, bool locked, bool completed});
}

/// @nodoc
class __$SectionSummaryCopyWithImpl<$Res>
    implements _$SectionSummaryCopyWith<$Res> {
  __$SectionSummaryCopyWithImpl(this._self, this._then);

  final _SectionSummary _self;
  final $Res Function(_SectionSummary) _then;

  /// Create a copy of SectionSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? order = null,
    Object? locked = null,
    Object? completed = null,
  }) {
    return _then(_SectionSummary(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      locked: null == locked
          ? _self.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as bool,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
