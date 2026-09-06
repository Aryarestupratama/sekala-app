// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_answer_feedback.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizAnswerFeedback {
  @JsonKey(name: 'question_id')
  int get questionId;
  @JsonKey(name: 'selected_option_id')
  int? get selectedOptionId;
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  String get explanation;

  /// Create a copy of QuizAnswerFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuizAnswerFeedbackCopyWith<QuizAnswerFeedback> get copyWith =>
      _$QuizAnswerFeedbackCopyWithImpl<QuizAnswerFeedback>(
          this as QuizAnswerFeedback, _$identity);

  /// Serializes this QuizAnswerFeedback to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuizAnswerFeedback &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedOptionId, selectedOptionId) ||
                other.selectedOptionId == selectedOptionId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, questionId, selectedOptionId, isCorrect, explanation);

  @override
  String toString() {
    return 'QuizAnswerFeedback(questionId: $questionId, selectedOptionId: $selectedOptionId, isCorrect: $isCorrect, explanation: $explanation)';
  }
}

/// @nodoc
abstract mixin class $QuizAnswerFeedbackCopyWith<$Res> {
  factory $QuizAnswerFeedbackCopyWith(
          QuizAnswerFeedback value, $Res Function(QuizAnswerFeedback) _then) =
      _$QuizAnswerFeedbackCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      @JsonKey(name: 'selected_option_id') int? selectedOptionId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      String explanation});
}

/// @nodoc
class _$QuizAnswerFeedbackCopyWithImpl<$Res>
    implements $QuizAnswerFeedbackCopyWith<$Res> {
  _$QuizAnswerFeedbackCopyWithImpl(this._self, this._then);

  final QuizAnswerFeedback _self;
  final $Res Function(QuizAnswerFeedback) _then;

  /// Create a copy of QuizAnswerFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedOptionId = freezed,
    Object? isCorrect = null,
    Object? explanation = null,
  }) {
    return _then(QuizAnswerFeedback(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      selectedOptionId: freezed == selectedOptionId
          ? _self.selectedOptionId
          : selectedOptionId // ignore: cast_nullable_to_non_nullable
              as int?,
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      explanation: null == explanation
          ? _self.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [QuizAnswerFeedback].
extension QuizAnswerFeedbackPatterns on QuizAnswerFeedback {
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
    TResult Function(_QuizAnswerFeedback value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerFeedback() when $default != null:
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
    TResult Function(_QuizAnswerFeedback value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerFeedback():
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
    TResult? Function(_QuizAnswerFeedback value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerFeedback() when $default != null:
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
            @JsonKey(name: 'question_id') int questionId,
            @JsonKey(name: 'selected_option_id') int? selectedOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerFeedback() when $default != null:
        return $default(_that.questionId, _that.selectedOptionId,
            _that.isCorrect, _that.explanation);
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
            @JsonKey(name: 'question_id') int questionId,
            @JsonKey(name: 'selected_option_id') int? selectedOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerFeedback():
        return $default(_that.questionId, _that.selectedOptionId,
            _that.isCorrect, _that.explanation);
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
            @JsonKey(name: 'question_id') int questionId,
            @JsonKey(name: 'selected_option_id') int? selectedOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerFeedback() when $default != null:
        return $default(_that.questionId, _that.selectedOptionId,
            _that.isCorrect, _that.explanation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _QuizAnswerFeedback implements QuizAnswerFeedback {
  const _QuizAnswerFeedback(
      {@JsonKey(name: 'question_id') required this.questionId,
      @JsonKey(name: 'selected_option_id') this.selectedOptionId,
      @JsonKey(name: 'is_correct') required this.isCorrect,
      required this.explanation});
  factory _QuizAnswerFeedback.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerFeedbackFromJson(json);

  @override
  @JsonKey(name: 'question_id')
  final int questionId;
  @override
  @JsonKey(name: 'selected_option_id')
  final int? selectedOptionId;
  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  @override
  final String explanation;

  /// Create a copy of QuizAnswerFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuizAnswerFeedbackCopyWith<_QuizAnswerFeedback> get copyWith =>
      __$QuizAnswerFeedbackCopyWithImpl<_QuizAnswerFeedback>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuizAnswerFeedbackToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuizAnswerFeedback &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedOptionId, selectedOptionId) ||
                other.selectedOptionId == selectedOptionId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, questionId, selectedOptionId, isCorrect, explanation);

  @override
  String toString() {
    return 'QuizAnswerFeedback(questionId: $questionId, selectedOptionId: $selectedOptionId, isCorrect: $isCorrect, explanation: $explanation)';
  }
}

/// @nodoc
abstract mixin class _$QuizAnswerFeedbackCopyWith<$Res>
    implements $QuizAnswerFeedbackCopyWith<$Res> {
  factory _$QuizAnswerFeedbackCopyWith(
          _QuizAnswerFeedback value, $Res Function(_QuizAnswerFeedback) _then) =
      __$QuizAnswerFeedbackCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      @JsonKey(name: 'selected_option_id') int? selectedOptionId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      String explanation});
}

/// @nodoc
class __$QuizAnswerFeedbackCopyWithImpl<$Res>
    implements _$QuizAnswerFeedbackCopyWith<$Res> {
  __$QuizAnswerFeedbackCopyWithImpl(this._self, this._then);

  final _QuizAnswerFeedback _self;
  final $Res Function(_QuizAnswerFeedback) _then;

  /// Create a copy of QuizAnswerFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? questionId = null,
    Object? selectedOptionId = freezed,
    Object? isCorrect = null,
    Object? explanation = null,
  }) {
    return _then(_QuizAnswerFeedback(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      selectedOptionId: freezed == selectedOptionId
          ? _self.selectedOptionId
          : selectedOptionId // ignore: cast_nullable_to_non_nullable
              as int?,
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      explanation: null == explanation
          ? _self.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
