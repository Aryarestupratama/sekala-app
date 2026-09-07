// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_question_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizQuestionOption {
  int get id;
  @JsonKey(name: 'option_text')
  String get optionText;
  int get order;

  /// Create a copy of EraQuizQuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizQuestionOptionCopyWith<EraQuizQuestionOption> get copyWith =>
      _$EraQuizQuestionOptionCopyWithImpl<EraQuizQuestionOption>(
          this as EraQuizQuestionOption, _$identity);

  /// Serializes this EraQuizQuestionOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizQuestionOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.optionText, optionText) ||
                other.optionText == optionText) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, optionText, order);

  @override
  String toString() {
    return 'EraQuizQuestionOption(id: $id, optionText: $optionText, order: $order)';
  }
}

/// @nodoc
abstract mixin class $EraQuizQuestionOptionCopyWith<$Res> {
  factory $EraQuizQuestionOptionCopyWith(EraQuizQuestionOption value,
          $Res Function(EraQuizQuestionOption) _then) =
      _$EraQuizQuestionOptionCopyWithImpl;
  @useResult
  $Res call(
      {int id, @JsonKey(name: 'option_text') String optionText, int order});
}

/// @nodoc
class _$EraQuizQuestionOptionCopyWithImpl<$Res>
    implements $EraQuizQuestionOptionCopyWith<$Res> {
  _$EraQuizQuestionOptionCopyWithImpl(this._self, this._then);

  final EraQuizQuestionOption _self;
  final $Res Function(EraQuizQuestionOption) _then;

  /// Create a copy of EraQuizQuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? optionText = null,
    Object? order = null,
  }) {
    return _then(EraQuizQuestionOption(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      optionText: null == optionText
          ? _self.optionText
          : optionText // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizQuestionOption].
extension EraQuizQuestionOptionPatterns on EraQuizQuestionOption {
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
    TResult Function(_EraQuizQuestionOption value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestionOption() when $default != null:
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
    TResult Function(_EraQuizQuestionOption value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestionOption():
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
    TResult? Function(_EraQuizQuestionOption value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestionOption() when $default != null:
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
            int id, @JsonKey(name: 'option_text') String optionText, int order)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestionOption() when $default != null:
        return $default(_that.id, _that.optionText, _that.order);
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
            int id, @JsonKey(name: 'option_text') String optionText, int order)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestionOption():
        return $default(_that.id, _that.optionText, _that.order);
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
            int id, @JsonKey(name: 'option_text') String optionText, int order)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestionOption() when $default != null:
        return $default(_that.id, _that.optionText, _that.order);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizQuestionOption implements EraQuizQuestionOption {
  const _EraQuizQuestionOption(
      {required this.id,
      @JsonKey(name: 'option_text') required this.optionText,
      required this.order});
  factory _EraQuizQuestionOption.fromJson(Map<String, dynamic> json) =>
      _$EraQuizQuestionOptionFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'option_text')
  final String optionText;
  @override
  final int order;

  /// Create a copy of EraQuizQuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizQuestionOptionCopyWith<_EraQuizQuestionOption> get copyWith =>
      __$EraQuizQuestionOptionCopyWithImpl<_EraQuizQuestionOption>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizQuestionOptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizQuestionOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.optionText, optionText) ||
                other.optionText == optionText) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, optionText, order);

  @override
  String toString() {
    return 'EraQuizQuestionOption(id: $id, optionText: $optionText, order: $order)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizQuestionOptionCopyWith<$Res>
    implements $EraQuizQuestionOptionCopyWith<$Res> {
  factory _$EraQuizQuestionOptionCopyWith(_EraQuizQuestionOption value,
          $Res Function(_EraQuizQuestionOption) _then) =
      __$EraQuizQuestionOptionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id, @JsonKey(name: 'option_text') String optionText, int order});
}

/// @nodoc
class __$EraQuizQuestionOptionCopyWithImpl<$Res>
    implements _$EraQuizQuestionOptionCopyWith<$Res> {
  __$EraQuizQuestionOptionCopyWithImpl(this._self, this._then);

  final _EraQuizQuestionOption _self;
  final $Res Function(_EraQuizQuestionOption) _then;

  /// Create a copy of EraQuizQuestionOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? optionText = null,
    Object? order = null,
  }) {
    return _then(_EraQuizQuestionOption(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      optionText: null == optionText
          ? _self.optionText
          : optionText // ignore: cast_nullable_to_non_nullable
              as String,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
