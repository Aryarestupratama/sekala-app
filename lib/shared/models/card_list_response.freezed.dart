// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardListMeta {
  int get total;
  int get unlocked;
  int get unseen;

  /// Create a copy of CardListMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardListMetaCopyWith<CardListMeta> get copyWith =>
      _$CardListMetaCopyWithImpl<CardListMeta>(
          this as CardListMeta, _$identity);

  /// Serializes this CardListMeta to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardListMeta &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked) &&
            (identical(other.unseen, unseen) || other.unseen == unseen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, unlocked, unseen);

  @override
  String toString() {
    return 'CardListMeta(total: $total, unlocked: $unlocked, unseen: $unseen)';
  }
}

/// @nodoc
abstract mixin class $CardListMetaCopyWith<$Res> {
  factory $CardListMetaCopyWith(
          CardListMeta value, $Res Function(CardListMeta) _then) =
      _$CardListMetaCopyWithImpl;
  @useResult
  $Res call({int total, int unlocked, int unseen});
}

/// @nodoc
class _$CardListMetaCopyWithImpl<$Res> implements $CardListMetaCopyWith<$Res> {
  _$CardListMetaCopyWithImpl(this._self, this._then);

  final CardListMeta _self;
  final $Res Function(CardListMeta) _then;

  /// Create a copy of CardListMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? unlocked = null,
    Object? unseen = null,
  }) {
    return _then(CardListMeta(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as int,
      unseen: null == unseen
          ? _self.unseen
          : unseen // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [CardListMeta].
extension CardListMetaPatterns on CardListMeta {
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
    TResult Function(_CardListMeta value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardListMeta() when $default != null:
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
    TResult Function(_CardListMeta value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardListMeta():
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
    TResult? Function(_CardListMeta value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardListMeta() when $default != null:
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
    TResult Function(int total, int unlocked, int unseen)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardListMeta() when $default != null:
        return $default(_that.total, _that.unlocked, _that.unseen);
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
    TResult Function(int total, int unlocked, int unseen) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardListMeta():
        return $default(_that.total, _that.unlocked, _that.unseen);
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
    TResult? Function(int total, int unlocked, int unseen)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardListMeta() when $default != null:
        return $default(_that.total, _that.unlocked, _that.unseen);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CardListMeta implements CardListMeta {
  const _CardListMeta(
      {required this.total, required this.unlocked, required this.unseen});
  factory _CardListMeta.fromJson(Map<String, dynamic> json) =>
      _$CardListMetaFromJson(json);

  @override
  final int total;
  @override
  final int unlocked;
  @override
  final int unseen;

  /// Create a copy of CardListMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardListMetaCopyWith<_CardListMeta> get copyWith =>
      __$CardListMetaCopyWithImpl<_CardListMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardListMetaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardListMeta &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked) &&
            (identical(other.unseen, unseen) || other.unseen == unseen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, unlocked, unseen);

  @override
  String toString() {
    return 'CardListMeta(total: $total, unlocked: $unlocked, unseen: $unseen)';
  }
}

/// @nodoc
abstract mixin class _$CardListMetaCopyWith<$Res>
    implements $CardListMetaCopyWith<$Res> {
  factory _$CardListMetaCopyWith(
          _CardListMeta value, $Res Function(_CardListMeta) _then) =
      __$CardListMetaCopyWithImpl;
  @override
  @useResult
  $Res call({int total, int unlocked, int unseen});
}

/// @nodoc
class __$CardListMetaCopyWithImpl<$Res>
    implements _$CardListMetaCopyWith<$Res> {
  __$CardListMetaCopyWithImpl(this._self, this._then);

  final _CardListMeta _self;
  final $Res Function(_CardListMeta) _then;

  /// Create a copy of CardListMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? total = null,
    Object? unlocked = null,
    Object? unseen = null,
  }) {
    return _then(_CardListMeta(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as int,
      unseen: null == unseen
          ? _self.unseen
          : unseen // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$CardListResponse {
  List<VaccineCard> get data;
  CardListMeta get meta;

  /// Create a copy of CardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CardListResponseCopyWith<CardListResponse> get copyWith =>
      _$CardListResponseCopyWithImpl<CardListResponse>(
          this as CardListResponse, _$identity);

  /// Serializes this CardListResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CardListResponse &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data), meta);

  @override
  String toString() {
    return 'CardListResponse(data: $data, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $CardListResponseCopyWith<$Res> {
  factory $CardListResponseCopyWith(
          CardListResponse value, $Res Function(CardListResponse) _then) =
      _$CardListResponseCopyWithImpl;
  @useResult
  $Res call({List<VaccineCard> data, CardListMeta meta});

  $CardListMetaCopyWith<$Res> get meta;
}

/// @nodoc
class _$CardListResponseCopyWithImpl<$Res>
    implements $CardListResponseCopyWith<$Res> {
  _$CardListResponseCopyWithImpl(this._self, this._then);

  final CardListResponse _self;
  final $Res Function(CardListResponse) _then;

  /// Create a copy of CardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? meta = null,
  }) {
    return _then(CardListResponse(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<VaccineCard>,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as CardListMeta,
    ));
  }

  /// Create a copy of CardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CardListMetaCopyWith<$Res> get meta {
    return $CardListMetaCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// Adds pattern-matching-related methods to [CardListResponse].
extension CardListResponsePatterns on CardListResponse {
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
    TResult Function(_CardListResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardListResponse() when $default != null:
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
    TResult Function(_CardListResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardListResponse():
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
    TResult? Function(_CardListResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardListResponse() when $default != null:
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
    TResult Function(List<VaccineCard> data, CardListMeta meta)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CardListResponse() when $default != null:
        return $default(_that.data, _that.meta);
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
    TResult Function(List<VaccineCard> data, CardListMeta meta) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardListResponse():
        return $default(_that.data, _that.meta);
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
    TResult? Function(List<VaccineCard> data, CardListMeta meta)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CardListResponse() when $default != null:
        return $default(_that.data, _that.meta);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CardListResponse implements CardListResponse {
  const _CardListResponse(
      {List<VaccineCard> data = const <VaccineCard>[], required this.meta})
      : _data = data;
  factory _CardListResponse.fromJson(Map<String, dynamic> json) =>
      _$CardListResponseFromJson(json);

  final List<VaccineCard> _data;
  @override
  @JsonKey()
  List<VaccineCard> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final CardListMeta meta;

  /// Create a copy of CardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CardListResponseCopyWith<_CardListResponse> get copyWith =>
      __$CardListResponseCopyWithImpl<_CardListResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CardListResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CardListResponse &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), meta);

  @override
  String toString() {
    return 'CardListResponse(data: $data, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class _$CardListResponseCopyWith<$Res>
    implements $CardListResponseCopyWith<$Res> {
  factory _$CardListResponseCopyWith(
          _CardListResponse value, $Res Function(_CardListResponse) _then) =
      __$CardListResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<VaccineCard> data, CardListMeta meta});

  @override
  $CardListMetaCopyWith<$Res> get meta;
}

/// @nodoc
class __$CardListResponseCopyWithImpl<$Res>
    implements _$CardListResponseCopyWith<$Res> {
  __$CardListResponseCopyWithImpl(this._self, this._then);

  final _CardListResponse _self;
  final $Res Function(_CardListResponse) _then;

  /// Create a copy of CardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? meta = null,
  }) {
    return _then(_CardListResponse(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<VaccineCard>,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as CardListMeta,
    ));
  }

  /// Create a copy of CardListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CardListMetaCopyWith<$Res> get meta {
    return $CardListMetaCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

// dart format on
