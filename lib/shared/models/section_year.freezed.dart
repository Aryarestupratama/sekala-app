// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section_year.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SectionEra {
  int get id;
  String get name;
  String get slug;

  /// Create a copy of SectionEra
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SectionEraCopyWith<SectionEra> get copyWith =>
      _$SectionEraCopyWithImpl<SectionEra>(this as SectionEra, _$identity);

  /// Serializes this SectionEra to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SectionEra &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'SectionEra(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class $SectionEraCopyWith<$Res> {
  factory $SectionEraCopyWith(
          SectionEra value, $Res Function(SectionEra) _then) =
      _$SectionEraCopyWithImpl;
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class _$SectionEraCopyWithImpl<$Res> implements $SectionEraCopyWith<$Res> {
  _$SectionEraCopyWithImpl(this._self, this._then);

  final SectionEra _self;
  final $Res Function(SectionEra) _then;

  /// Create a copy of SectionEra
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
  }) {
    return _then(SectionEra(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SectionEra].
extension SectionEraPatterns on SectionEra {
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
    TResult Function(_SectionEra value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionEra() when $default != null:
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
    TResult Function(_SectionEra value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionEra():
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
    TResult? Function(_SectionEra value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionEra() when $default != null:
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
    TResult Function(int id, String name, String slug)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionEra() when $default != null:
        return $default(_that.id, _that.name, _that.slug);
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
    TResult Function(int id, String name, String slug) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionEra():
        return $default(_that.id, _that.name, _that.slug);
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
    TResult? Function(int id, String name, String slug)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionEra() when $default != null:
        return $default(_that.id, _that.name, _that.slug);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SectionEra implements SectionEra {
  const _SectionEra({required this.id, required this.name, required this.slug});
  factory _SectionEra.fromJson(Map<String, dynamic> json) =>
      _$SectionEraFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;

  /// Create a copy of SectionEra
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SectionEraCopyWith<_SectionEra> get copyWith =>
      __$SectionEraCopyWithImpl<_SectionEra>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SectionEraToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SectionEra &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'SectionEra(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class _$SectionEraCopyWith<$Res>
    implements $SectionEraCopyWith<$Res> {
  factory _$SectionEraCopyWith(
          _SectionEra value, $Res Function(_SectionEra) _then) =
      __$SectionEraCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class __$SectionEraCopyWithImpl<$Res> implements _$SectionEraCopyWith<$Res> {
  __$SectionEraCopyWithImpl(this._self, this._then);

  final _SectionEra _self;
  final $Res Function(_SectionEra) _then;

  /// Create a copy of SectionEra
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
  }) {
    return _then(_SectionEra(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _self.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$SectionYear {
  int get id;
  int get year;
  String get title;
  SectionEra get era;

  /// Create a copy of SectionYear
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SectionYearCopyWith<SectionYear> get copyWith =>
      _$SectionYearCopyWithImpl<SectionYear>(this as SectionYear, _$identity);

  /// Serializes this SectionYear to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SectionYear &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.era, era) || other.era == era));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, title, era);

  @override
  String toString() {
    return 'SectionYear(id: $id, year: $year, title: $title, era: $era)';
  }
}

/// @nodoc
abstract mixin class $SectionYearCopyWith<$Res> {
  factory $SectionYearCopyWith(
          SectionYear value, $Res Function(SectionYear) _then) =
      _$SectionYearCopyWithImpl;
  @useResult
  $Res call({int id, int year, String title, SectionEra era});

  $SectionEraCopyWith<$Res> get era;
}

/// @nodoc
class _$SectionYearCopyWithImpl<$Res> implements $SectionYearCopyWith<$Res> {
  _$SectionYearCopyWithImpl(this._self, this._then);

  final SectionYear _self;
  final $Res Function(SectionYear) _then;

  /// Create a copy of SectionYear
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? title = null,
    Object? era = null,
  }) {
    return _then(SectionYear(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as SectionEra,
    ));
  }

  /// Create a copy of SectionYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SectionEraCopyWith<$Res> get era {
    return $SectionEraCopyWith<$Res>(_self.era, (value) {
      return _then(_self.copyWith(era: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SectionYear].
extension SectionYearPatterns on SectionYear {
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
    TResult Function(_SectionYear value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionYear() when $default != null:
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
    TResult Function(_SectionYear value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionYear():
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
    TResult? Function(_SectionYear value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionYear() when $default != null:
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
    TResult Function(int id, int year, String title, SectionEra era)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SectionYear() when $default != null:
        return $default(_that.id, _that.year, _that.title, _that.era);
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
    TResult Function(int id, int year, String title, SectionEra era) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionYear():
        return $default(_that.id, _that.year, _that.title, _that.era);
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
    TResult? Function(int id, int year, String title, SectionEra era)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SectionYear() when $default != null:
        return $default(_that.id, _that.year, _that.title, _that.era);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SectionYear implements SectionYear {
  const _SectionYear(
      {required this.id,
      required this.year,
      required this.title,
      required this.era});
  factory _SectionYear.fromJson(Map<String, dynamic> json) =>
      _$SectionYearFromJson(json);

  @override
  final int id;
  @override
  final int year;
  @override
  final String title;
  @override
  final SectionEra era;

  /// Create a copy of SectionYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SectionYearCopyWith<_SectionYear> get copyWith =>
      __$SectionYearCopyWithImpl<_SectionYear>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SectionYearToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SectionYear &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.era, era) || other.era == era));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, title, era);

  @override
  String toString() {
    return 'SectionYear(id: $id, year: $year, title: $title, era: $era)';
  }
}

/// @nodoc
abstract mixin class _$SectionYearCopyWith<$Res>
    implements $SectionYearCopyWith<$Res> {
  factory _$SectionYearCopyWith(
          _SectionYear value, $Res Function(_SectionYear) _then) =
      __$SectionYearCopyWithImpl;
  @override
  @useResult
  $Res call({int id, int year, String title, SectionEra era});

  @override
  $SectionEraCopyWith<$Res> get era;
}

/// @nodoc
class __$SectionYearCopyWithImpl<$Res> implements _$SectionYearCopyWith<$Res> {
  __$SectionYearCopyWithImpl(this._self, this._then);

  final _SectionYear _self;
  final $Res Function(_SectionYear) _then;

  /// Create a copy of SectionYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? title = null,
    Object? era = null,
  }) {
    return _then(_SectionYear(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as SectionEra,
    ));
  }

  /// Create a copy of SectionYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SectionEraCopyWith<$Res> get era {
    return $SectionEraCopyWith<$Res>(_self.era, (value) {
      return _then(_self.copyWith(era: value));
    });
  }
}

// dart format on
