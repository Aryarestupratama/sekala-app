// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizQuestion {
  int get id;
  int get order;
  String get question;
  List<EraQuizQuestionOption> get options;

  /// Create a copy of EraQuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizQuestionCopyWith<EraQuizQuestion> get copyWith =>
      _$EraQuizQuestionCopyWithImpl<EraQuizQuestion>(
          this as EraQuizQuestion, _$identity);

  /// Serializes this EraQuizQuestion to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizQuestion &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other.options, options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, order, question,
      const DeepCollectionEquality().hash(options));

  @override
  String toString() {
    return 'EraQuizQuestion(id: $id, order: $order, question: $question, options: $options)';
  }
}

/// @nodoc
abstract mixin class $EraQuizQuestionCopyWith<$Res> {
  factory $EraQuizQuestionCopyWith(
          EraQuizQuestion value, $Res Function(EraQuizQuestion) _then) =
      _$EraQuizQuestionCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      int order,
      String question,
      List<EraQuizQuestionOption> options});
}

/// @nodoc
class _$EraQuizQuestionCopyWithImpl<$Res>
    implements $EraQuizQuestionCopyWith<$Res> {
  _$EraQuizQuestionCopyWithImpl(this._self, this._then);

  final EraQuizQuestion _self;
  final $Res Function(EraQuizQuestion) _then;

  /// Create a copy of EraQuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? question = null,
    Object? options = null,
  }) {
    return _then(EraQuizQuestion(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<EraQuizQuestionOption>,
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizQuestion].
extension EraQuizQuestionPatterns on EraQuizQuestion {
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
    TResult Function(_EraQuizQuestion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestion() when $default != null:
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
    TResult Function(_EraQuizQuestion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestion():
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
    TResult? Function(_EraQuizQuestion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestion() when $default != null:
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
    TResult Function(int id, int order, String question,
            List<EraQuizQuestionOption> options)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestion() when $default != null:
        return $default(_that.id, _that.order, _that.question, _that.options);
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
    TResult Function(int id, int order, String question,
            List<EraQuizQuestionOption> options)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestion():
        return $default(_that.id, _that.order, _that.question, _that.options);
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
    TResult? Function(int id, int order, String question,
            List<EraQuizQuestionOption> options)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizQuestion() when $default != null:
        return $default(_that.id, _that.order, _that.question, _that.options);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizQuestion implements EraQuizQuestion {
  const _EraQuizQuestion(
      {required this.id,
      required this.order,
      required this.question,
      List<EraQuizQuestionOption> options = const <EraQuizQuestionOption>[]})
      : _options = options;
  factory _EraQuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$EraQuizQuestionFromJson(json);

  @override
  final int id;
  @override
  final int order;
  @override
  final String question;
  final List<EraQuizQuestionOption> _options;
  @override
  @JsonKey()
  List<EraQuizQuestionOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  /// Create a copy of EraQuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizQuestionCopyWith<_EraQuizQuestion> get copyWith =>
      __$EraQuizQuestionCopyWithImpl<_EraQuizQuestion>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizQuestionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizQuestion &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, order, question,
      const DeepCollectionEquality().hash(_options));

  @override
  String toString() {
    return 'EraQuizQuestion(id: $id, order: $order, question: $question, options: $options)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizQuestionCopyWith<$Res>
    implements $EraQuizQuestionCopyWith<$Res> {
  factory _$EraQuizQuestionCopyWith(
          _EraQuizQuestion value, $Res Function(_EraQuizQuestion) _then) =
      __$EraQuizQuestionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      int order,
      String question,
      List<EraQuizQuestionOption> options});
}

/// @nodoc
class __$EraQuizQuestionCopyWithImpl<$Res>
    implements _$EraQuizQuestionCopyWith<$Res> {
  __$EraQuizQuestionCopyWithImpl(this._self, this._then);

  final _EraQuizQuestion _self;
  final $Res Function(_EraQuizQuestion) _then;

  /// Create a copy of EraQuizQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? order = null,
    Object? question = null,
    Object? options = null,
  }) {
    return _then(_EraQuizQuestion(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _self.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<EraQuizQuestionOption>,
    ));
  }
}

// dart format on
