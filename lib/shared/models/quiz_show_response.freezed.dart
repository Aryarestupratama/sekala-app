// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_show_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizShowResponse {
  Quiz get quiz;
  @JsonKey(name: 'passing_grade')
  int get passingGrade;
  @JsonKey(name: 'question_count')
  int get questionCount;
  @JsonKey(name: 'attempt_status')
  String get attemptStatus;
  @JsonKey(name: 'latest_score')
  double? get latestScore;

  /// Create a copy of QuizShowResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuizShowResponseCopyWith<QuizShowResponse> get copyWith =>
      _$QuizShowResponseCopyWithImpl<QuizShowResponse>(
          this as QuizShowResponse, _$identity);

  /// Serializes this QuizShowResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuizShowResponse &&
            (identical(other.quiz, quiz) || other.quiz == quiz) &&
            (identical(other.passingGrade, passingGrade) ||
                other.passingGrade == passingGrade) &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount) &&
            (identical(other.attemptStatus, attemptStatus) ||
                other.attemptStatus == attemptStatus) &&
            (identical(other.latestScore, latestScore) ||
                other.latestScore == latestScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quiz, passingGrade,
      questionCount, attemptStatus, latestScore);

  @override
  String toString() {
    return 'QuizShowResponse(quiz: $quiz, passingGrade: $passingGrade, questionCount: $questionCount, attemptStatus: $attemptStatus, latestScore: $latestScore)';
  }
}

/// @nodoc
abstract mixin class $QuizShowResponseCopyWith<$Res> {
  factory $QuizShowResponseCopyWith(
          QuizShowResponse value, $Res Function(QuizShowResponse) _then) =
      _$QuizShowResponseCopyWithImpl;
  @useResult
  $Res call(
      {Quiz quiz,
      @JsonKey(name: 'passing_grade') int passingGrade,
      @JsonKey(name: 'question_count') int questionCount,
      @JsonKey(name: 'attempt_status') String attemptStatus,
      @JsonKey(name: 'latest_score') double? latestScore});

  $QuizCopyWith<$Res> get quiz;
}

/// @nodoc
class _$QuizShowResponseCopyWithImpl<$Res>
    implements $QuizShowResponseCopyWith<$Res> {
  _$QuizShowResponseCopyWithImpl(this._self, this._then);

  final QuizShowResponse _self;
  final $Res Function(QuizShowResponse) _then;

  /// Create a copy of QuizShowResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quiz = null,
    Object? passingGrade = null,
    Object? questionCount = null,
    Object? attemptStatus = null,
    Object? latestScore = freezed,
  }) {
    return _then(QuizShowResponse(
      quiz: null == quiz
          ? _self.quiz
          : quiz // ignore: cast_nullable_to_non_nullable
              as Quiz,
      passingGrade: null == passingGrade
          ? _self.passingGrade
          : passingGrade // ignore: cast_nullable_to_non_nullable
              as int,
      questionCount: null == questionCount
          ? _self.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
      attemptStatus: null == attemptStatus
          ? _self.attemptStatus
          : attemptStatus // ignore: cast_nullable_to_non_nullable
              as String,
      latestScore: freezed == latestScore
          ? _self.latestScore
          : latestScore // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of QuizShowResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuizCopyWith<$Res> get quiz {
    return $QuizCopyWith<$Res>(_self.quiz, (value) {
      return _then(_self.copyWith(quiz: value));
    });
  }
}

/// Adds pattern-matching-related methods to [QuizShowResponse].
extension QuizShowResponsePatterns on QuizShowResponse {
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
    TResult Function(_QuizShowResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizShowResponse() when $default != null:
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
    TResult Function(_QuizShowResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizShowResponse():
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
    TResult? Function(_QuizShowResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizShowResponse() when $default != null:
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
            Quiz quiz,
            @JsonKey(name: 'passing_grade') int passingGrade,
            @JsonKey(name: 'question_count') int questionCount,
            @JsonKey(name: 'attempt_status') String attemptStatus,
            @JsonKey(name: 'latest_score') double? latestScore)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizShowResponse() when $default != null:
        return $default(_that.quiz, _that.passingGrade, _that.questionCount,
            _that.attemptStatus, _that.latestScore);
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
            Quiz quiz,
            @JsonKey(name: 'passing_grade') int passingGrade,
            @JsonKey(name: 'question_count') int questionCount,
            @JsonKey(name: 'attempt_status') String attemptStatus,
            @JsonKey(name: 'latest_score') double? latestScore)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizShowResponse():
        return $default(_that.quiz, _that.passingGrade, _that.questionCount,
            _that.attemptStatus, _that.latestScore);
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
            Quiz quiz,
            @JsonKey(name: 'passing_grade') int passingGrade,
            @JsonKey(name: 'question_count') int questionCount,
            @JsonKey(name: 'attempt_status') String attemptStatus,
            @JsonKey(name: 'latest_score') double? latestScore)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizShowResponse() when $default != null:
        return $default(_that.quiz, _that.passingGrade, _that.questionCount,
            _that.attemptStatus, _that.latestScore);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _QuizShowResponse implements QuizShowResponse {
  const _QuizShowResponse(
      {required this.quiz,
      @JsonKey(name: 'passing_grade') required this.passingGrade,
      @JsonKey(name: 'question_count') required this.questionCount,
      @JsonKey(name: 'attempt_status') required this.attemptStatus,
      @JsonKey(name: 'latest_score') this.latestScore});
  factory _QuizShowResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizShowResponseFromJson(json);

  @override
  final Quiz quiz;
  @override
  @JsonKey(name: 'passing_grade')
  final int passingGrade;
  @override
  @JsonKey(name: 'question_count')
  final int questionCount;
  @override
  @JsonKey(name: 'attempt_status')
  final String attemptStatus;
  @override
  @JsonKey(name: 'latest_score')
  final double? latestScore;

  /// Create a copy of QuizShowResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuizShowResponseCopyWith<_QuizShowResponse> get copyWith =>
      __$QuizShowResponseCopyWithImpl<_QuizShowResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuizShowResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuizShowResponse &&
            (identical(other.quiz, quiz) || other.quiz == quiz) &&
            (identical(other.passingGrade, passingGrade) ||
                other.passingGrade == passingGrade) &&
            (identical(other.questionCount, questionCount) ||
                other.questionCount == questionCount) &&
            (identical(other.attemptStatus, attemptStatus) ||
                other.attemptStatus == attemptStatus) &&
            (identical(other.latestScore, latestScore) ||
                other.latestScore == latestScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, quiz, passingGrade,
      questionCount, attemptStatus, latestScore);

  @override
  String toString() {
    return 'QuizShowResponse(quiz: $quiz, passingGrade: $passingGrade, questionCount: $questionCount, attemptStatus: $attemptStatus, latestScore: $latestScore)';
  }
}

/// @nodoc
abstract mixin class _$QuizShowResponseCopyWith<$Res>
    implements $QuizShowResponseCopyWith<$Res> {
  factory _$QuizShowResponseCopyWith(
          _QuizShowResponse value, $Res Function(_QuizShowResponse) _then) =
      __$QuizShowResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Quiz quiz,
      @JsonKey(name: 'passing_grade') int passingGrade,
      @JsonKey(name: 'question_count') int questionCount,
      @JsonKey(name: 'attempt_status') String attemptStatus,
      @JsonKey(name: 'latest_score') double? latestScore});

  @override
  $QuizCopyWith<$Res> get quiz;
}

/// @nodoc
class __$QuizShowResponseCopyWithImpl<$Res>
    implements _$QuizShowResponseCopyWith<$Res> {
  __$QuizShowResponseCopyWithImpl(this._self, this._then);

  final _QuizShowResponse _self;
  final $Res Function(_QuizShowResponse) _then;

  /// Create a copy of QuizShowResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? quiz = null,
    Object? passingGrade = null,
    Object? questionCount = null,
    Object? attemptStatus = null,
    Object? latestScore = freezed,
  }) {
    return _then(_QuizShowResponse(
      quiz: null == quiz
          ? _self.quiz
          : quiz // ignore: cast_nullable_to_non_nullable
              as Quiz,
      passingGrade: null == passingGrade
          ? _self.passingGrade
          : passingGrade // ignore: cast_nullable_to_non_nullable
              as int,
      questionCount: null == questionCount
          ? _self.questionCount
          : questionCount // ignore: cast_nullable_to_non_nullable
              as int,
      attemptStatus: null == attemptStatus
          ? _self.attemptStatus
          : attemptStatus // ignore: cast_nullable_to_non_nullable
              as String,
      latestScore: freezed == latestScore
          ? _self.latestScore
          : latestScore // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  /// Create a copy of QuizShowResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuizCopyWith<$Res> get quiz {
    return $QuizCopyWith<$Res>(_self.quiz, (value) {
      return _then(_self.copyWith(quiz: value));
    });
  }
}

// dart format on
