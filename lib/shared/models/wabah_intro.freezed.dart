// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wabah_intro.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WabahIntro {
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  String? get caption;

  /// Create a copy of WabahIntro
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WabahIntroCopyWith<WabahIntro> get copyWith =>
      _$WabahIntroCopyWithImpl<WabahIntro>(this as WabahIntro, _$identity);

  /// Serializes this WabahIntro to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WabahIntro &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.caption, caption) || other.caption == caption));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, caption);

  @override
  String toString() {
    return 'WabahIntro(imageUrl: $imageUrl, caption: $caption)';
  }
}

/// @nodoc
abstract mixin class $WabahIntroCopyWith<$Res> {
  factory $WabahIntroCopyWith(
          WabahIntro value, $Res Function(WabahIntro) _then) =
      _$WabahIntroCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'image_url') String? imageUrl, String? caption});
}

/// @nodoc
class _$WabahIntroCopyWithImpl<$Res> implements $WabahIntroCopyWith<$Res> {
  _$WabahIntroCopyWithImpl(this._self, this._then);

  final WabahIntro _self;
  final $Res Function(WabahIntro) _then;

  /// Create a copy of WabahIntro
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageUrl = freezed,
    Object? caption = freezed,
  }) {
    return _then(WabahIntro(
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [WabahIntro].
extension WabahIntroPatterns on WabahIntro {
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
    TResult Function(_WabahIntro value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WabahIntro() when $default != null:
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
    TResult Function(_WabahIntro value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WabahIntro():
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
    TResult? Function(_WabahIntro value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WabahIntro() when $default != null:
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
            @JsonKey(name: 'image_url') String? imageUrl, String? caption)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WabahIntro() when $default != null:
        return $default(_that.imageUrl, _that.caption);
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
            @JsonKey(name: 'image_url') String? imageUrl, String? caption)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WabahIntro():
        return $default(_that.imageUrl, _that.caption);
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
            @JsonKey(name: 'image_url') String? imageUrl, String? caption)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WabahIntro() when $default != null:
        return $default(_that.imageUrl, _that.caption);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _WabahIntro implements WabahIntro {
  const _WabahIntro({@JsonKey(name: 'image_url') this.imageUrl, this.caption});
  factory _WabahIntro.fromJson(Map<String, dynamic> json) =>
      _$WabahIntroFromJson(json);

  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  final String? caption;

  /// Create a copy of WabahIntro
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WabahIntroCopyWith<_WabahIntro> get copyWith =>
      __$WabahIntroCopyWithImpl<_WabahIntro>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WabahIntroToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WabahIntro &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.caption, caption) || other.caption == caption));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, imageUrl, caption);

  @override
  String toString() {
    return 'WabahIntro(imageUrl: $imageUrl, caption: $caption)';
  }
}

/// @nodoc
abstract mixin class _$WabahIntroCopyWith<$Res>
    implements $WabahIntroCopyWith<$Res> {
  factory _$WabahIntroCopyWith(
          _WabahIntro value, $Res Function(_WabahIntro) _then) =
      __$WabahIntroCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'image_url') String? imageUrl, String? caption});
}

/// @nodoc
class __$WabahIntroCopyWithImpl<$Res> implements _$WabahIntroCopyWith<$Res> {
  __$WabahIntroCopyWithImpl(this._self, this._then);

  final _WabahIntro _self;
  final $Res Function(_WabahIntro) _then;

  /// Create a copy of WabahIntro
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? imageUrl = freezed,
    Object? caption = freezed,
  }) {
    return _then(_WabahIntro(
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      caption: freezed == caption
          ? _self.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
