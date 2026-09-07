// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_recap_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizRecapItem {
  @JsonKey(name: 'question_id')
  int get questionId;
  String get question;
  List<EraQuizRecapOption> get options;
  @JsonKey(name: 'selected_option_id')
  int? get selectedOptionId;
  @JsonKey(name: 'correct_option_id')
  int? get correctOptionId;
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  String get explanation;

  /// Create a copy of EraQuizRecapItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizRecapItemCopyWith<EraQuizRecapItem> get copyWith =>
      _$EraQuizRecapItemCopyWithImpl<EraQuizRecapItem>(
          this as EraQuizRecapItem, _$identity);

  /// Serializes this EraQuizRecapItem to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizRecapItem &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other.options, options) &&
            (identical(other.selectedOptionId, selectedOptionId) ||
                other.selectedOptionId == selectedOptionId) &&
            (identical(other.correctOptionId, correctOptionId) ||
                other.correctOptionId == correctOptionId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      question,
      const DeepCollectionEquality().hash(options),
      selectedOptionId,
      correctOptionId,
      isCorrect,
      explanation);

  @override
  String toString() {
    return 'EraQuizRecapItem(questionId: $questionId, question: $question, options: $options, selectedOptionId: $selectedOptionId, correctOptionId: $correctOptionId, isCorrect: $isCorrect, explanation: $explanation)';
  }
}

/// @nodoc
abstract mixin class $EraQuizRecapItemCopyWith<$Res> {
  factory $EraQuizRecapItemCopyWith(
          EraQuizRecapItem value, $Res Function(EraQuizRecapItem) _then) =
      _$EraQuizRecapItemCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      String question,
      List<EraQuizRecapOption> options,
      @JsonKey(name: 'selected_option_id') int? selectedOptionId,
      @JsonKey(name: 'correct_option_id') int? correctOptionId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      String explanation});
}

/// @nodoc
class _$EraQuizRecapItemCopyWithImpl<$Res>
    implements $EraQuizRecapItemCopyWith<$Res> {
  _$EraQuizRecapItemCopyWithImpl(this._self, this._then);

  final EraQuizRecapItem _self;
  final $Res Function(EraQuizRecapItem) _then;

  /// Create a copy of EraQuizRecapItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? question = null,
    Object? options = null,
    Object? selectedOptionId = freezed,
    Object? correctOptionId = freezed,
    Object? isCorrect = null,
    Object? explanation = null,
  }) {
    return _then(EraQuizRecapItem(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<EraQuizRecapOption>,
      selectedOptionId: freezed == selectedOptionId
          ? _self.selectedOptionId
          : selectedOptionId // ignore: cast_nullable_to_non_nullable
              as int?,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizRecapItem].
extension EraQuizRecapItemPatterns on EraQuizRecapItem {
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
    TResult Function(_EraQuizRecapItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapItem() when $default != null:
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
    TResult Function(_EraQuizRecapItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapItem():
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
    TResult? Function(_EraQuizRecapItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapItem() when $default != null:
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
            String question,
            List<EraQuizRecapOption> options,
            @JsonKey(name: 'selected_option_id') int? selectedOptionId,
            @JsonKey(name: 'correct_option_id') int? correctOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapItem() when $default != null:
        return $default(
            _that.questionId,
            _that.question,
            _that.options,
            _that.selectedOptionId,
            _that.correctOptionId,
            _that.isCorrect,
            _that.explanation);
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
            String question,
            List<EraQuizRecapOption> options,
            @JsonKey(name: 'selected_option_id') int? selectedOptionId,
            @JsonKey(name: 'correct_option_id') int? correctOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapItem():
        return $default(
            _that.questionId,
            _that.question,
            _that.options,
            _that.selectedOptionId,
            _that.correctOptionId,
            _that.isCorrect,
            _that.explanation);
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
            String question,
            List<EraQuizRecapOption> options,
            @JsonKey(name: 'selected_option_id') int? selectedOptionId,
            @JsonKey(name: 'correct_option_id') int? correctOptionId,
            @JsonKey(name: 'is_correct') bool isCorrect,
            String explanation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizRecapItem() when $default != null:
        return $default(
            _that.questionId,
            _that.question,
            _that.options,
            _that.selectedOptionId,
            _that.correctOptionId,
            _that.isCorrect,
            _that.explanation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizRecapItem implements EraQuizRecapItem {
  const _EraQuizRecapItem(
      {@JsonKey(name: 'question_id') required this.questionId,
      required this.question,
      List<EraQuizRecapOption> options = const <EraQuizRecapOption>[],
      @JsonKey(name: 'selected_option_id') this.selectedOptionId,
      @JsonKey(name: 'correct_option_id') this.correctOptionId,
      @JsonKey(name: 'is_correct') required this.isCorrect,
      required this.explanation})
      : _options = options;
  factory _EraQuizRecapItem.fromJson(Map<String, dynamic> json) =>
      _$EraQuizRecapItemFromJson(json);

  @override
  @JsonKey(name: 'question_id')
  final int questionId;
  @override
  final String question;
  final List<EraQuizRecapOption> _options;
  @override
  @JsonKey()
  List<EraQuizRecapOption> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  @JsonKey(name: 'selected_option_id')
  final int? selectedOptionId;
  @override
  @JsonKey(name: 'correct_option_id')
  final int? correctOptionId;
  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  @override
  final String explanation;

  /// Create a copy of EraQuizRecapItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizRecapItemCopyWith<_EraQuizRecapItem> get copyWith =>
      __$EraQuizRecapItemCopyWithImpl<_EraQuizRecapItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizRecapItemToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizRecapItem &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.selectedOptionId, selectedOptionId) ||
                other.selectedOptionId == selectedOptionId) &&
            (identical(other.correctOptionId, correctOptionId) ||
                other.correctOptionId == correctOptionId) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      questionId,
      question,
      const DeepCollectionEquality().hash(_options),
      selectedOptionId,
      correctOptionId,
      isCorrect,
      explanation);

  @override
  String toString() {
    return 'EraQuizRecapItem(questionId: $questionId, question: $question, options: $options, selectedOptionId: $selectedOptionId, correctOptionId: $correctOptionId, isCorrect: $isCorrect, explanation: $explanation)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizRecapItemCopyWith<$Res>
    implements $EraQuizRecapItemCopyWith<$Res> {
  factory _$EraQuizRecapItemCopyWith(
          _EraQuizRecapItem value, $Res Function(_EraQuizRecapItem) _then) =
      __$EraQuizRecapItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'question_id') int questionId,
      String question,
      List<EraQuizRecapOption> options,
      @JsonKey(name: 'selected_option_id') int? selectedOptionId,
      @JsonKey(name: 'correct_option_id') int? correctOptionId,
      @JsonKey(name: 'is_correct') bool isCorrect,
      String explanation});
}

/// @nodoc
class __$EraQuizRecapItemCopyWithImpl<$Res>
    implements _$EraQuizRecapItemCopyWith<$Res> {
  __$EraQuizRecapItemCopyWithImpl(this._self, this._then);

  final _EraQuizRecapItem _self;
  final $Res Function(_EraQuizRecapItem) _then;

  /// Create a copy of EraQuizRecapItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? questionId = null,
    Object? question = null,
    Object? options = null,
    Object? selectedOptionId = freezed,
    Object? correctOptionId = freezed,
    Object? isCorrect = null,
    Object? explanation = null,
  }) {
    return _then(_EraQuizRecapItem(
      questionId: null == questionId
          ? _self.questionId
          : questionId // ignore: cast_nullable_to_non_nullable
              as int,
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<EraQuizRecapOption>,
      selectedOptionId: freezed == selectedOptionId
          ? _self.selectedOptionId
          : selectedOptionId // ignore: cast_nullable_to_non_nullable
              as int?,
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
    ));
  }
}

// dart format on
