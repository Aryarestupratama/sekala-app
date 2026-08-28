// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'figure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Figure {
  int get id;
  String get name;
  String? get photo;
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @JsonKey(name: 'birth_date')
  String? get birthDate;
  @JsonKey(name: 'death_date')
  String? get deathDate;
  String? get family;
  @JsonKey(name: 'role_description')
  String get roleDescription;
  @JsonKey(name: 'is_unlocked', defaultValue: false)
  bool get isUnlocked;
  @JsonKey(name: 'unlocked_at')
  String? get unlockedAt;

  /// Create a copy of Figure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FigureCopyWith<Figure> get copyWith =>
      _$FigureCopyWithImpl<Figure>(this as Figure, _$identity);

  /// Serializes this Figure to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Figure &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.deathDate, deathDate) ||
                other.deathDate == deathDate) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.roleDescription, roleDescription) ||
                other.roleDescription == roleDescription) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photo, photoUrl,
      birthDate, deathDate, family, roleDescription, isUnlocked, unlockedAt);

  @override
  String toString() {
    return 'Figure(id: $id, name: $name, photo: $photo, photoUrl: $photoUrl, birthDate: $birthDate, deathDate: $deathDate, family: $family, roleDescription: $roleDescription, isUnlocked: $isUnlocked, unlockedAt: $unlockedAt)';
  }
}

/// @nodoc
abstract mixin class $FigureCopyWith<$Res> {
  factory $FigureCopyWith(Figure value, $Res Function(Figure) _then) =
      _$FigureCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      String? photo,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'birth_date') String? birthDate,
      @JsonKey(name: 'death_date') String? deathDate,
      String? family,
      @JsonKey(name: 'role_description') String roleDescription,
      @JsonKey(name: 'is_unlocked', defaultValue: false) bool isUnlocked,
      @JsonKey(name: 'unlocked_at') String? unlockedAt});
}

/// @nodoc
class _$FigureCopyWithImpl<$Res> implements $FigureCopyWith<$Res> {
  _$FigureCopyWithImpl(this._self, this._then);

  final Figure _self;
  final $Res Function(Figure) _then;

  /// Create a copy of Figure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photo = freezed,
    Object? photoUrl = freezed,
    Object? birthDate = freezed,
    Object? deathDate = freezed,
    Object? family = freezed,
    Object? roleDescription = null,
    Object? isUnlocked = null,
    Object? unlockedAt = freezed,
  }) {
    return _then(Figure(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photo: freezed == photo
          ? _self.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      deathDate: freezed == deathDate
          ? _self.deathDate
          : deathDate // ignore: cast_nullable_to_non_nullable
              as String?,
      family: freezed == family
          ? _self.family
          : family // ignore: cast_nullable_to_non_nullable
              as String?,
      roleDescription: null == roleDescription
          ? _self.roleDescription
          : roleDescription // ignore: cast_nullable_to_non_nullable
              as String,
      isUnlocked: null == isUnlocked
          ? _self.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unlockedAt: freezed == unlockedAt
          ? _self.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Figure].
extension FigurePatterns on Figure {
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
    TResult Function(_Figure value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Figure() when $default != null:
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
    TResult Function(_Figure value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Figure():
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
    TResult? Function(_Figure value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Figure() when $default != null:
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
            String? photo,
            @JsonKey(name: 'photo_url') String? photoUrl,
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'death_date') String? deathDate,
            String? family,
            @JsonKey(name: 'role_description') String roleDescription,
            @JsonKey(name: 'is_unlocked', defaultValue: false) bool isUnlocked,
            @JsonKey(name: 'unlocked_at') String? unlockedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Figure() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.photo,
            _that.photoUrl,
            _that.birthDate,
            _that.deathDate,
            _that.family,
            _that.roleDescription,
            _that.isUnlocked,
            _that.unlockedAt);
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
            String? photo,
            @JsonKey(name: 'photo_url') String? photoUrl,
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'death_date') String? deathDate,
            String? family,
            @JsonKey(name: 'role_description') String roleDescription,
            @JsonKey(name: 'is_unlocked', defaultValue: false) bool isUnlocked,
            @JsonKey(name: 'unlocked_at') String? unlockedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Figure():
        return $default(
            _that.id,
            _that.name,
            _that.photo,
            _that.photoUrl,
            _that.birthDate,
            _that.deathDate,
            _that.family,
            _that.roleDescription,
            _that.isUnlocked,
            _that.unlockedAt);
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
            String? photo,
            @JsonKey(name: 'photo_url') String? photoUrl,
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'death_date') String? deathDate,
            String? family,
            @JsonKey(name: 'role_description') String roleDescription,
            @JsonKey(name: 'is_unlocked', defaultValue: false) bool isUnlocked,
            @JsonKey(name: 'unlocked_at') String? unlockedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Figure() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.photo,
            _that.photoUrl,
            _that.birthDate,
            _that.deathDate,
            _that.family,
            _that.roleDescription,
            _that.isUnlocked,
            _that.unlockedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Figure implements Figure {
  const _Figure(
      {required this.id,
      required this.name,
      this.photo,
      @JsonKey(name: 'photo_url') this.photoUrl,
      @JsonKey(name: 'birth_date') this.birthDate,
      @JsonKey(name: 'death_date') this.deathDate,
      this.family,
      @JsonKey(name: 'role_description') required this.roleDescription,
      @JsonKey(name: 'is_unlocked', defaultValue: false)
      required this.isUnlocked,
      @JsonKey(name: 'unlocked_at') this.unlockedAt});
  factory _Figure.fromJson(Map<String, dynamic> json) => _$FigureFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? photo;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @override
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  @override
  @JsonKey(name: 'death_date')
  final String? deathDate;
  @override
  final String? family;
  @override
  @JsonKey(name: 'role_description')
  final String roleDescription;
  @override
  @JsonKey(name: 'is_unlocked', defaultValue: false)
  final bool isUnlocked;
  @override
  @JsonKey(name: 'unlocked_at')
  final String? unlockedAt;

  /// Create a copy of Figure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FigureCopyWith<_Figure> get copyWith =>
      __$FigureCopyWithImpl<_Figure>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FigureToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Figure &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photo, photo) || other.photo == photo) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.deathDate, deathDate) ||
                other.deathDate == deathDate) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.roleDescription, roleDescription) ||
                other.roleDescription == roleDescription) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photo, photoUrl,
      birthDate, deathDate, family, roleDescription, isUnlocked, unlockedAt);

  @override
  String toString() {
    return 'Figure(id: $id, name: $name, photo: $photo, photoUrl: $photoUrl, birthDate: $birthDate, deathDate: $deathDate, family: $family, roleDescription: $roleDescription, isUnlocked: $isUnlocked, unlockedAt: $unlockedAt)';
  }
}

/// @nodoc
abstract mixin class _$FigureCopyWith<$Res> implements $FigureCopyWith<$Res> {
  factory _$FigureCopyWith(_Figure value, $Res Function(_Figure) _then) =
      __$FigureCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? photo,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'birth_date') String? birthDate,
      @JsonKey(name: 'death_date') String? deathDate,
      String? family,
      @JsonKey(name: 'role_description') String roleDescription,
      @JsonKey(name: 'is_unlocked', defaultValue: false) bool isUnlocked,
      @JsonKey(name: 'unlocked_at') String? unlockedAt});
}

/// @nodoc
class __$FigureCopyWithImpl<$Res> implements _$FigureCopyWith<$Res> {
  __$FigureCopyWithImpl(this._self, this._then);

  final _Figure _self;
  final $Res Function(_Figure) _then;

  /// Create a copy of Figure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photo = freezed,
    Object? photoUrl = freezed,
    Object? birthDate = freezed,
    Object? deathDate = freezed,
    Object? family = freezed,
    Object? roleDescription = null,
    Object? isUnlocked = null,
    Object? unlockedAt = freezed,
  }) {
    return _then(_Figure(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      photo: freezed == photo
          ? _self.photo
          : photo // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _self.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as String?,
      deathDate: freezed == deathDate
          ? _self.deathDate
          : deathDate // ignore: cast_nullable_to_non_nullable
              as String?,
      family: freezed == family
          ? _self.family
          : family // ignore: cast_nullable_to_non_nullable
              as String?,
      roleDescription: null == roleDescription
          ? _self.roleDescription
          : roleDescription // ignore: cast_nullable_to_non_nullable
              as String,
      isUnlocked: null == isUnlocked
          ? _self.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool,
      unlockedAt: freezed == unlockedAt
          ? _self.unlockedAt
          : unlockedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
