// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_recap_year.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizRecapYear {
  int get id;
  int get year;

  /// Create a copy of EraQuizRecapYear
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizRecapYearCopyWith<EraQuizRecapYear> get copyWith =>
      _$EraQuizRecapYearCopyWithImpl<EraQuizRecapYear>(
          this as EraQuizRecapYear, _$identity);

  /// Serializes this EraQuizRecapYear to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizRecapYear &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year);

  @override
  String toString() {
    return 'EraQuizRecapYear(id: $id, year: $year)';
  }
}

/// @nodoc
abstract mixin class $EraQuizRecapYearCopyWith<$Res> {
  factory $EraQuizRecapYearCopyWith(
          EraQuizRecapYear value, $Res Function(EraQuizRecapYear) _then) =
      _$EraQuizRecapYearCopyWithImpl;
  @useResult
  $Res call({int id, int year});
}

/// @nodoc
class _$EraQuizRecapYearCopyWithImpl<$Res>
    implements $EraQuizRecapYearCopyWith<$Res> {
  _$EraQuizRecapYearCopyWithImpl(this._self, this._then);

  final EraQuizRecapYear _self;
  final $Res Function(EraQuizRecapYear) _then;

  /// Create a copy of EraQuizRecapYear
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
  }) {
    return _then(EraQuizRecapYear(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizRecapYear].
extension EraQuizRecapYearPatterns on EraQuizRecapYear {
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
    TResult Function(_EraQuizRecapYear value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapYear() when $default != null:
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
    TResult Function(_EraQuizRecapYear value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapYear():
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
    TResult? Function(_EraQuizRecapYear value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapYear() when $default != null:
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
    TResult Function(int id, int year)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapYear() when $default != null:
        return $default(_that.id, _that.year);
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
    TResult Function(int id, int year) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapYear():
        return $default(_that.id, _that.year);
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
    TResult? Function(int id, int year)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapYear() when $default != null:
        return $default(_that.id, _that.year);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizRecapYear implements EraQuizRecapYear {
  const _EraQuizRecapYear({required this.id, required this.year});
  factory _EraQuizRecapYear.fromJson(Map<String, dynamic> json) =>
      _$EraQuizRecapYearFromJson(json);

  @override
  final int id;
  @override
  final int year;

  /// Create a copy of EraQuizRecapYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizRecapYearCopyWith<_EraQuizRecapYear> get copyWith =>
      __$EraQuizRecapYearCopyWithImpl<_EraQuizRecapYear>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizRecapYearToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizRecapYear &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year);

  @override
  String toString() {
    return 'EraQuizRecapYear(id: $id, year: $year)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizRecapYearCopyWith<$Res>
    implements $EraQuizRecapYearCopyWith<$Res> {
  factory _$EraQuizRecapYearCopyWith(
          _EraQuizRecapYear value, $Res Function(_EraQuizRecapYear) _then) =
      __$EraQuizRecapYearCopyWithImpl;
  @override
  @useResult
  $Res call({int id, int year});
}

/// @nodoc
class __$EraQuizRecapYearCopyWithImpl<$Res>
    implements _$EraQuizRecapYearCopyWith<$Res> {
  __$EraQuizRecapYearCopyWithImpl(this._self, this._then);

  final _EraQuizRecapYear _self;
  final $Res Function(_EraQuizRecapYear) _then;

  /// Create a copy of EraQuizRecapYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? year = null,
  }) {
    return _then(_EraQuizRecapYear(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
