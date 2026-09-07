// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_recap_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizRecapOption {
  int get id;
  @JsonKey(name: 'option_text')
  String get optionText;

  /// Create a copy of EraQuizRecapOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizRecapOptionCopyWith<EraQuizRecapOption> get copyWith =>
      _$EraQuizRecapOptionCopyWithImpl<EraQuizRecapOption>(
          this as EraQuizRecapOption, _$identity);

  /// Serializes this EraQuizRecapOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizRecapOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.optionText, optionText) ||
                other.optionText == optionText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, optionText);

  @override
  String toString() {
    return 'EraQuizRecapOption(id: $id, optionText: $optionText)';
  }
}

/// @nodoc
abstract mixin class $EraQuizRecapOptionCopyWith<$Res> {
  factory $EraQuizRecapOptionCopyWith(
          EraQuizRecapOption value, $Res Function(EraQuizRecapOption) _then) =
      _$EraQuizRecapOptionCopyWithImpl;
  @useResult
  $Res call({int id, @JsonKey(name: 'option_text') String optionText});
}

/// @nodoc
class _$EraQuizRecapOptionCopyWithImpl<$Res>
    implements $EraQuizRecapOptionCopyWith<$Res> {
  _$EraQuizRecapOptionCopyWithImpl(this._self, this._then);

  final EraQuizRecapOption _self;
  final $Res Function(EraQuizRecapOption) _then;

  /// Create a copy of EraQuizRecapOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? optionText = null,
  }) {
    return _then(EraQuizRecapOption(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      optionText: null == optionText
          ? _self.optionText
          : optionText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizRecapOption].
extension EraQuizRecapOptionPatterns on EraQuizRecapOption {
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
    TResult Function(_EraQuizRecapOption value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapOption() when $default != null:
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
    TResult Function(_EraQuizRecapOption value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapOption():
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
    TResult? Function(_EraQuizRecapOption value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapOption() when $default != null:
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
    TResult Function(int id, @JsonKey(name: 'option_text') String optionText)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapOption() when $default != null:
        return $default(_that.id, _that.optionText);
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
    TResult Function(int id, @JsonKey(name: 'option_text') String optionText)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapOption():
        return $default(_that.id, _that.optionText);
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
    TResult? Function(int id, @JsonKey(name: 'option_text') String optionText)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapOption() when $default != null:
        return $default(_that.id, _that.optionText);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizRecapOption implements EraQuizRecapOption {
  const _EraQuizRecapOption(
      {required this.id,
      @JsonKey(name: 'option_text') required this.optionText});
  factory _EraQuizRecapOption.fromJson(Map<String, dynamic> json) =>
      _$EraQuizRecapOptionFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'option_text')
  final String optionText;

  /// Create a copy of EraQuizRecapOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizRecapOptionCopyWith<_EraQuizRecapOption> get copyWith =>
      __$EraQuizRecapOptionCopyWithImpl<_EraQuizRecapOption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizRecapOptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizRecapOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.optionText, optionText) ||
                other.optionText == optionText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, optionText);

  @override
  String toString() {
    return 'EraQuizRecapOption(id: $id, optionText: $optionText)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizRecapOptionCopyWith<$Res>
    implements $EraQuizRecapOptionCopyWith<$Res> {
  factory _$EraQuizRecapOptionCopyWith(
          _EraQuizRecapOption value, $Res Function(_EraQuizRecapOption) _then) =
      __$EraQuizRecapOptionCopyWithImpl;
  @override
  @useResult
  $Res call({int id, @JsonKey(name: 'option_text') String optionText});
}

/// @nodoc
class __$EraQuizRecapOptionCopyWithImpl<$Res>
    implements _$EraQuizRecapOptionCopyWith<$Res> {
  __$EraQuizRecapOptionCopyWithImpl(this._self, this._then);

  final _EraQuizRecapOption _self;
  final $Res Function(_EraQuizRecapOption) _then;

  /// Create a copy of EraQuizRecapOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? optionText = null,
  }) {
    return _then(_EraQuizRecapOption(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      optionText: null == optionText
          ? _self.optionText
          : optionText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
