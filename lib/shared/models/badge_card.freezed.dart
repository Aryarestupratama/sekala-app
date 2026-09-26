// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BadgeYear {
  int get id;
  int get year;
  String get title;

  /// Create a copy of BadgeYear
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BadgeYearCopyWith<BadgeYear> get copyWith =>
      _$BadgeYearCopyWithImpl<BadgeYear>(this as BadgeYear, _$identity);

  /// Serializes this BadgeYear to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BadgeYear &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, title);

  @override
  String toString() {
    return 'BadgeYear(id: $id, year: $year, title: $title)';
  }
}

/// @nodoc
abstract mixin class $BadgeYearCopyWith<$Res> {
  factory $BadgeYearCopyWith(BadgeYear value, $Res Function(BadgeYear) _then) =
      _$BadgeYearCopyWithImpl;
  @useResult
  $Res call({int id, int year, String title});
}

/// @nodoc
class _$BadgeYearCopyWithImpl<$Res> implements $BadgeYearCopyWith<$Res> {
  _$BadgeYearCopyWithImpl(this._self, this._then);

  final BadgeYear _self;
  final $Res Function(BadgeYear) _then;

  /// Create a copy of BadgeYear
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? title = null,
  }) {
    return _then(BadgeYear(
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
    ));
  }
}

/// Adds pattern-matching-related methods to [BadgeYear].
extension BadgeYearPatterns on BadgeYear {
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
    TResult Function(_BadgeYear value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeYear() when $default != null:
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
    TResult Function(_BadgeYear value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeYear():
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
    TResult? Function(_BadgeYear value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeYear() when $default != null:
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
    TResult Function(int id, int year, String title)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeYear() when $default != null:
        return $default(_that.id, _that.year, _that.title);
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
    TResult Function(int id, int year, String title) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeYear():
        return $default(_that.id, _that.year, _that.title);
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
    TResult? Function(int id, int year, String title)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeYear() when $default != null:
        return $default(_that.id, _that.year, _that.title);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BadgeYear implements BadgeYear {
  const _BadgeYear({required this.id, required this.year, required this.title});
  factory _BadgeYear.fromJson(Map<String, dynamic> json) =>
      _$BadgeYearFromJson(json);

  @override
  final int id;
  @override
  final int year;
  @override
  final String title;

  /// Create a copy of BadgeYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BadgeYearCopyWith<_BadgeYear> get copyWith =>
      __$BadgeYearCopyWithImpl<_BadgeYear>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BadgeYearToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BadgeYear &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, title);

  @override
  String toString() {
    return 'BadgeYear(id: $id, year: $year, title: $title)';
  }
}

/// @nodoc
abstract mixin class _$BadgeYearCopyWith<$Res>
    implements $BadgeYearCopyWith<$Res> {
  factory _$BadgeYearCopyWith(
          _BadgeYear value, $Res Function(_BadgeYear) _then) =
      __$BadgeYearCopyWithImpl;
  @override
  @useResult
  $Res call({int id, int year, String title});
}

/// @nodoc
class __$BadgeYearCopyWithImpl<$Res> implements _$BadgeYearCopyWith<$Res> {
  __$BadgeYearCopyWithImpl(this._self, this._then);

  final _BadgeYear _self;
  final $Res Function(_BadgeYear) _then;

  /// Create a copy of BadgeYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? title = null,
  }) {
    return _then(_BadgeYear(
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
    ));
  }
}

/// @nodoc
mixin _$BadgeEra {
  int get id;
  String get name;
  String get slug;

  /// Create a copy of BadgeEra
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BadgeEraCopyWith<BadgeEra> get copyWith =>
      _$BadgeEraCopyWithImpl<BadgeEra>(this as BadgeEra, _$identity);

  /// Serializes this BadgeEra to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BadgeEra &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'BadgeEra(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class $BadgeEraCopyWith<$Res> {
  factory $BadgeEraCopyWith(BadgeEra value, $Res Function(BadgeEra) _then) =
      _$BadgeEraCopyWithImpl;
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class _$BadgeEraCopyWithImpl<$Res> implements $BadgeEraCopyWith<$Res> {
  _$BadgeEraCopyWithImpl(this._self, this._then);

  final BadgeEra _self;
  final $Res Function(BadgeEra) _then;

  /// Create a copy of BadgeEra
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
  }) {
    return _then(BadgeEra(
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

/// Adds pattern-matching-related methods to [BadgeEra].
extension BadgeEraPatterns on BadgeEra {
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
    TResult Function(_BadgeEra value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeEra() when $default != null:
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
    TResult Function(_BadgeEra value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeEra():
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
    TResult? Function(_BadgeEra value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeEra() when $default != null:
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
      case _BadgeEra() when $default != null:
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
      case _BadgeEra():
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
      case _BadgeEra() when $default != null:
        return $default(_that.id, _that.name, _that.slug);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BadgeEra implements BadgeEra {
  const _BadgeEra({required this.id, required this.name, required this.slug});
  factory _BadgeEra.fromJson(Map<String, dynamic> json) =>
      _$BadgeEraFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;

  /// Create a copy of BadgeEra
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BadgeEraCopyWith<_BadgeEra> get copyWith =>
      __$BadgeEraCopyWithImpl<_BadgeEra>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BadgeEraToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BadgeEra &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'BadgeEra(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class _$BadgeEraCopyWith<$Res>
    implements $BadgeEraCopyWith<$Res> {
  factory _$BadgeEraCopyWith(_BadgeEra value, $Res Function(_BadgeEra) _then) =
      __$BadgeEraCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class __$BadgeEraCopyWithImpl<$Res> implements _$BadgeEraCopyWith<$Res> {
  __$BadgeEraCopyWithImpl(this._self, this._then);

  final _BadgeEra _self;
  final $Res Function(_BadgeEra) _then;

  /// Create a copy of BadgeEra
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
  }) {
    return _then(_BadgeEra(
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
mixin _$BadgeCard {
  int get id;
  @JsonKey(name: 'section_id')
  int get sectionId;
  String get name;
  String? get description;
  @JsonKey(name: 'icon_url')
  String? get iconUrl;
  @JsonKey(name: 'unlocked', defaultValue: false)
  bool get unlocked;
  @JsonKey(name: 'unlocked_at')
  DateTime? get unlockedAt;
  @JsonKey(name: 'unseen', defaultValue: false)
  bool get unseen;
  BadgeYear get year;
  BadgeEra get era;

  /// Create a copy of BadgeCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BadgeCardCopyWith<BadgeCard> get copyWith =>
      _$BadgeCardCopyWithImpl<BadgeCard>(this as BadgeCard, _$identity);

  /// Serializes this BadgeCard to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BadgeCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.unseen, unseen) || other.unseen == unseen) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.era, era) || other.era == era));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, sectionId, name, description,
      iconUrl, unlocked, unlockedAt, unseen, year, era);

  @override
  String toString() {
    return 'BadgeCard(id: $id, sectionId: $sectionId, name: $name, description: $description, iconUrl: $iconUrl, unlocked: $unlocked, unlockedAt: $unlockedAt, unseen: $unseen, year: $year, era: $era)';
  }
}

/// @nodoc
abstract mixin class $BadgeCardCopyWith<$Res> {
  factory $BadgeCardCopyWith(BadgeCard value, $Res Function(BadgeCard) _then) =
      _$BadgeCardCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'section_id') int sectionId,
      String name,
      String? description,
      @JsonKey(name: 'icon_url') String? iconUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
      @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,
      @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
      BadgeYear year,
      BadgeEra era});

  $BadgeYearCopyWith<$Res> get year;
  $BadgeEraCopyWith<$Res> get era;
}

/// @nodoc
class _$BadgeCardCopyWithImpl<$Res> implements $BadgeCardCopyWith<$Res> {
  _$BadgeCardCopyWithImpl(this._self, this._then);

  final BadgeCard _self;
  final $Res Function(BadgeCard) _then;

  /// Create a copy of BadgeCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sectionId = null,
    Object? name = null,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? unlocked = null,
    Object? unlockedAt = freezed,
    Object? unseen = null,
    Object? year = null,
    Object? era = null,
  }) {
    return _then(BadgeCard(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sectionId: null == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _self.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unlockedAt: freezed == unlockedAt
          ? _self.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unseen: null == unseen
          ? _self.unseen
          : unseen // ignore: cast_nullable_to_non_nullable
              as bool,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as BadgeYear,
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as BadgeEra,
    ));
  }

  /// Create a copy of BadgeCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BadgeYearCopyWith<$Res> get year {
    return $BadgeYearCopyWith<$Res>(_self.year, (value) {
      return _then(_self.copyWith(year: value));
    });
  }

  /// Create a copy of BadgeCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BadgeEraCopyWith<$Res> get era {
    return $BadgeEraCopyWith<$Res>(_self.era, (value) {
      return _then(_self.copyWith(era: value));
    });
  }
}

/// Adds pattern-matching-related methods to [BadgeCard].
extension BadgeCardPatterns on BadgeCard {
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
    TResult Function(_BadgeCard value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeCard() when $default != null:
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
    TResult Function(_BadgeCard value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeCard():
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
    TResult? Function(_BadgeCard value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeCard() when $default != null:
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
            int id,
            @JsonKey(name: 'section_id') int sectionId,
            String name,
            String? description,
            @JsonKey(name: 'icon_url') String? iconUrl,
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
            @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,
            @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
            BadgeYear year,
            BadgeEra era)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeCard() when $default != null:
        return $default(
            _that.id,
            _that.sectionId,
            _that.name,
            _that.description,
            _that.iconUrl,
            _that.unlocked,
            _that.unlockedAt,
            _that.unseen,
            _that.year,
            _that.era);
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
            int id,
            @JsonKey(name: 'section_id') int sectionId,
            String name,
            String? description,
            @JsonKey(name: 'icon_url') String? iconUrl,
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
            @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,
            @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
            BadgeYear year,
            BadgeEra era)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeCard():
        return $default(
            _that.id,
            _that.sectionId,
            _that.name,
            _that.description,
            _that.iconUrl,
            _that.unlocked,
            _that.unlockedAt,
            _that.unseen,
            _that.year,
            _that.era);
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
            int id,
            @JsonKey(name: 'section_id') int sectionId,
            String name,
            String? description,
            @JsonKey(name: 'icon_url') String? iconUrl,
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
            @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,
            @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
            BadgeYear year,
            BadgeEra era)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeCard() when $default != null:
        return $default(
            _that.id,
            _that.sectionId,
            _that.name,
            _that.description,
            _that.iconUrl,
            _that.unlocked,
            _that.unlockedAt,
            _that.unseen,
            _that.year,
            _that.era);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BadgeCard implements BadgeCard {
  const _BadgeCard(
      {required this.id,
      @JsonKey(name: 'section_id') required this.sectionId,
      required this.name,
      this.description,
      @JsonKey(name: 'icon_url') this.iconUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) required this.unlocked,
      @JsonKey(name: 'unlocked_at') this.unlockedAt,
      @JsonKey(name: 'unseen', defaultValue: false) required this.unseen,
      required this.year,
      required this.era});
  factory _BadgeCard.fromJson(Map<String, dynamic> json) =>
      _$BadgeCardFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'section_id')
  final int sectionId;
  @override
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'icon_url')
  final String? iconUrl;
  @override
  @JsonKey(name: 'unlocked', defaultValue: false)
  final bool unlocked;
  @override
  @JsonKey(name: 'unlocked_at')
  final DateTime? unlockedAt;
  @override
  @JsonKey(name: 'unseen', defaultValue: false)
  final bool unseen;
  @override
  final BadgeYear year;
  @override
  final BadgeEra era;

  /// Create a copy of BadgeCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BadgeCardCopyWith<_BadgeCard> get copyWith =>
      __$BadgeCardCopyWithImpl<_BadgeCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BadgeCardToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BadgeCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.unseen, unseen) || other.unseen == unseen) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.era, era) || other.era == era));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, sectionId, name, description,
      iconUrl, unlocked, unlockedAt, unseen, year, era);

  @override
  String toString() {
    return 'BadgeCard(id: $id, sectionId: $sectionId, name: $name, description: $description, iconUrl: $iconUrl, unlocked: $unlocked, unlockedAt: $unlockedAt, unseen: $unseen, year: $year, era: $era)';
  }
}

/// @nodoc
abstract mixin class _$BadgeCardCopyWith<$Res>
    implements $BadgeCardCopyWith<$Res> {
  factory _$BadgeCardCopyWith(
          _BadgeCard value, $Res Function(_BadgeCard) _then) =
      __$BadgeCardCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'section_id') int sectionId,
      String name,
      String? description,
      @JsonKey(name: 'icon_url') String? iconUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
      @JsonKey(name: 'unlocked_at') DateTime? unlockedAt,
      @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
      BadgeYear year,
      BadgeEra era});

  @override
  $BadgeYearCopyWith<$Res> get year;
  @override
  $BadgeEraCopyWith<$Res> get era;
}

/// @nodoc
class __$BadgeCardCopyWithImpl<$Res> implements _$BadgeCardCopyWith<$Res> {
  __$BadgeCardCopyWithImpl(this._self, this._then);

  final _BadgeCard _self;
  final $Res Function(_BadgeCard) _then;

  /// Create a copy of BadgeCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? sectionId = null,
    Object? name = null,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? unlocked = null,
    Object? unlockedAt = freezed,
    Object? unseen = null,
    Object? year = null,
    Object? era = null,
  }) {
    return _then(_BadgeCard(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sectionId: null == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _self.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unlockedAt: freezed == unlockedAt
          ? _self.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unseen: null == unseen
          ? _self.unseen
          : unseen // ignore: cast_nullable_to_non_nullable
              as bool,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as BadgeYear,
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as BadgeEra,
    ));
  }

  /// Create a copy of BadgeCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BadgeYearCopyWith<$Res> get year {
    return $BadgeYearCopyWith<$Res>(_self.year, (value) {
      return _then(_self.copyWith(year: value));
    });
  }

  /// Create a copy of BadgeCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BadgeEraCopyWith<$Res> get era {
    return $BadgeEraCopyWith<$Res>(_self.era, (value) {
      return _then(_self.copyWith(era: value));
    });
  }
}

// dart format on
