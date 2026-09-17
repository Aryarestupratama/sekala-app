// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz_start.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuizStart {
  @JsonKey(name: 'era_quiz_id')
  int get eraQuizId;
  @JsonKey(name: 'passing_grade')
  int get passingGrade;
  @JsonKey(name: 'question_count')
  int get questionCount;
  List<EraQuizQuestion> get questions;

  /// Create a copy of EraQuizStart
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizStartCopyWith<EraQuizStart> get copyWith =>
      _$EraQuizStartCopyWithImpl<EraQuizStart>(
          this as EraQuizStart, _$identity);

  /// Serializes this EraQuizStart to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuizStart &&
            (identical(other.eraQuizId, eraQuizId) ||
                other.eraQuizId == eraQuizId) &&
            (identical(other.passingGrade, passingGrade) ||
                other.passingGrade == passingGrade) &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount) &&
            const DeepCollectionEquality().equals(other.questions, questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, eraQuizId, passingGrade,
      questionCount, const DeepCollectionEquality().hash(questions));

  @override
  String toString() {
    return 'EraQuizStart(eraQuizId: $eraQuizId, passingGrade: $passingGrade, questionCount: $questionCount, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class $EraQuizStartCopyWith<$Res> {
  factory $EraQuizStartCopyWith(
          EraQuizStart value, $Res Function(EraQuizStart) _then) =
      _$EraQuizStartCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'era_quiz_id') int eraQuizId,
      @JsonKey(name: 'passing_grade') int passingGrade,
      @JsonKey(name: 'question_count') int questionCount,
      List<EraQuizQuestion> questions});
}

/// @nodoc
class _$EraQuizStartCopyWithImpl<$Res> implements $EraQuizStartCopyWith<$Res> {
  _$EraQuizStartCopyWithImpl(this._self, this._then);

  final EraQuizStart _self;
  final $Res Function(EraQuizStart) _then;

  /// Create a copy of EraQuizStart
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eraQuizId = null,
    Object? passingGrade = null,
    Object? questionCount = null,
    Object? questions = null,
  }) {
    return _then(EraQuizStart(
      eraQuizId: null == eraQuizId
          ? _self.eraQuizId
          : eraQuizId // ignore: cast_nullable_to_non_nullable
              as int,
      passingGrade: null == passingGrade
          ? _self.passingGrade
          : passingGrade // ignore: cast_nullable_to_non_nullable
              as int,
      questionCount: null == questionCount
          ? _self.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
      questions: null == questions
          ? _self.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<EraQuizQuestion>,
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuizStart].
extension EraQuizStartPatterns on EraQuizStart {
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
    TResult Function(_EraQuizStart value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizStart() when $default != null:
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
    TResult Function(_EraQuizStart value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizStart():
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
    TResult? Function(_EraQuizStart value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizStart() when $default != null:
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
            @JsonKey(name: 'era_quiz_id') int eraQuizId,
            @JsonKey(name: 'passing_grade') int passingGrade,
            @JsonKey(name: 'question_count') int questionCount,
            List<EraQuizQuestion> questions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuizStart() when $default != null:
        return $default(_that.eraQuizId, _that.passingGrade,
            _that.questionCount, _that.questions);
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
            @JsonKey(name: 'era_quiz_id') int eraQuizId,
            @JsonKey(name: 'passing_grade') int passingGrade,
            @JsonKey(name: 'question_count') int questionCount,
            List<EraQuizQuestion> questions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizStart():
        return $default(_that.eraQuizId, _that.passingGrade,
            _that.questionCount, _that.questions);
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
            @JsonKey(name: 'era_quiz_id') int eraQuizId,
            @JsonKey(name: 'passing_grade') int passingGrade,
            @JsonKey(name: 'question_count') int questionCount,
            List<EraQuizQuestion> questions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuizStart() when $default != null:
        return $default(_that.eraQuizId, _that.passingGrade,
            _that.questionCount, _that.questions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuizStart implements EraQuizStart {
  const _EraQuizStart(
      {@JsonKey(name: 'era_quiz_id') required this.eraQuizId,
      @JsonKey(name: 'passing_grade') required this.passingGrade,
      @JsonKey(name: 'question_count') required this.questionCount,
      List<EraQuizQuestion> questions = const <EraQuizQuestion>[]})
      : _questions = questions;
  factory _EraQuizStart.fromJson(Map<String, dynamic> json) =>
      _$EraQuizStartFromJson(json);

  @override
  @JsonKey(name: 'era_quiz_id')
  final int eraQuizId;
  @override
  @JsonKey(name: 'passing_grade')
  final int passingGrade;
  @override
  @JsonKey(name: 'question_count')
  final int questionCount;
  final List<EraQuizQuestion> _questions;
  @override
  @JsonKey()
  List<EraQuizQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  /// Create a copy of EraQuizStart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizStartCopyWith<_EraQuizStart> get copyWith =>
      __$EraQuizStartCopyWithImpl<_EraQuizStart>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizStartToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuizStart &&
            (identical(other.eraQuizId, eraQuizId) ||
                other.eraQuizId == eraQuizId) &&
            (identical(other.passingGrade, passingGrade) ||
                other.passingGrade == passingGrade) &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, eraQuizId, passingGrade,
      questionCount, const DeepCollectionEquality().hash(_questions));

  @override
  String toString() {
    return 'EraQuizStart(eraQuizId: $eraQuizId, passingGrade: $passingGrade, questionCount: $questionCount, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizStartCopyWith<$Res>
    implements $EraQuizStartCopyWith<$Res> {
  factory _$EraQuizStartCopyWith(
          _EraQuizStart value, $Res Function(_EraQuizStart) _then) =
      __$EraQuizStartCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'era_quiz_id') int eraQuizId,
      @JsonKey(name: 'passing_grade') int passingGrade,
      @JsonKey(name: 'question_count') int questionCount,
      List<EraQuizQuestion> questions});
}

/// @nodoc
class __$EraQuizStartCopyWithImpl<$Res>
    implements _$EraQuizStartCopyWith<$Res> {
  __$EraQuizStartCopyWithImpl(this._self, this._then);

  final _EraQuizStart _self;
  final $Res Function(_EraQuizStart) _then;

  /// Create a copy of EraQuizStart
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? eraQuizId = null,
    Object? passingGrade = null,
    Object? questionCount = null,
    Object? questions = null,
  }) {
    return _then(_EraQuizStart(
      eraQuizId: null == eraQuizId
          ? _self.eraQuizId
          : eraQuizId // ignore: cast_nullable_to_non_nullable
              as int,
      passingGrade: null == passingGrade
          ? _self.passingGrade
          : passingGrade // ignore: cast_nullable_to_non_nullable
              as int,
      questionCount: null == questionCount
          ? _self.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
      questions: null == questions
          ? _self._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<EraQuizQuestion>,
    ));
  }
}

// dart format on
