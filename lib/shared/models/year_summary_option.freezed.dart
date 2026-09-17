// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'year_summary_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$YearSummaryOption {
  int get id;
  @JsonKey(name: 'option_text')
  String get optionText;

  /// Create a copy of YearSummaryOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $YearSummaryOptionCopyWith<YearSummaryOption> get copyWith =>
      _$YearSummaryOptionCopyWithImpl<YearSummaryOption>(
          this as YearSummaryOption, _$identity);

  /// Serializes this YearSummaryOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is YearSummaryOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.optionText, optionText) ||
                other.optionText == optionText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, optionText);

  @override
  String toString() {
    return 'YearSummaryOption(id: $id, optionText: $optionText)';
  }
}

/// @nodoc
abstract mixin class $YearSummaryOptionCopyWith<$Res> {
  factory $YearSummaryOptionCopyWith(
          YearSummaryOption value, $Res Function(YearSummaryOption) _then) =
      _$YearSummaryOptionCopyWithImpl;
  @useResult
  $Res call({int id, @JsonKey(name: 'option_text') String optionText});
}

/// @nodoc
class _$YearSummaryOptionCopyWithImpl<$Res>
    implements $YearSummaryOptionCopyWith<$Res> {
  _$YearSummaryOptionCopyWithImpl(this._self, this._then);

  final YearSummaryOption _self;
  final $Res Function(YearSummaryOption) _then;

  /// Create a copy of YearSummaryOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? optionText = null,
  }) {
    return _then(YearSummaryOption(
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

/// Adds pattern-matching-related methods to [YearSummaryOption].
extension YearSummaryOptionPatterns on YearSummaryOption {
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
    TResult Function(_YearSummaryOption value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _YearSummaryOption() when $default != null:
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
    TResult Function(_YearSummaryOption value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryOption():
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
    TResult? Function(_YearSummaryOption value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _YearSummaryOption() when $default != null:
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
      case _YearSummaryOption() when $default != null:
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
      case _YearSummaryOption():
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
      case _YearSummaryOption() when $default != null:
        return $default(_that.id, _that.optionText);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _YearSummaryOption implements YearSummaryOption {
  const _YearSummaryOption(
      {required this.id,
      @JsonKey(name: 'option_text') required this.optionText});
  factory _YearSummaryOption.fromJson(Map<String, dynamic> json) =>
      _$YearSummaryOptionFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'option_text')
  final String optionText;

  /// Create a copy of YearSummaryOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$YearSummaryOptionCopyWith<_YearSummaryOption> get copyWith =>
      __$YearSummaryOptionCopyWithImpl<_YearSummaryOption>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$YearSummaryOptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _YearSummaryOption &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.optionText, optionText) ||
                other.optionText == optionText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, optionText);

  @override
  String toString() {
    return 'YearSummaryOption(id: $id, optionText: $optionText)';
  }
}

/// @nodoc
abstract mixin class _$YearSummaryOptionCopyWith<$Res>
    implements $YearSummaryOptionCopyWith<$Res> {
  factory _$YearSummaryOptionCopyWith(
          _YearSummaryOption value, $Res Function(_YearSummaryOption) _then) =
      __$YearSummaryOptionCopyWithImpl;
  @override
  @useResult
  $Res call({int id, @JsonKey(name: 'option_text') String optionText});
}

/// @nodoc
class __$YearSummaryOptionCopyWithImpl<$Res>
    implements _$YearSummaryOptionCopyWith<$Res> {
  __$YearSummaryOptionCopyWithImpl(this._self, this._then);

  final _YearSummaryOption _self;
  final $Res Function(_YearSummaryOption) _then;

  /// Create a copy of YearSummaryOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? optionText = null,
  }) {
    return _then(_YearSummaryOption(
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
