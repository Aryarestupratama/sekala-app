// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Section {
  int get id;
  String get title;
  SectionYear get year;
  @JsonKey(name: 'header_image_url')
  String? get headerImageUrl;
  @JsonKey(name: 'content_blocks')
  List<ContentBlock> get contentBlocks;

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SectionCopyWith<Section> get copyWith =>
      _$SectionCopyWithImpl<Section>(this as Section, _$identity);

  /// Serializes this Section to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Section &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.headerImageUrl, headerImageUrl) ||
                other.headerImageUrl == headerImageUrl) &&
            const DeepCollectionEquality()
                .equals(other.contentBlocks, contentBlocks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, year, headerImageUrl,
      const DeepCollectionEquality().hash(contentBlocks));

  @override
  String toString() {
    return 'Section(id: $id, title: $title, year: $year, headerImageUrl: $headerImageUrl, contentBlocks: $contentBlocks)';
  }
}

/// @nodoc
abstract mixin class $SectionCopyWith<$Res> {
  factory $SectionCopyWith(Section value, $Res Function(Section) _then) =
      _$SectionCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      SectionYear year,
      @JsonKey(name: 'header_image_url') String? headerImageUrl,
      @JsonKey(name: 'content_blocks') List<ContentBlock> contentBlocks});

  $SectionYearCopyWith<$Res> get year;
}

/// @nodoc
class _$SectionCopyWithImpl<$Res> implements $SectionCopyWith<$Res> {
  _$SectionCopyWithImpl(this._self, this._then);

  final Section _self;
  final $Res Function(Section) _then;

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? year = null,
    Object? headerImageUrl = freezed,
    Object? contentBlocks = null,
  }) {
    return _then(Section(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as SectionYear,
      headerImageUrl: freezed == headerImageUrl
          ? _self.headerImageUrl
          : headerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contentBlocks: null == contentBlocks
          ? _self.contentBlocks
          : contentBlocks // ignore: cast_nullable_to_non_nullable
              as List<ContentBlock>,
    ));
  }

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SectionYearCopyWith<$Res> get year {
    return $SectionYearCopyWith<$Res>(_self.year, (value) {
      return _then(_self.copyWith(year: value));
    });
  }
}

/// Adds pattern-matching-related methods to [Section].
extension SectionPatterns on Section {
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
    TResult Function(_Section value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Section() when $default != null:
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
    TResult Function(_Section value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Section():
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
    TResult? Function(_Section value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Section() when $default != null:
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
            String title,
            SectionYear year,
            @JsonKey(name: 'header_image_url') String? headerImageUrl,
            @JsonKey(name: 'content_blocks') List<ContentBlock> contentBlocks)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Section() when $default != null:
        return $default(_that.id, _that.title, _that.year, _that.headerImageUrl,
            _that.contentBlocks);
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
            String title,
            SectionYear year,
            @JsonKey(name: 'header_image_url') String? headerImageUrl,
            @JsonKey(name: 'content_blocks') List<ContentBlock> contentBlocks)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Section():
        return $default(_that.id, _that.title, _that.year, _that.headerImageUrl,
            _that.contentBlocks);
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
            String title,
            SectionYear year,
            @JsonKey(name: 'header_image_url') String? headerImageUrl,
            @JsonKey(name: 'content_blocks') List<ContentBlock> contentBlocks)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Section() when $default != null:
        return $default(_that.id, _that.title, _that.year, _that.headerImageUrl,
            _that.contentBlocks);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Section implements Section {
  const _Section(
      {required this.id,
      required this.title,
      required this.year,
      @JsonKey(name: 'header_image_url') this.headerImageUrl,
      @JsonKey(name: 'content_blocks')
      List<ContentBlock> contentBlocks = const <ContentBlock>[]})
      : _contentBlocks = contentBlocks;
  factory _Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final SectionYear year;
  @override
  @JsonKey(name: 'header_image_url')
  final String? headerImageUrl;
  final List<ContentBlock> _contentBlocks;
  @override
  @JsonKey(name: 'content_blocks')
  List<ContentBlock> get contentBlocks {
    if (_contentBlocks is EqualUnmodifiableListView) return _contentBlocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contentBlocks);
  }

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SectionCopyWith<_Section> get copyWith =>
      __$SectionCopyWithImpl<_Section>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SectionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Section &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.headerImageUrl, headerImageUrl) ||
                other.headerImageUrl == headerImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._contentBlocks, _contentBlocks));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, year, headerImageUrl,
      const DeepCollectionEquality().hash(_contentBlocks));

  @override
  String toString() {
    return 'Section(id: $id, title: $title, year: $year, headerImageUrl: $headerImageUrl, contentBlocks: $contentBlocks)';
  }
}

/// @nodoc
abstract mixin class _$SectionCopyWith<$Res> implements $SectionCopyWith<$Res> {
  factory _$SectionCopyWith(_Section value, $Res Function(_Section) _then) =
      __$SectionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      SectionYear year,
      @JsonKey(name: 'header_image_url') String? headerImageUrl,
      @JsonKey(name: 'content_blocks') List<ContentBlock> contentBlocks});

  @override
  $SectionYearCopyWith<$Res> get year;
}

/// @nodoc
class __$SectionCopyWithImpl<$Res> implements _$SectionCopyWith<$Res> {
  __$SectionCopyWithImpl(this._self, this._then);

  final _Section _self;
  final $Res Function(_Section) _then;

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? year = null,
    Object? headerImageUrl = freezed,
    Object? contentBlocks = null,
  }) {
    return _then(_Section(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as SectionYear,
      headerImageUrl: freezed == headerImageUrl
          ? _self.headerImageUrl
          : headerImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      contentBlocks: null == contentBlocks
          ? _self._contentBlocks
          : contentBlocks // ignore: cast_nullable_to_non_nullable
              as List<ContentBlock>,
    ));
  }

  /// Create a copy of Section
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SectionYearCopyWith<$Res> get year {
    return $SectionYearCopyWith<$Res>(_self.year, (value) {
      return _then(_self.copyWith(year: value));
    });
  }
}

// dart format on
