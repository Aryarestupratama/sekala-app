// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'figure_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FigureCard {
  int get id;
  String get name;
  @JsonKey(name: 'photo_url')
  String? get photoUrl;
  @JsonKey(name: 'unlocked', defaultValue: false)
  bool get unlocked;

  /// Create a copy of FigureCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FigureCardCopyWith<FigureCard> get copyWith =>
      _$FigureCardCopyWithImpl<FigureCard>(this as FigureCard, _$identity);

  /// Serializes this FigureCard to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FigureCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photoUrl, unlocked);

  @override
  String toString() {
    return 'FigureCard(id: $id, name: $name, photoUrl: $photoUrl, unlocked: $unlocked)';
  }
}

/// @nodoc
abstract mixin class $FigureCardCopyWith<$Res> {
  factory $FigureCardCopyWith(
          FigureCard value, $Res Function(FigureCard) _then) =
      _$FigureCardCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked});
}

/// @nodoc
class _$FigureCardCopyWithImpl<$Res> implements $FigureCardCopyWith<$Res> {
  _$FigureCardCopyWithImpl(this._self, this._then);

  final FigureCard _self;
  final $Res Function(FigureCard) _then;

  /// Create a copy of FigureCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? unlocked = null,
  }) {
    return _then(FigureCard(
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
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [FigureCard].
extension FigureCardPatterns on FigureCard {
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
    TResult Function(_FigureCard value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FigureCard() when $default != null:
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
    TResult Function(_FigureCard value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FigureCard():
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
    TResult? Function(_FigureCard value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FigureCard() when $default != null:
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
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FigureCard() when $default != null:
        return $default(_that.id, _that.name, _that.photoUrl, _that.unlocked);
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
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FigureCard():
        return $default(_that.id, _that.name, _that.photoUrl, _that.unlocked);
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
            @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FigureCard() when $default != null:
        return $default(_that.id, _that.name, _that.photoUrl, _that.unlocked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _FigureCard implements FigureCard {
  const _FigureCard(
      {required this.id,
      required this.name,
      @JsonKey(name: 'photo_url') this.photoUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) required this.unlocked});
  factory _FigureCard.fromJson(Map<String, dynamic> json) =>
      _$FigureCardFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @override
  @JsonKey(name: 'unlocked', defaultValue: false)
  final bool unlocked;

  /// Create a copy of FigureCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FigureCardCopyWith<_FigureCard> get copyWith =>
      __$FigureCardCopyWithImpl<_FigureCard>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FigureCardToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FigureCard &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, photoUrl, unlocked);

  @override
  String toString() {
    return 'FigureCard(id: $id, name: $name, photoUrl: $photoUrl, unlocked: $unlocked)';
  }
}

/// @nodoc
abstract mixin class _$FigureCardCopyWith<$Res>
    implements $FigureCardCopyWith<$Res> {
  factory _$FigureCardCopyWith(
          _FigureCard value, $Res Function(_FigureCard) _then) =
      __$FigureCardCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'photo_url') String? photoUrl,
      @JsonKey(name: 'unlocked', defaultValue: false) bool unlocked});
}

/// @nodoc
class __$FigureCardCopyWithImpl<$Res> implements _$FigureCardCopyWith<$Res> {
  __$FigureCardCopyWithImpl(this._self, this._then);

  final _FigureCard _self;
  final $Res Function(_FigureCard) _then;

  /// Create a copy of FigureCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? photoUrl = freezed,
    Object? unlocked = null,
  }) {
    return _then(_FigureCard(
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
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
