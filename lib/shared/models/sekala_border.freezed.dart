// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sekala_border.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SekalaBorder {
  @JsonKey(name: 'is_published')
  bool get isPublished;
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of SekalaBorder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SekalaBorderCopyWith<SekalaBorder> get copyWith =>
      _$SekalaBorderCopyWithImpl<SekalaBorder>(
          this as SekalaBorder, _$identity);

  /// Serializes this SekalaBorder to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SekalaBorder &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isPublished, imageUrl);

  @override
  String toString() {
    return 'SekalaBorder(isPublished: $isPublished, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class $SekalaBorderCopyWith<$Res> {
  factory $SekalaBorderCopyWith(
          SekalaBorder value, $Res Function(SekalaBorder) _then) =
      _$SekalaBorderCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_published') bool isPublished,
      @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class _$SekalaBorderCopyWithImpl<$Res> implements $SekalaBorderCopyWith<$Res> {
  _$SekalaBorderCopyWithImpl(this._self, this._then);

  final SekalaBorder _self;
  final $Res Function(SekalaBorder) _then;

  /// Create a copy of SekalaBorder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isPublished = null,
    Object? imageUrl = freezed,
  }) {
    return _then(SekalaBorder(
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SekalaBorder].
extension SekalaBorderPatterns on SekalaBorder {
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
    TResult Function(_SekalaBorder value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SekalaBorder() when $default != null:
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
    TResult Function(_SekalaBorder value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SekalaBorder():
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
    TResult? Function(_SekalaBorder value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SekalaBorder() when $default != null:
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
    TResult Function(@JsonKey(name: 'is_published') bool isPublished,
            @JsonKey(name: 'image_url') String? imageUrl)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SekalaBorder() when $default != null:
        return $default(_that.isPublished, _that.imageUrl);
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
    TResult Function(@JsonKey(name: 'is_published') bool isPublished,
            @JsonKey(name: 'image_url') String? imageUrl)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SekalaBorder():
        return $default(_that.isPublished, _that.imageUrl);
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
    TResult? Function(@JsonKey(name: 'is_published') bool isPublished,
            @JsonKey(name: 'image_url') String? imageUrl)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SekalaBorder() when $default != null:
        return $default(_that.isPublished, _that.imageUrl);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SekalaBorder extends SekalaBorder {
  const _SekalaBorder(
      {@JsonKey(name: 'is_published') this.isPublished = false,
      @JsonKey(name: 'image_url') this.imageUrl})
      : super._();
  factory _SekalaBorder.fromJson(Map<String, dynamic> json) =>
      _$SekalaBorderFromJson(json);

  @override
  @JsonKey(name: 'is_published')
  final bool isPublished;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  /// Create a copy of SekalaBorder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SekalaBorderCopyWith<_SekalaBorder> get copyWith =>
      __$SekalaBorderCopyWithImpl<_SekalaBorder>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SekalaBorderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SekalaBorder &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isPublished, imageUrl);

  @override
  String toString() {
    return 'SekalaBorder(isPublished: $isPublished, imageUrl: $imageUrl)';
  }
}

/// @nodoc
abstract mixin class _$SekalaBorderCopyWith<$Res>
    implements $SekalaBorderCopyWith<$Res> {
  factory _$SekalaBorderCopyWith(
          _SekalaBorder value, $Res Function(_SekalaBorder) _then) =
      __$SekalaBorderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_published') bool isPublished,
      @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class __$SekalaBorderCopyWithImpl<$Res>
    implements _$SekalaBorderCopyWith<$Res> {
  __$SekalaBorderCopyWithImpl(this._self, this._then);

  final _SekalaBorder _self;
  final $Res Function(_SekalaBorder) _then;

  /// Create a copy of SekalaBorder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isPublished = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_SekalaBorder(
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      imageUrl: freezed == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
