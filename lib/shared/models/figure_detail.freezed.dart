// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'figure_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FigureDetail {
  int get id;
  String get name;
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @JsonKey(name: 'birth_date')
  String? get birthDate;
  @JsonKey(name: 'death_date')
  String? get deathDate;
  String? get family;
  @JsonKey(name: 'role_description')
  String get roleDescription;

  /// Create a copy of FigureDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FigureDetailCopyWith<FigureDetail> get copyWith =>
      _$FigureDetailCopyWithImpl<FigureDetail>(
          this as FigureDetail, _$identity);

  /// Serializes this FigureDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FigureDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.deathDate, deathDate) ||
                other.deathDate == deathDate) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.roleDescription, roleDescription) ||
                other.roleDescription == roleDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photoUrl, birthDate,
      deathDate, family, roleDescription);

  @override
  String toString() {
    return 'FigureDetail(id: $id, name: $name, photoUrl: $photoUrl, birthDate: $birthDate, deathDate: $deathDate, family: $family, roleDescription: $roleDescription)';
  }
}

/// @nodoc
abstract mixin class $FigureDetailCopyWith<$Res> {
  factory $FigureDetailCopyWith(
          FigureDetail value, $Res Function(FigureDetail) _then) =
      _$FigureDetailCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'birth_date') String? birthDate,
      @JsonKey(name: 'death_date') String? deathDate,
      String? family,
      @JsonKey(name: 'role_description') String roleDescription});
}

/// @nodoc
class _$FigureDetailCopyWithImpl<$Res> implements $FigureDetailCopyWith<$Res> {
  _$FigureDetailCopyWithImpl(this._self, this._then);

  final FigureDetail _self;
  final $Res Function(FigureDetail) _then;

  /// Create a copy of FigureDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? birthDate = freezed,
    Object? deathDate = freezed,
    Object? family = freezed,
    Object? roleDescription = null,
  }) {
    return _then(FigureDetail(
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
    ));
  }
}

/// Adds pattern-matching-related methods to [FigureDetail].
extension FigureDetailPatterns on FigureDetail {
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
    TResult Function(_FigureDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FigureDetail() when $default != null:
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
    TResult Function(_FigureDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FigureDetail():
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
    TResult? Function(_FigureDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FigureDetail() when $default != null:
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
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'death_date') String? deathDate,
            String? family,
            @JsonKey(name: 'role_description') String roleDescription)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FigureDetail() when $default != null:
        return $default(_that.id, _that.name, _that.photoUrl, _that.birthDate,
            _that.deathDate, _that.family, _that.roleDescription);
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
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'death_date') String? deathDate,
            String? family,
            @JsonKey(name: 'role_description') String roleDescription)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FigureDetail():
        return $default(_that.id, _that.name, _that.photoUrl, _that.birthDate,
            _that.deathDate, _that.family, _that.roleDescription);
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
            @JsonKey(name: 'birth_date') String? birthDate,
            @JsonKey(name: 'death_date') String? deathDate,
            String? family,
            @JsonKey(name: 'role_description') String roleDescription)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FigureDetail() when $default != null:
        return $default(_that.id, _that.name, _that.photoUrl, _that.birthDate,
            _that.deathDate, _that.family, _that.roleDescription);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FigureDetail implements FigureDetail {
  const _FigureDetail(
      {required this.id,
      required this.name,
      @JsonKey(name: 'photo_url') this.photoUrl,
      @JsonKey(name: 'birth_date') this.birthDate,
      @JsonKey(name: 'death_date') this.deathDate,
      this.family,
      @JsonKey(name: 'role_description') required this.roleDescription});
  factory _FigureDetail.fromJson(Map<String, dynamic> json) =>
      _$FigureDetailFromJson(json);

  @override
  final int id;
  @override
  final String name;
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

  /// Create a copy of FigureDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FigureDetailCopyWith<_FigureDetail> get copyWith =>
      __$FigureDetailCopyWithImpl<_FigureDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FigureDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FigureDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.deathDate, deathDate) ||
                other.deathDate == deathDate) &&
            (identical(other.family, family) || other.family == family) &&
            (identical(other.roleDescription, roleDescription) ||
                other.roleDescription == roleDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photoUrl, birthDate,
      deathDate, family, roleDescription);

  @override
  String toString() {
    return 'FigureDetail(id: $id, name: $name, photoUrl: $photoUrl, birthDate: $birthDate, deathDate: $deathDate, family: $family, roleDescription: $roleDescription)';
  }
}

/// @nodoc
abstract mixin class _$FigureDetailCopyWith<$Res>
    implements $FigureDetailCopyWith<$Res> {
  factory _$FigureDetailCopyWith(
          _FigureDetail value, $Res Function(_FigureDetail) _then) =
      __$FigureDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'birth_date') String? birthDate,
      @JsonKey(name: 'death_date') String? deathDate,
      String? family,
      @JsonKey(name: 'role_description') String roleDescription});
}

/// @nodoc
class __$FigureDetailCopyWithImpl<$Res>
    implements _$FigureDetailCopyWith<$Res> {
  __$FigureDetailCopyWithImpl(this._self, this._then);

  final _FigureDetail _self;
  final $Res Function(_FigureDetail) _then;

  /// Create a copy of FigureDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? birthDate = freezed,
    Object? deathDate = freezed,
    Object? family = freezed,
    Object? roleDescription = null,
  }) {
    return _then(_FigureDetail(
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
    ));
  }
}

// dart format on
