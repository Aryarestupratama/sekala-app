// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'case_study.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CaseStudy {
  int get id;
  String get title;
  String get description;
  @JsonKey(name: 'challenge_text')
  String get challengeText;

  /// Deskripsi di atas kolom alasan (Ruang Keputusan) — isi admin.
  @JsonKey(name: 'reason_description')
  String get reasonDescription;

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CaseStudyCopyWith<CaseStudy> get copyWith =>
      _$CaseStudyCopyWithImpl<CaseStudy>(this as CaseStudy, _$identity);

  /// Serializes this CaseStudy to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CaseStudy &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.challengeText, challengeText) ||
                other.challengeText == challengeText) &&
            (identical(other.reasonDescription, reasonDescription) ||
                other.reasonDescription == reasonDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, challengeText, reasonDescription);

  @override
  String toString() {
    return 'CaseStudy(id: $id, title: $title, description: $description, challengeText: $challengeText, reasonDescription: $reasonDescription)';
  }
}

/// @nodoc
abstract mixin class $CaseStudyCopyWith<$Res> {
  factory $CaseStudyCopyWith(CaseStudy value, $Res Function(CaseStudy) _then) =
      _$CaseStudyCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      @JsonKey(name: 'challenge_text') String challengeText,
      @JsonKey(name: 'reason_description') String reasonDescription});
}

/// @nodoc
class _$CaseStudyCopyWithImpl<$Res> implements $CaseStudyCopyWith<$Res> {
  _$CaseStudyCopyWithImpl(this._self, this._then);

  final CaseStudy _self;
  final $Res Function(CaseStudy) _then;

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? challengeText = null,
    Object? reasonDescription = null,
  }) {
    return _then(CaseStudy(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      challengeText: null == challengeText
          ? _self.challengeText
          : challengeText // ignore: cast_nullable_to_non_nullable
              as String,
      reasonDescription: null == reasonDescription
          ? _self.reasonDescription
          : reasonDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [CaseStudy].
extension CaseStudyPatterns on CaseStudy {
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
    TResult Function(_CaseStudy value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudy() when $default != null:
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
    TResult Function(_CaseStudy value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudy():
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
    TResult? Function(_CaseStudy value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudy() when $default != null:
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
            String description,
            @JsonKey(name: 'challenge_text') String challengeText,
            @JsonKey(name: 'reason_description') String reasonDescription)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudy() when $default != null:
        return $default(_that.id, _that.title, _that.description,
            _that.challengeText, _that.reasonDescription);
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
            String description,
            @JsonKey(name: 'challenge_text') String challengeText,
            @JsonKey(name: 'reason_description') String reasonDescription)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudy():
        return $default(_that.id, _that.title, _that.description,
            _that.challengeText, _that.reasonDescription);
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
            String description,
            @JsonKey(name: 'challenge_text') String challengeText,
            @JsonKey(name: 'reason_description') String reasonDescription)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudy() when $default != null:
        return $default(_that.id, _that.title, _that.description,
            _that.challengeText, _that.reasonDescription);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CaseStudy implements CaseStudy {
  const _CaseStudy(
      {required this.id,
      this.title = '',
      this.description = '',
      @JsonKey(name: 'challenge_text') this.challengeText = '',
      @JsonKey(name: 'reason_description') this.reasonDescription = ''});
  factory _CaseStudy.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: 'challenge_text')
  final String challengeText;

  /// Deskripsi di atas kolom alasan (Ruang Keputusan) — isi admin.
  @override
  @JsonKey(name: 'reason_description')
  final String reasonDescription;

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CaseStudyCopyWith<_CaseStudy> get copyWith =>
      __$CaseStudyCopyWithImpl<_CaseStudy>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CaseStudyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CaseStudy &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.challengeText, challengeText) ||
                other.challengeText == challengeText) &&
            (identical(other.reasonDescription, reasonDescription) ||
                other.reasonDescription == reasonDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, challengeText, reasonDescription);

  @override
  String toString() {
    return 'CaseStudy(id: $id, title: $title, description: $description, challengeText: $challengeText, reasonDescription: $reasonDescription)';
  }
}

/// @nodoc
abstract mixin class _$CaseStudyCopyWith<$Res>
    implements $CaseStudyCopyWith<$Res> {
  factory _$CaseStudyCopyWith(
          _CaseStudy value, $Res Function(_CaseStudy) _then) =
      __$CaseStudyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String description,
      @JsonKey(name: 'challenge_text') String challengeText,
      @JsonKey(name: 'reason_description') String reasonDescription});
}

/// @nodoc
class __$CaseStudyCopyWithImpl<$Res> implements _$CaseStudyCopyWith<$Res> {
  __$CaseStudyCopyWithImpl(this._self, this._then);

  final _CaseStudy _self;
  final $Res Function(_CaseStudy) _then;

  /// Create a copy of CaseStudy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? challengeText = null,
    Object? reasonDescription = null,
  }) {
    return _then(_CaseStudy(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      challengeText: null == challengeText
          ? _self.challengeText
          : challengeText // ignore: cast_nullable_to_non_nullable
              as String,
      reasonDescription: null == reasonDescription
          ? _self.reasonDescription
          : reasonDescription // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
