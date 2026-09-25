// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'case_study_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CaseStudyOption {
  int get id;
  String get title;
  String get description;

  /// Create a copy of CaseStudyOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CaseStudyOptionCopyWith<CaseStudyOption> get copyWith =>
      _$CaseStudyOptionCopyWithImpl<CaseStudyOption>(
          this as CaseStudyOption, _$identity);

  /// Serializes this CaseStudyOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CaseStudyOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  @override
  String toString() {
    return 'CaseStudyOption(id: $id, title: $title, description: $description)';
  }
}

/// @nodoc
abstract mixin class $CaseStudyOptionCopyWith<$Res> {
  factory $CaseStudyOptionCopyWith(
          CaseStudyOption value, $Res Function(CaseStudyOption) _then) =
      _$CaseStudyOptionCopyWithImpl;
  @useResult
  $Res call({int id, String title, String description});
}

/// @nodoc
class _$CaseStudyOptionCopyWithImpl<$Res>
    implements $CaseStudyOptionCopyWith<$Res> {
  _$CaseStudyOptionCopyWithImpl(this._self, this._then);

  final CaseStudyOption _self;
  final $Res Function(CaseStudyOption) _then;

  /// Create a copy of CaseStudyOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(CaseStudyOption(
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
    ));
  }
}

/// Adds pattern-matching-related methods to [CaseStudyOption].
extension CaseStudyOptionPatterns on CaseStudyOption {
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
    TResult Function(_CaseStudyOption value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudyOption() when $default != null:
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
    TResult Function(_CaseStudyOption value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyOption():
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
    TResult? Function(_CaseStudyOption value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyOption() when $default != null:
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
    TResult Function(int id, String title, String description)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CaseStudyOption() when $default != null:
        return $default(_that.id, _that.title, _that.description);
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
    TResult Function(int id, String title, String description) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyOption():
        return $default(_that.id, _that.title, _that.description);
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
    TResult? Function(int id, String title, String description)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CaseStudyOption() when $default != null:
        return $default(_that.id, _that.title, _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CaseStudyOption implements CaseStudyOption {
  const _CaseStudyOption(
      {required this.id, this.title = '', this.description = ''});
  factory _CaseStudyOption.fromJson(Map<String, dynamic> json) =>
      _$CaseStudyOptionFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;

  /// Create a copy of CaseStudyOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CaseStudyOptionCopyWith<_CaseStudyOption> get copyWith =>
      __$CaseStudyOptionCopyWithImpl<_CaseStudyOption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CaseStudyOptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CaseStudyOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  @override
  String toString() {
    return 'CaseStudyOption(id: $id, title: $title, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$CaseStudyOptionCopyWith<$Res>
    implements $CaseStudyOptionCopyWith<$Res> {
  factory _$CaseStudyOptionCopyWith(
          _CaseStudyOption value, $Res Function(_CaseStudyOption) _then) =
      __$CaseStudyOptionCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String title, String description});
}

/// @nodoc
class __$CaseStudyOptionCopyWithImpl<$Res>
    implements _$CaseStudyOptionCopyWith<$Res> {
  __$CaseStudyOptionCopyWithImpl(this._self, this._then);

  final _CaseStudyOption _self;
  final $Res Function(_CaseStudyOption) _then;

  /// Create a copy of CaseStudyOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_CaseStudyOption(
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
    ));
  }
}

// dart format on
