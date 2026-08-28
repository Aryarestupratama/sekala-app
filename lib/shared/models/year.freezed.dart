// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Year {
  int get id;
  int get year;
  String get title;
  @JsonKey(name: 'published_sections_count')
  int? get publishedSectionsCount;
  @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
  List<SectionSummary> get sections;

  /// Create a copy of Year
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YearCopyWith<Year> get copyWith =>
      _$YearCopyWithImpl<Year>(this as Year, _$identity);

  /// Serializes this Year to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Year &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.publishedSectionsCount, publishedSectionsCount) ||
                other.publishedSectionsCount == publishedSectionsCount) &&
            const DeepCollectionEquality().equals(other.sections, sections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, title,
      publishedSectionsCount, const DeepCollectionEquality().hash(sections));

  @override
  String toString() {
    return 'Year(id: $id, year: $year, title: $title, publishedSectionsCount: $publishedSectionsCount, sections: $sections)';
  }
}

/// @nodoc
abstract mixin class $YearCopyWith<$Res> {
  factory $YearCopyWith(Year value, $Res Function(Year) _then) =
      _$YearCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int year,
      String title,
      @JsonKey(name: 'published_sections_count') int? publishedSectionsCount,
      @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
      List<SectionSummary> sections});
}

/// @nodoc
class _$YearCopyWithImpl<$Res> implements $YearCopyWith<$Res> {
  _$YearCopyWithImpl(this._self, this._then);

  final Year _self;
  final $Res Function(Year) _then;

  /// Create a copy of Year
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? title = null,
    Object? publishedSectionsCount = freezed,
    Object? sections = null,
  }) {
    return _then(Year(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      publishedSectionsCount: freezed == publishedSectionsCount
          ? _self.publishedSectionsCount
          : publishedSectionsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      sections: null == sections
          ? _self.sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<SectionSummary>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Year].
extension YearPatterns on Year {
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
    TResult Function(_Year value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Year() when $default != null:
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
    TResult Function(_Year value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Year():
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
    TResult? Function(_Year value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Year() when $default != null:
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
            int year,
            String title,
            @JsonKey(name: 'published_sections_count')
            int? publishedSectionsCount,
            @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
            List<SectionSummary> sections)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Year() when $default != null:
        return $default(_that.id, _that.year, _that.title,
            _that.publishedSectionsCount, _that.sections);
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
            int year,
            String title,
            @JsonKey(name: 'published_sections_count')
            int? publishedSectionsCount,
            @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
            List<SectionSummary> sections)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Year():
        return $default(_that.id, _that.year, _that.title,
            _that.publishedSectionsCount, _that.sections);
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
            int year,
            String title,
            @JsonKey(name: 'published_sections_count')
            int? publishedSectionsCount,
            @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
            List<SectionSummary> sections)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Year() when $default != null:
        return $default(_that.id, _that.year, _that.title,
            _that.publishedSectionsCount, _that.sections);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Year implements Year {
  const _Year(
      {required this.id,
      required this.year,
      required this.title,
      @JsonKey(name: 'published_sections_count') this.publishedSectionsCount,
      @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
      required List<SectionSummary> sections})
      : _sections = sections;
  factory _Year.fromJson(Map<String, dynamic> json) => _$YearFromJson(json);

  @override
  final int id;
  @override
  final int year;
  @override
  final String title;
  @override
  @JsonKey(name: 'published_sections_count')
  final int? publishedSectionsCount;
  final List<SectionSummary> _sections;
  @override
  @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
  List<SectionSummary> get sections {
    if (_sections is EqualUnmodifiableListView) return _sections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sections);
  }

  /// Create a copy of Year
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YearCopyWith<_Year> get copyWith =>
      __$YearCopyWithImpl<_Year>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YearToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Year &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.publishedSectionsCount, publishedSectionsCount) ||
                other.publishedSectionsCount == publishedSectionsCount) &&
            const DeepCollectionEquality().equals(other._sections, _sections));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, title,
      publishedSectionsCount, const DeepCollectionEquality().hash(_sections));

  @override
  String toString() {
    return 'Year(id: $id, year: $year, title: $title, publishedSectionsCount: $publishedSectionsCount, sections: $sections)';
  }
}

/// @nodoc
abstract mixin class _$YearCopyWith<$Res> implements $YearCopyWith<$Res> {
  factory _$YearCopyWith(_Year value, $Res Function(_Year) _then) =
      __$YearCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int year,
      String title,
      @JsonKey(name: 'published_sections_count') int? publishedSectionsCount,
      @JsonKey(name: 'sections', defaultValue: <SectionSummary>[])
      List<SectionSummary> sections});
}

/// @nodoc
class __$YearCopyWithImpl<$Res> implements _$YearCopyWith<$Res> {
  __$YearCopyWithImpl(this._self, this._then);

  final _Year _self;
  final $Res Function(_Year) _then;

  /// Create a copy of Year
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? title = null,
    Object? publishedSectionsCount = freezed,
    Object? sections = null,
  }) {
    return _then(_Year(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      publishedSectionsCount: freezed == publishedSectionsCount
          ? _self.publishedSectionsCount
          : publishedSectionsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      sections: null == sections
          ? _self._sections
          : sections // ignore: cast_nullable_to_non_nullable
              as List<SectionSummary>,
    ));
  }
}

// dart format on
