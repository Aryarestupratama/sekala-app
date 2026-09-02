// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vaccine_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VaccineDetail {
  int get id;
  String get name;
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @JsonKey(name: 'photo_locked_url')
  String? get photoLockedUrl;
  String? get manufacturer;
  @JsonKey(name: 'disease_target')
  String get diseaseTarget;
  @JsonKey(name: 'year_introduced')
  int? get yearIntroduced;
  String get description;

  /// Create a copy of VaccineDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $VaccineDetailCopyWith<VaccineDetail> get copyWith =>
      _$VaccineDetailCopyWithImpl<VaccineDetail>(
          this as VaccineDetail, _$identity);

  /// Serializes this VaccineDetail to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is VaccineDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.photoLockedUrl, photoLockedUrl) ||
                other.photoLockedUrl == photoLockedUrl) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.diseaseTarget, diseaseTarget) ||
                other.diseaseTarget == diseaseTarget) &&
            (identical(other.yearIntroduced, yearIntroduced) ||
                other.yearIntroduced == yearIntroduced) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photoUrl,
      photoLockedUrl, manufacturer, diseaseTarget, yearIntroduced, description);

  @override
  String toString() {
    return 'VaccineDetail(id: $id, name: $name, photoUrl: $photoUrl, photoLockedUrl: $photoLockedUrl, manufacturer: $manufacturer, diseaseTarget: $diseaseTarget, yearIntroduced: $yearIntroduced, description: $description)';
  }
}

/// @nodoc
abstract mixin class $VaccineDetailCopyWith<$Res> {
  factory $VaccineDetailCopyWith(
          VaccineDetail value, $Res Function(VaccineDetail) _then) =
      _$VaccineDetailCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,
      String? manufacturer,
      @JsonKey(name: 'disease_target') String diseaseTarget,
      @JsonKey(name: 'year_introduced') int? yearIntroduced,
      String description});
}

/// @nodoc
class _$VaccineDetailCopyWithImpl<$Res>
    implements $VaccineDetailCopyWith<$Res> {
  _$VaccineDetailCopyWithImpl(this._self, this._then);

  final VaccineDetail _self;
  final $Res Function(VaccineDetail) _then;

  /// Create a copy of VaccineDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? photoLockedUrl = freezed,
    Object? manufacturer = freezed,
    Object? diseaseTarget = null,
    Object? yearIntroduced = freezed,
    Object? description = null,
  }) {
    return _then(VaccineDetail(
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
      manufacturer: freezed == manufacturer
          ? _self.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      diseaseTarget: null == diseaseTarget
          ? _self.diseaseTarget
          : diseaseTarget // ignore: cast_nullable_to_non_nullable
              as String,
      yearIntroduced: freezed == yearIntroduced
          ? _self.yearIntroduced
          : yearIntroduced // ignore: cast_nullable_to_non_nullable
              as int?,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [VaccineDetail].
extension VaccineDetailPatterns on VaccineDetail {
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
    TResult Function(_VaccineDetail value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineDetail() when $default != null:
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
    TResult Function(_VaccineDetail value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetail():
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
    TResult? Function(_VaccineDetail value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetail() when $default != null:
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
            String? manufacturer,
            @JsonKey(name: 'disease_target') String diseaseTarget,
            @JsonKey(name: 'year_introduced') int? yearIntroduced,
            String description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _VaccineDetail() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.photoUrl,
            _that.photoLockedUrl,
            _that.manufacturer,
            _that.diseaseTarget,
            _that.yearIntroduced,
            _that.description);
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
            String? manufacturer,
            @JsonKey(name: 'disease_target') String diseaseTarget,
            @JsonKey(name: 'year_introduced') int? yearIntroduced,
            String description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetail():
        return $default(
            _that.id,
            _that.name,
            _that.photoUrl,
            _that.photoLockedUrl,
            _that.manufacturer,
            _that.diseaseTarget,
            _that.yearIntroduced,
            _that.description);
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
            String? manufacturer,
            @JsonKey(name: 'disease_target') String diseaseTarget,
            @JsonKey(name: 'year_introduced') int? yearIntroduced,
            String description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _VaccineDetail() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.photoUrl,
            _that.photoLockedUrl,
            _that.manufacturer,
            _that.diseaseTarget,
            _that.yearIntroduced,
            _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _VaccineDetail implements VaccineDetail {
  const _VaccineDetail(
      {required this.id,
      required this.name,
      @JsonKey(name: 'photo_url') this.photoUrl,
      @JsonKey(name: 'photo_locked_url') this.photoLockedUrl,
      this.manufacturer,
      @JsonKey(name: 'disease_target') required this.diseaseTarget,
      @JsonKey(name: 'year_introduced') this.yearIntroduced,
      required this.description});
  factory _VaccineDetail.fromJson(Map<String, dynamic> json) =>
      _$VaccineDetailFromJson(json);

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
  final String? manufacturer;
  @override
  @JsonKey(name: 'disease_target')
  final String diseaseTarget;
  @override
  @JsonKey(name: 'year_introduced')
  final int? yearIntroduced;
  @override
  final String description;

  /// Create a copy of VaccineDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$VaccineDetailCopyWith<_VaccineDetail> get copyWith =>
      __$VaccineDetailCopyWithImpl<_VaccineDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$VaccineDetailToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VaccineDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.photoLockedUrl, photoLockedUrl) ||
                other.photoLockedUrl == photoLockedUrl) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.diseaseTarget, diseaseTarget) ||
                other.diseaseTarget == diseaseTarget) &&
            (identical(other.yearIntroduced, yearIntroduced) ||
                other.yearIntroduced == yearIntroduced) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photoUrl,
      photoLockedUrl, manufacturer, diseaseTarget, yearIntroduced, description);

  @override
  String toString() {
    return 'VaccineDetail(id: $id, name: $name, photoUrl: $photoUrl, photoLockedUrl: $photoLockedUrl, manufacturer: $manufacturer, diseaseTarget: $diseaseTarget, yearIntroduced: $yearIntroduced, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$VaccineDetailCopyWith<$Res>
    implements $VaccineDetailCopyWith<$Res> {
  factory _$VaccineDetailCopyWith(
          _VaccineDetail value, $Res Function(_VaccineDetail) _then) =
      __$VaccineDetailCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'photo_locked_url') String? photoLockedUrl,
      String? manufacturer,
      @JsonKey(name: 'disease_target') String diseaseTarget,
      @JsonKey(name: 'year_introduced') int? yearIntroduced,
      String description});
}

/// @nodoc
class __$VaccineDetailCopyWithImpl<$Res>
    implements _$VaccineDetailCopyWith<$Res> {
  __$VaccineDetailCopyWithImpl(this._self, this._then);

  final _VaccineDetail _self;
  final $Res Function(_VaccineDetail) _then;

  /// Create a copy of VaccineDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? photoLockedUrl = freezed,
    Object? manufacturer = freezed,
    Object? diseaseTarget = null,
    Object? yearIntroduced = freezed,
    Object? description = null,
  }) {
    return _then(_VaccineDetail(
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
      manufacturer: freezed == manufacturer
          ? _self.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      diseaseTarget: null == diseaseTarget
          ? _self.diseaseTarget
          : diseaseTarget // ignore: cast_nullable_to_non_nullable
              as String,
      yearIntroduced: freezed == yearIntroduced
          ? _self.yearIntroduced
          : yearIntroduced // ignore: cast_nullable_to_non_nullable
              as int?,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
