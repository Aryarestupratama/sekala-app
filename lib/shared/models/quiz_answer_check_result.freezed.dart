// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_answer_check_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizAnswerCheckResult {
  @JsonKey(name: 'question_id')
  int get questionId;
  @JsonKey(name: 'selected_option_id')
  int get selectedOptionId;
  @JsonKey(name: 'correct_option_id')
  int? get correctOptionId;
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  String get explanation;
  @JsonKey(name: 'quiz_completed')
  bool get quizCompleted;
  @JsonKey(name: 'newly_unlocked_vaccine_ids')
  List<int> get newlyUnlockedVaccineIds;

  /// Create a copy of QuizAnswerCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuizAnswerCheckResultCopyWith<QuizAnswerCheckResult> get copyWith =>
      _$QuizAnswerCheckResultCopyWithImpl<QuizAnswerCheckResult>(
          this as QuizAnswerCheckResult, _$identity);

  /// Serializes this QuizAnswerCheckResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuizAnswerCheckResult &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedOptionId, selectedOptionId) ||
                other.selectedOptionId == selectedOptionId) &&
            (identical(other.correctOptionId, correctOptionId) ||
                other.correctOptionId == correctOptionId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.quizCompleted, quizCompleted) ||
                other.quizCompleted == quizCompleted) &&
            const DeepCollectionEquality().equals(
                other.newlyUnlockedVaccineIds, newlyUnlockedVaccineIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      selectedOptionId,
      correctOptionId,
      isCorrect,
      explanation,
      quizCompleted,
      const DeepCollectionEquality().hash(newlyUnlockedVaccineIds));

  @override
  String toString() {
    return 'QuizAnswerCheckResult(questionId: $questionId, selectedOptionId: $selectedOptionId, correctOptionId: $correctOptionId, isCorrect: $isCorrect, explanation: $explanation, quizCompleted: $quizCompleted, newlyUnlockedVaccineIds: $newlyUnlockedVaccineIds)';
  }
}

/// @nodoc
abstract mixin class $QuizAnswerCheckResultCopyWith<$Res> {
  factory $QuizAnswerCheckResultCopyWith(QuizAnswerCheckResult value,
          $Res Function(QuizAnswerCheckResult) _then) =
      _$QuizAnswerCheckResultCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      @JsonKey(name: 'selected_option_id') int selectedOptionId,
      @JsonKey(name: 'correct_option_id') int? correctOptionId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      String explanation,
      @JsonKey(name: 'quiz_completed') bool quizCompleted,
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds});
}

/// @nodoc
class _$QuizAnswerCheckResultCopyWithImpl<$Res>
    implements $QuizAnswerCheckResultCopyWith<$Res> {
  _$QuizAnswerCheckResultCopyWithImpl(this._self, this._then);

  final QuizAnswerCheckResult _self;
  final $Res Function(QuizAnswerCheckResult) _then;

  /// Create a copy of QuizAnswerCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedOptionId = null,
    Object? correctOptionId = freezed,
    Object? isCorrect = null,
    Object? explanation = null,
    Object? quizCompleted = null,
    Object? newlyUnlockedVaccineIds = null,
  }) {
    return _then(QuizAnswerCheckResult(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      selectedOptionId: null == selectedOptionId
          ? _self.selectedOptionId
          : selectedOptionId // ignore: cast_nullable_to_non_nullable
              as int,
      correctOptionId: freezed == correctOptionId
          ? _self.correctOptionId
          : correctOptionId // ignore: cast_nullable_to_non_nullable
              as int?,
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      explanation: null == explanation
          ? _self.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      quizCompleted: null == quizCompleted
          ? _self.quizCompleted
          : quizCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      newlyUnlockedVaccineIds: null == newlyUnlockedVaccineIds
          ? _self.newlyUnlockedVaccineIds
          : newlyUnlockedVaccineIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [QuizAnswerCheckResult].
extension QuizAnswerCheckResultPatterns on QuizAnswerCheckResult {
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
    TResult Function(_QuizAnswerCheckResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerCheckResult() when $default != null:
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
    TResult Function(_QuizAnswerCheckResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerCheckResult():
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
    TResult? Function(_QuizAnswerCheckResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerCheckResult() when $default != null:
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
            @JsonKey(name: 'selected_option_id') int selectedOptionId,
            @JsonKey(name: 'correct_option_id') int? correctOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation,
            @JsonKey(name: 'quiz_completed') bool quizCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerCheckResult() when $default != null:
        return $default(
            _that.questionId,
            _that.selectedOptionId,
            _that.correctOptionId,
            _that.isCorrect,
            _that.explanation,
            _that.quizCompleted,
            _that.newlyUnlockedVaccineIds);
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
            @JsonKey(name: 'selected_option_id') int selectedOptionId,
            @JsonKey(name: 'correct_option_id') int? correctOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation,
            @JsonKey(name: 'quiz_completed') bool quizCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerCheckResult():
        return $default(
            _that.questionId,
            _that.selectedOptionId,
            _that.correctOptionId,
            _that.isCorrect,
            _that.explanation,
            _that.quizCompleted,
            _that.newlyUnlockedVaccineIds);
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
            @JsonKey(name: 'selected_option_id') int selectedOptionId,
            @JsonKey(name: 'correct_option_id') int? correctOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation,
            @JsonKey(name: 'quiz_completed') bool quizCompleted,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizAnswerCheckResult() when $default != null:
        return $default(
            _that.questionId,
            _that.selectedOptionId,
            _that.correctOptionId,
            _that.isCorrect,
            _that.explanation,
            _that.quizCompleted,
            _that.newlyUnlockedVaccineIds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _QuizAnswerCheckResult implements QuizAnswerCheckResult {
  const _QuizAnswerCheckResult(
      {@JsonKey(name: 'question_id') required this.questionId,
      @JsonKey(name: 'selected_option_id') required this.selectedOptionId,
      @JsonKey(name: 'correct_option_id') this.correctOptionId,
      @JsonKey(name: 'is_correct') required this.isCorrect,
      required this.explanation,
      @JsonKey(name: 'quiz_completed') this.quizCompleted = false,
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds = const <int>[]})
      : _newlyUnlockedVaccineIds = newlyUnlockedVaccineIds;
  factory _QuizAnswerCheckResult.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerCheckResultFromJson(json);

  @override
  @JsonKey(name: 'question_id')
  final int questionId;
  @override
  @JsonKey(name: 'selected_option_id')
  final int selectedOptionId;
  @override
  @JsonKey(name: 'correct_option_id')
  final int? correctOptionId;
  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  @override
  final String explanation;
  @override
  @JsonKey(name: 'quiz_completed')
  final bool quizCompleted;
  final List<int> _newlyUnlockedVaccineIds;
  @override
  @JsonKey(name: 'newly_unlocked_vaccine_ids')
  List<int> get newlyUnlockedVaccineIds {
    if (_newlyUnlockedVaccineIds is EqualUnmodifiableListView)
      return _newlyUnlockedVaccineIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newlyUnlockedVaccineIds);
  }

  /// Create a copy of QuizAnswerCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuizAnswerCheckResultCopyWith<_QuizAnswerCheckResult> get copyWith =>
      __$QuizAnswerCheckResultCopyWithImpl<_QuizAnswerCheckResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuizAnswerCheckResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuizAnswerCheckResult &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedOptionId, selectedOptionId) ||
                other.selectedOptionId == selectedOptionId) &&
            (identical(other.correctOptionId, correctOptionId) ||
                other.correctOptionId == correctOptionId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.quizCompleted, quizCompleted) ||
                other.quizCompleted == quizCompleted) &&
            const DeepCollectionEquality().equals(
                other._newlyUnlockedVaccineIds, _newlyUnlockedVaccineIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      selectedOptionId,
      correctOptionId,
      isCorrect,
      explanation,
      quizCompleted,
      const DeepCollectionEquality().hash(_newlyUnlockedVaccineIds));

  @override
  String toString() {
    return 'QuizAnswerCheckResult(questionId: $questionId, selectedOptionId: $selectedOptionId, correctOptionId: $correctOptionId, isCorrect: $isCorrect, explanation: $explanation, quizCompleted: $quizCompleted, newlyUnlockedVaccineIds: $newlyUnlockedVaccineIds)';
  }
}

/// @nodoc
abstract mixin class _$QuizAnswerCheckResultCopyWith<$Res>
    implements $QuizAnswerCheckResultCopyWith<$Res> {
  factory _$QuizAnswerCheckResultCopyWith(_QuizAnswerCheckResult value,
          $Res Function(_QuizAnswerCheckResult) _then) =
      __$QuizAnswerCheckResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      @JsonKey(name: 'selected_option_id') int selectedOptionId,
      @JsonKey(name: 'correct_option_id') int? correctOptionId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      String explanation,
      @JsonKey(name: 'quiz_completed') bool quizCompleted,
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds});
}

/// @nodoc
class __$QuizAnswerCheckResultCopyWithImpl<$Res>
    implements _$QuizAnswerCheckResultCopyWith<$Res> {
  __$QuizAnswerCheckResultCopyWithImpl(this._self, this._then);

  final _QuizAnswerCheckResult _self;
  final $Res Function(_QuizAnswerCheckResult) _then;

  /// Create a copy of QuizAnswerCheckResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? questionId = null,
    Object? selectedOptionId = null,
    Object? correctOptionId = freezed,
    Object? isCorrect = null,
    Object? explanation = null,
    Object? quizCompleted = null,
    Object? newlyUnlockedVaccineIds = null,
  }) {
    return _then(_QuizAnswerCheckResult(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      selectedOptionId: null == selectedOptionId
          ? _self.selectedOptionId
          : selectedOptionId // ignore: cast_nullable_to_non_nullable
              as int,
      correctOptionId: freezed == correctOptionId
          ? _self.correctOptionId
          : correctOptionId // ignore: cast_nullable_to_non_nullable
              as int?,
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      explanation: null == explanation
          ? _self.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      quizCompleted: null == quizCompleted
          ? _self.quizCompleted
          : quizCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      newlyUnlockedVaccineIds: null == newlyUnlockedVaccineIds
          ? _self._newlyUnlockedVaccineIds
          : newlyUnlockedVaccineIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

// dart format on
