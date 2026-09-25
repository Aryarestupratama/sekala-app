// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'case_study_badge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CaseStudyBadge {
  String get name;
  String? get description;
  @JsonKey(name: 'image_link')
  String? get imageLink;
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of CaseStudyBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CaseStudyBadgeCopyWith<CaseStudyBadge> get copyWith =>
      _$CaseStudyBadgeCopyWithImpl<CaseStudyBadge>(
          this as CaseStudyBadge, _$identity);

  /// Serializes this CaseStudyBadge to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CaseStudyBadge &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageLink, imageLink) ||
                other.imageLink == imageLink) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, imageLink, imageUrl);

  @override
  String toString() {
    return 'CaseStudyBadge(name: $name, description: $description, imageLink: $imageLink, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class $CaseStudyBadgeCopyWith<$Res> {
  factory $CaseStudyBadgeCopyWith(
          CaseStudyBadge value, $Res Function(CaseStudyBadge) _then) =
      _$CaseStudyBadgeCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String? description,
      @JsonKey(name: 'image_link') String? imageLink,
      @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class _$CaseStudyBadgeCopyWithImpl<$Res>
    implements $CaseStudyBadgeCopyWith<$Res> {
  _$CaseStudyBadgeCopyWithImpl(this._self, this._then);

  final CaseStudyBadge _self;
  final $Res Function(CaseStudyBadge) _then;

  /// Create a copy of CaseStudyBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? imageLink = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(CaseStudyBadge(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageLink: freezed == imageLink
          ? _self.imageLink
          : imageLink // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CaseStudyBadge].
extension CaseStudyBadgePatterns on CaseStudyBadge {
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
    TResult Function(_CaseStudyBadge value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudyBadge() when $default != null:
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
    TResult Function(_CaseStudyBadge value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyBadge():
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
    TResult? Function(_CaseStudyBadge value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyBadge() when $default != null:
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
            String name,
            String? description,
            @JsonKey(name: 'image_link') String? imageLink,
            @JsonKey(name: 'image_url') String? imageUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudyBadge() when $default != null:
        return $default(
            _that.name, _that.description, _that.imageLink, _that.imageUrl);
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
            String name,
            String? description,
            @JsonKey(name: 'image_link') String? imageLink,
            @JsonKey(name: 'image_url') String? imageUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyBadge():
        return $default(
            _that.name, _that.description, _that.imageLink, _that.imageUrl);
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
            String name,
            String? description,
            @JsonKey(name: 'image_link') String? imageLink,
            @JsonKey(name: 'image_url') String? imageUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyBadge() when $default != null:
        return $default(
            _that.name, _that.description, _that.imageLink, _that.imageUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CaseStudyBadge implements CaseStudyBadge {
  const _CaseStudyBadge(
      {this.name = '',
      this.description,
      @JsonKey(name: 'image_link') this.imageLink,
      @JsonKey(name: 'image_url') this.imageUrl});
  factory _CaseStudyBadge.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyBadgeFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  final String? description;
  @override
  @JsonKey(name: 'image_link')
  final String? imageLink;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  /// Create a copy of CaseStudyBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CaseStudyBadgeCopyWith<_CaseStudyBadge> get copyWith =>
      __$CaseStudyBadgeCopyWithImpl<_CaseStudyBadge>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CaseStudyBadgeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CaseStudyBadge &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageLink, imageLink) ||
                other.imageLink == imageLink) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, description, imageLink, imageUrl);

  @override
  String toString() {
    return 'CaseStudyBadge(name: $name, description: $description, imageLink: $imageLink, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class _$CaseStudyBadgeCopyWith<$Res>
    implements $CaseStudyBadgeCopyWith<$Res> {
  factory _$CaseStudyBadgeCopyWith(
          _CaseStudyBadge value, $Res Function(_CaseStudyBadge) _then) =
      __$CaseStudyBadgeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      String? description,
      @JsonKey(name: 'image_link') String? imageLink,
      @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class __$CaseStudyBadgeCopyWithImpl<$Res>
    implements _$CaseStudyBadgeCopyWith<$Res> {
  __$CaseStudyBadgeCopyWithImpl(this._self, this._then);

  final _CaseStudyBadge _self;
  final $Res Function(_CaseStudyBadge) _then;

  /// Create a copy of CaseStudyBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? imageLink = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_CaseStudyBadge(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageLink: freezed == imageLink
          ? _self.imageLink
          : imageLink // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
