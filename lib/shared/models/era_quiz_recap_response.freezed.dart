// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_recap_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizRecapResponse {
  @JsonKey(name: 'completed_at')
  String get completedAt;
  List<EraQuizRecapItem> get questions;

  /// Create a copy of EraQuizRecapResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizRecapResponseCopyWith<EraQuizRecapResponse> get copyWith =>
      _$EraQuizRecapResponseCopyWithImpl<EraQuizRecapResponse>(
          this as EraQuizRecapResponse, _$identity);

  /// Serializes this EraQuizRecapResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizRecapResponse &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other.questions, questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, completedAt, const DeepCollectionEquality().hash(questions));

  @override
  String toString() {
    return 'EraQuizRecapResponse(completedAt: $completedAt, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class $EraQuizRecapResponseCopyWith<$Res> {
  factory $EraQuizRecapResponseCopyWith(EraQuizRecapResponse value,
          $Res Function(EraQuizRecapResponse) _then) =
      _$EraQuizRecapResponseCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'completed_at') String completedAt,
      List<EraQuizRecapItem> questions});
}

/// @nodoc
class _$EraQuizRecapResponseCopyWithImpl<$Res>
    implements $EraQuizRecapResponseCopyWith<$Res> {
  _$EraQuizRecapResponseCopyWithImpl(this._self, this._then);

  final EraQuizRecapResponse _self;
  final $Res Function(EraQuizRecapResponse) _then;

  /// Create a copy of EraQuizRecapResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? completedAt = null,
    Object? questions = null,
  }) {
    return _then(EraQuizRecapResponse(
      completedAt: null == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _self.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<EraQuizRecapItem>,
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizRecapResponse].
extension EraQuizRecapResponsePatterns on EraQuizRecapResponse {
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
    TResult Function(_EraQuizRecapResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapResponse() when $default != null:
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
    TResult Function(_EraQuizRecapResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapResponse():
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
    TResult? Function(_EraQuizRecapResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapResponse() when $default != null:
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
    TResult Function(@JsonKey(name: 'completed_at') String completedAt,
            List<EraQuizRecapItem> questions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapResponse() when $default != null:
        return $default(_that.completedAt, _that.questions);
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
    TResult Function(@JsonKey(name: 'completed_at') String completedAt,
            List<EraQuizRecapItem> questions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapResponse():
        return $default(_that.completedAt, _that.questions);
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
    TResult? Function(@JsonKey(name: 'completed_at') String completedAt,
            List<EraQuizRecapItem> questions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapResponse() when $default != null:
        return $default(_that.completedAt, _that.questions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizRecapResponse implements EraQuizRecapResponse {
  const _EraQuizRecapResponse(
      {@JsonKey(name: 'completed_at') required this.completedAt,
      List<EraQuizRecapItem> questions = const <EraQuizRecapItem>[]})
      : _questions = questions;
  factory _EraQuizRecapResponse.fromJson(Map<String, dynamic> json) =>
      _$EraQuizRecapResponseFromJson(json);

  @override
  @JsonKey(name: 'completed_at')
  final String completedAt;
  final List<EraQuizRecapItem> _questions;
  @override
  @JsonKey()
  List<EraQuizRecapItem> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  /// Create a copy of EraQuizRecapResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizRecapResponseCopyWith<_EraQuizRecapResponse> get copyWith =>
      __$EraQuizRecapResponseCopyWithImpl<_EraQuizRecapResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizRecapResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizRecapResponse &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, completedAt,
      const DeepCollectionEquality().hash(_questions));

  @override
  String toString() {
    return 'EraQuizRecapResponse(completedAt: $completedAt, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizRecapResponseCopyWith<$Res>
    implements $EraQuizRecapResponseCopyWith<$Res> {
  factory _$EraQuizRecapResponseCopyWith(_EraQuizRecapResponse value,
          $Res Function(_EraQuizRecapResponse) _then) =
      __$EraQuizRecapResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'completed_at') String completedAt,
      List<EraQuizRecapItem> questions});
}

/// @nodoc
class __$EraQuizRecapResponseCopyWithImpl<$Res>
    implements _$EraQuizRecapResponseCopyWith<$Res> {
  __$EraQuizRecapResponseCopyWithImpl(this._self, this._then);

  final _EraQuizRecapResponse _self;
  final $Res Function(_EraQuizRecapResponse) _then;

  /// Create a copy of EraQuizRecapResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? completedAt = null,
    Object? questions = null,
  }) {
    return _then(_EraQuizRecapResponse(
      completedAt: null == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _self._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<EraQuizRecapItem>,
    ));
  }
}

// dart format on
