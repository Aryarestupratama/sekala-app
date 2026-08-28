// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentBlock {
  int get id;
  ContentBlockType get type;
  String get content;
  @JsonKey(name: 'resolved_url')
  String? get resolvedUrl;
  int get order;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ContentBlockCopyWith<ContentBlock> get copyWith =>
      _$ContentBlockCopyWithImpl<ContentBlock>(
          this as ContentBlock, _$identity);

  /// Serializes this ContentBlock to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ContentBlock &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.resolvedUrl, resolvedUrl) ||
                other.resolvedUrl == resolvedUrl) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, content, resolvedUrl, order);

  @override
  String toString() {
    return 'ContentBlock(id: $id, type: $type, content: $content, resolvedUrl: $resolvedUrl, order: $order)';
  }
}

/// @nodoc
abstract mixin class $ContentBlockCopyWith<$Res> {
  factory $ContentBlockCopyWith(
          ContentBlock value, $Res Function(ContentBlock) _then) =
      _$ContentBlockCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      ContentBlockType type,
      String content,
      @JsonKey(name: 'resolved_url') String? resolvedUrl,
      int order});
}

/// @nodoc
class _$ContentBlockCopyWithImpl<$Res> implements $ContentBlockCopyWith<$Res> {
  _$ContentBlockCopyWithImpl(this._self, this._then);

  final ContentBlock _self;
  final $Res Function(ContentBlock) _then;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? content = null,
    Object? resolvedUrl = freezed,
    Object? order = null,
  }) {
    return _then(ContentBlock(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentBlockType,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedUrl: freezed == resolvedUrl
          ? _self.resolvedUrl
          : resolvedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ContentBlock].
extension ContentBlockPatterns on ContentBlock {
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
    TResult Function(_ContentBlock value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentBlock() when $default != null:
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
    TResult Function(_ContentBlock value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentBlock():
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
    TResult? Function(_ContentBlock value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentBlock() when $default != null:
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
    TResult Function(int id, ContentBlockType type, String content,
            @JsonKey(name: 'resolved_url') String? resolvedUrl, int order)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ContentBlock() when $default != null:
        return $default(_that.id, _that.type, _that.content, _that.resolvedUrl,
            _that.order);
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
    TResult Function(int id, ContentBlockType type, String content,
            @JsonKey(name: 'resolved_url') String? resolvedUrl, int order)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentBlock():
        return $default(_that.id, _that.type, _that.content, _that.resolvedUrl,
            _that.order);
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
    TResult? Function(int id, ContentBlockType type, String content,
            @JsonKey(name: 'resolved_url') String? resolvedUrl, int order)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ContentBlock() when $default != null:
        return $default(_that.id, _that.type, _that.content, _that.resolvedUrl,
            _that.order);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ContentBlock implements ContentBlock {
  const _ContentBlock(
      {required this.id,
      required this.type,
      required this.content,
      @JsonKey(name: 'resolved_url') this.resolvedUrl,
      required this.order});
  factory _ContentBlock.fromJson(Map<String, dynamic> json) =>
      _$ContentBlockFromJson(json);

  @override
  final int id;
  @override
  final ContentBlockType type;
  @override
  final String content;
  @override
  @JsonKey(name: 'resolved_url')
  final String? resolvedUrl;
  @override
  final int order;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ContentBlockCopyWith<_ContentBlock> get copyWith =>
      __$ContentBlockCopyWithImpl<_ContentBlock>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ContentBlockToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ContentBlock &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.resolvedUrl, resolvedUrl) ||
                other.resolvedUrl == resolvedUrl) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, content, resolvedUrl, order);

  @override
  String toString() {
    return 'ContentBlock(id: $id, type: $type, content: $content, resolvedUrl: $resolvedUrl, order: $order)';
  }
}

/// @nodoc
abstract mixin class _$ContentBlockCopyWith<$Res>
    implements $ContentBlockCopyWith<$Res> {
  factory _$ContentBlockCopyWith(
          _ContentBlock value, $Res Function(_ContentBlock) _then) =
      __$ContentBlockCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      ContentBlockType type,
      String content,
      @JsonKey(name: 'resolved_url') String? resolvedUrl,
      int order});
}

/// @nodoc
class __$ContentBlockCopyWithImpl<$Res>
    implements _$ContentBlockCopyWith<$Res> {
  __$ContentBlockCopyWithImpl(this._self, this._then);

  final _ContentBlock _self;
  final $Res Function(_ContentBlock) _then;

  /// Create a copy of ContentBlock
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? content = null,
    Object? resolvedUrl = freezed,
    Object? order = null,
  }) {
    return _then(_ContentBlock(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ContentBlockType,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      resolvedUrl: freezed == resolvedUrl
          ? _self.resolvedUrl
          : resolvedUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
