// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccineEra {
  int get id;
  String get name;
  String get slug;

  /// Create a copy of VaccineEra
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineEraCopyWith<VaccineEra> get copyWith =>
      _$VaccineEraCopyWithImpl<VaccineEra>(this as VaccineEra, _$identity);

  /// Serializes this VaccineEra to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineEra &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'VaccineEra(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class $VaccineEraCopyWith<$Res> {
  factory $VaccineEraCopyWith(
          VaccineEra value, $Res Function(VaccineEra) _then) =
      _$VaccineEraCopyWithImpl;
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class _$VaccineEraCopyWithImpl<$Res> implements $VaccineEraCopyWith<$Res> {
  _$VaccineEraCopyWithImpl(this._self, this._then);

  final VaccineEra _self;
  final $Res Function(VaccineEra) _then;

  /// Create a copy of VaccineEra
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
  }) {
    return _then(VaccineEra(
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

/// Adds pattern-matching-related methods to [VaccineEra].
extension VaccineEraPatterns on VaccineEra {
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
    TResult Function(_VaccineEra value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineEra() when $default != null:
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
    TResult Function(_VaccineEra value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineEra():
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
    TResult? Function(_VaccineEra value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineEra() when $default != null:
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
      case _VaccineEra() when $default != null:
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
      case _VaccineEra():
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
      case _VaccineEra() when $default != null:
        return $default(_that.id, _that.name, _that.slug);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VaccineEra implements VaccineEra {
  const _VaccineEra({required this.id, required this.name, required this.slug});
  factory _VaccineEra.fromJson(Map<String, dynamic> json) =>
      _$VaccineEraFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String slug;

  /// Create a copy of VaccineEra
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineEraCopyWith<_VaccineEra> get copyWith =>
      __$VaccineEraCopyWithImpl<_VaccineEra>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VaccineEraToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineEra &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, slug);

  @override
  String toString() {
    return 'VaccineEra(id: $id, name: $name, slug: $slug)';
  }
}

/// @nodoc
abstract mixin class _$VaccineEraCopyWith<$Res>
    implements $VaccineEraCopyWith<$Res> {
  factory _$VaccineEraCopyWith(
          _VaccineEra value, $Res Function(_VaccineEra) _then) =
      __$VaccineEraCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name, String slug});
}

/// @nodoc
class __$VaccineEraCopyWithImpl<$Res> implements _$VaccineEraCopyWith<$Res> {
  __$VaccineEraCopyWithImpl(this._self, this._then);

  final _VaccineEra _self;
  final $Res Function(_VaccineEra) _then;

  /// Create a copy of VaccineEra
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
  }) {
    return _then(_VaccineEra(
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
mixin _$VaccineCard {
  int get id;
  String get name;
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @JsonKey(name: 'photo_locked_url')
  String? get photoLockedUrl;
  @JsonKey(name: 'unlocked', defaultValue: false)
  bool get unlocked;
  @JsonKey(name: 'unseen', defaultValue: false)
  bool get unseen;
  List<VaccineEra> get eras;

  /// Create a copy of VaccineCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineCardCopyWith<VaccineCard> get copyWith =>
      _$VaccineCardCopyWithImpl<VaccineCard>(this as VaccineCard, _$identity);

  /// Serializes this VaccineCard to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.photoLockedUrl, photoLockedUrl) ||
                other.photoLockedUrl == photoLockedUrl) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked) &&
            (identical(other.unseen, unseen) || other.unseen == unseen) &&
            const DeepCollectionEquality().equals(other.eras, eras));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      photoUrl,
      photoLockedUrl,
      unlocked,
      unseen,
      const DeepCollectionEquality().hash(eras));

  @override
  String toString() {
    return 'VaccineCard(id: $id, name: $name, photoUrl: $photoUrl, photoLockedUrl: $photoLockedUrl, unlocked: $unlocked, unseen: $unseen, eras: $eras)';
  }
}

/// @nodoc
abstract mixin class $VaccineCardCopyWith<$Res> {
  factory $VaccineCardCopyWith(
          VaccineCard value, $Res Function(VaccineCard) _then) =
      _$VaccineCardCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
      @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
      List<VaccineEra> eras});
}

/// @nodoc
class _$VaccineCardCopyWithImpl<$Res> implements $VaccineCardCopyWith<$Res> {
  _$VaccineCardCopyWithImpl(this._self, this._then);

  final VaccineCard _self;
  final $Res Function(VaccineCard) _then;

  /// Create a copy of VaccineCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? photoLockedUrl = freezed,
    Object? unlocked = null,
    Object? unseen = null,
    Object? eras = null,
  }) {
    return _then(VaccineCard(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photoLockedUrl: freezed == photoLockedUrl
          ? _self.photoLockedUrl
          : photoLockedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unseen: null == unseen
          ? _self.unseen
          : unseen // ignore: cast_nullable_to_non_nullable
              as bool,
      eras: null == eras
          ? _self.eras
          : eras // ignore: cast_nullable_to_non_nullable
              as List<VaccineEra>,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineCard].
extension VaccineCardPatterns on VaccineCard {
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
    TResult Function(_VaccineCard value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineCard() when $default != null:
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
    TResult Function(_VaccineCard value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineCard():
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
    TResult? Function(_VaccineCard value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineCard() when $default != null:
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
            String name,
            @JsonKey(name: 'photo_url') String? photoUrl,
            @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
            @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
            List<VaccineEra> eras)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineCard() when $default != null:
        return $default(_that.id, _that.name, _that.photoUrl,
            _that.photoLockedUrl, _that.unlocked, _that.unseen, _that.eras);
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
            String name,
            @JsonKey(name: 'photo_url') String? photoUrl,
            @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
            @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
            List<VaccineEra> eras)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineCard():
        return $default(_that.id, _that.name, _that.photoUrl,
            _that.photoLockedUrl, _that.unlocked, _that.unseen, _that.eras);
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
            String name,
            @JsonKey(name: 'photo_url') String? photoUrl,
            @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
            @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
            List<VaccineEra> eras)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineCard() when $default != null:
        return $default(_that.id, _that.name, _that.photoUrl,
            _that.photoLockedUrl, _that.unlocked, _that.unseen, _that.eras);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VaccineCard implements VaccineCard {
  const _VaccineCard(
      {required this.id,
      required this.name,
      @JsonKey(name: 'photo_url') this.photoUrl,
      @JsonKey(name: 'photo_locked_url') this.photoLockedUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) required this.unlocked,
      @JsonKey(name: 'unseen', defaultValue: false) required this.unseen,
      List<VaccineEra> eras = const <VaccineEra>[]})
      : _eras = eras;
  factory _VaccineCard.fromJson(Map<String, dynamic> json) =>
      _$VaccineCardFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @override
  @JsonKey(name: 'photo_locked_url')
  final String? photoLockedUrl;
  @override
  @JsonKey(name: 'unlocked', defaultValue: false)
  final bool unlocked;
  @override
  @JsonKey(name: 'unseen', defaultValue: false)
  final bool unseen;
  final List<VaccineEra> _eras;
  @override
  @JsonKey()
  List<VaccineEra> get eras {
    if (_eras is EqualUnmodifiableListView) return _eras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_eras);
  }

  /// Create a copy of VaccineCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineCardCopyWith<_VaccineCard> get copyWith =>
      __$VaccineCardCopyWithImpl<_VaccineCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VaccineCardToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.photoLockedUrl, photoLockedUrl) ||
                other.photoLockedUrl == photoLockedUrl) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked) &&
            (identical(other.unseen, unseen) || other.unseen == unseen) &&
            const DeepCollectionEquality().equals(other._eras, _eras));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      photoUrl,
      photoLockedUrl,
      unlocked,
      unseen,
      const DeepCollectionEquality().hash(_eras));

  @override
  String toString() {
    return 'VaccineCard(id: $id, name: $name, photoUrl: $photoUrl, photoLockedUrl: $photoLockedUrl, unlocked: $unlocked, unseen: $unseen, eras: $eras)';
  }
}

/// @nodoc
abstract mixin class _$VaccineCardCopyWith<$Res>
    implements $VaccineCardCopyWith<$Res> {
  factory _$VaccineCardCopyWith(
          _VaccineCard value, $Res Function(_VaccineCard) _then) =
      __$VaccineCardCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked,
      @JsonKey(name: 'unseen', defaultValue: false) bool unseen,
      List<VaccineEra> eras});
}

/// @nodoc
class __$VaccineCardCopyWithImpl<$Res> implements _$VaccineCardCopyWith<$Res> {
  __$VaccineCardCopyWithImpl(this._self, this._then);

  final _VaccineCard _self;
  final $Res Function(_VaccineCard) _then;

  /// Create a copy of VaccineCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? photoLockedUrl = freezed,
    Object? unlocked = null,
    Object? unseen = null,
    Object? eras = null,
  }) {
    return _then(_VaccineCard(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      photoLockedUrl: freezed == photoLockedUrl
          ? _self.photoLockedUrl
          : photoLockedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unseen: null == unseen
          ? _self.unseen
          : unseen // ignore: cast_nullable_to_non_nullable
              as bool,
      eras: null == eras
          ? _self._eras
          : eras // ignore: cast_nullable_to_non_nullable
              as List<VaccineEra>,
    ));
  }
}

// dart format on
