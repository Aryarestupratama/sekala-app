// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BadgeListMeta {
  int get total;
  int get unlocked;

  /// Create a copy of BadgeListMeta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BadgeListMetaCopyWith<BadgeListMeta> get copyWith =>
      _$BadgeListMetaCopyWithImpl<BadgeListMeta>(
          this as BadgeListMeta, _$identity);

  /// Serializes this BadgeListMeta to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BadgeListMeta &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, unlocked);

  @override
  String toString() {
    return 'BadgeListMeta(total: $total, unlocked: $unlocked)';
  }
}

/// @nodoc
abstract mixin class $BadgeListMetaCopyWith<$Res> {
  factory $BadgeListMetaCopyWith(
          BadgeListMeta value, $Res Function(BadgeListMeta) _then) =
      _$BadgeListMetaCopyWithImpl;
  @useResult
  $Res call({int total, int unlocked});
}

/// @nodoc
class _$BadgeListMetaCopyWithImpl<$Res>
    implements $BadgeListMetaCopyWith<$Res> {
  _$BadgeListMetaCopyWithImpl(this._self, this._then);

  final BadgeListMeta _self;
  final $Res Function(BadgeListMeta) _then;

  /// Create a copy of BadgeListMeta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? unlocked = null,
  }) {
    return _then(BadgeListMeta(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [BadgeListMeta].
extension BadgeListMetaPatterns on BadgeListMeta {
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
    TResult Function(_BadgeListMeta value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeListMeta() when $default != null:
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
    TResult Function(_BadgeListMeta value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeListMeta():
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
    TResult? Function(_BadgeListMeta value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeListMeta() when $default != null:
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
    TResult Function(int total, int unlocked)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeListMeta() when $default != null:
        return $default(_that.total, _that.unlocked);
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
    TResult Function(int total, int unlocked) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeListMeta():
        return $default(_that.total, _that.unlocked);
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
    TResult? Function(int total, int unlocked)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeListMeta() when $default != null:
        return $default(_that.total, _that.unlocked);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BadgeListMeta implements BadgeListMeta {
  const _BadgeListMeta({this.total = 0, this.unlocked = 0});
  factory _BadgeListMeta.fromJson(Map<String, dynamic> json) =>
      _$BadgeListMetaFromJson(json);

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int unlocked;

  /// Create a copy of BadgeListMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BadgeListMetaCopyWith<_BadgeListMeta> get copyWith =>
      __$BadgeListMetaCopyWithImpl<_BadgeListMeta>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BadgeListMetaToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BadgeListMeta &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.unlocked, unlocked) ||
                other.unlocked == unlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, total, unlocked);

  @override
  String toString() {
    return 'BadgeListMeta(total: $total, unlocked: $unlocked)';
  }
}

/// @nodoc
abstract mixin class _$BadgeListMetaCopyWith<$Res>
    implements $BadgeListMetaCopyWith<$Res> {
  factory _$BadgeListMetaCopyWith(
          _BadgeListMeta value, $Res Function(_BadgeListMeta) _then) =
      __$BadgeListMetaCopyWithImpl;
  @override
  @useResult
  $Res call({int total, int unlocked});
}

/// @nodoc
class __$BadgeListMetaCopyWithImpl<$Res>
    implements _$BadgeListMetaCopyWith<$Res> {
  __$BadgeListMetaCopyWithImpl(this._self, this._then);

  final _BadgeListMeta _self;
  final $Res Function(_BadgeListMeta) _then;

  /// Create a copy of BadgeListMeta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? total = null,
    Object? unlocked = null,
  }) {
    return _then(_BadgeListMeta(
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      unlocked: null == unlocked
          ? _self.unlocked
          : unlocked // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
mixin _$BadgeListResponse {
  List<BadgeCard> get data;
  BadgeListMeta get meta;

  /// Create a copy of BadgeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BadgeListResponseCopyWith<BadgeListResponse> get copyWith =>
      _$BadgeListResponseCopyWithImpl<BadgeListResponse>(
          this as BadgeListResponse, _$identity);

  /// Serializes this BadgeListResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BadgeListResponse &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data), meta);

  @override
  String toString() {
    return 'BadgeListResponse(data: $data, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class $BadgeListResponseCopyWith<$Res> {
  factory $BadgeListResponseCopyWith(
          BadgeListResponse value, $Res Function(BadgeListResponse) _then) =
      _$BadgeListResponseCopyWithImpl;
  @useResult
  $Res call({List<BadgeCard> data, BadgeListMeta meta});

  $BadgeListMetaCopyWith<$Res> get meta;
}

/// @nodoc
class _$BadgeListResponseCopyWithImpl<$Res>
    implements $BadgeListResponseCopyWith<$Res> {
  _$BadgeListResponseCopyWithImpl(this._self, this._then);

  final BadgeListResponse _self;
  final $Res Function(BadgeListResponse) _then;

  /// Create a copy of BadgeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? meta = null,
  }) {
    return _then(BadgeListResponse(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<BadgeCard>,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as BadgeListMeta,
    ));
  }

  /// Create a copy of BadgeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BadgeListMetaCopyWith<$Res> get meta {
    return $BadgeListMetaCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

/// Adds pattern-matching-related methods to [BadgeListResponse].
extension BadgeListResponsePatterns on BadgeListResponse {
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
    TResult Function(_BadgeListResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeListResponse() when $default != null:
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
    TResult Function(_BadgeListResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeListResponse():
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
    TResult? Function(_BadgeListResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeListResponse() when $default != null:
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
    TResult Function(List<BadgeCard> data, BadgeListMeta meta)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BadgeListResponse() when $default != null:
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
    TResult Function(List<BadgeCard> data, BadgeListMeta meta) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeListResponse():
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
    TResult? Function(List<BadgeCard> data, BadgeListMeta meta)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BadgeListResponse() when $default != null:
        return $default(_that.data, _that.meta);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BadgeListResponse implements BadgeListResponse {
  const _BadgeListResponse(
      {List<BadgeCard> data = const <BadgeCard>[], required this.meta})
      : _data = data;
  factory _BadgeListResponse.fromJson(Map<String, dynamic> json) =>
      _$BadgeListResponseFromJson(json);

  final List<BadgeCard> _data;
  @override
  @JsonKey()
  List<BadgeCard> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final BadgeListMeta meta;

  /// Create a copy of BadgeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BadgeListResponseCopyWith<_BadgeListResponse> get copyWith =>
      __$BadgeListResponseCopyWithImpl<_BadgeListResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BadgeListResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BadgeListResponse &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), meta);

  @override
  String toString() {
    return 'BadgeListResponse(data: $data, meta: $meta)';
  }
}

/// @nodoc
abstract mixin class _$BadgeListResponseCopyWith<$Res>
    implements $BadgeListResponseCopyWith<$Res> {
  factory _$BadgeListResponseCopyWith(
          _BadgeListResponse value, $Res Function(_BadgeListResponse) _then) =
      __$BadgeListResponseCopyWithImpl;
  @override
  @useResult
  $Res call({List<BadgeCard> data, BadgeListMeta meta});

  @override
  $BadgeListMetaCopyWith<$Res> get meta;
}

/// @nodoc
class __$BadgeListResponseCopyWithImpl<$Res>
    implements _$BadgeListResponseCopyWith<$Res> {
  __$BadgeListResponseCopyWithImpl(this._self, this._then);

  final _BadgeListResponse _self;
  final $Res Function(_BadgeListResponse) _then;

  /// Create a copy of BadgeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? meta = null,
  }) {
    return _then(_BadgeListResponse(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<BadgeCard>,
      meta: null == meta
          ? _self.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as BadgeListMeta,
    ));
  }

  /// Create a copy of BadgeListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BadgeListMetaCopyWith<$Res> get meta {
    return $BadgeListMetaCopyWith<$Res>(_self.meta, (value) {
      return _then(_self.copyWith(meta: value));
    });
  }
}

// dart format on
