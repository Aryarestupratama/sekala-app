// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_submit_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizSubmitResponse {
  String get message;
  @JsonKey(name: 'completed_at')
  String get completedAt;
  @JsonKey(name: 'feedback')
  List<QuizAnswerFeedback> get feedback;
  @JsonKey(name: 'newly_unlocked_vaccine_ids')
  List<int> get newlyUnlockedVaccineIds;

  /// Create a copy of QuizSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuizSubmitResponseCopyWith<QuizSubmitResponse> get copyWith =>
      _$QuizSubmitResponseCopyWithImpl<QuizSubmitResponse>(
          this as QuizSubmitResponse, _$identity);

  /// Serializes this QuizSubmitResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuizSubmitResponse &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other.feedback, feedback) &&
            const DeepCollectionEquality().equals(
                other.newlyUnlockedVaccineIds, newlyUnlockedVaccineIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      completedAt,
      const DeepCollectionEquality().hash(feedback),
      const DeepCollectionEquality().hash(newlyUnlockedVaccineIds));

  @override
  String toString() {
    return 'QuizSubmitResponse(message: $message, completedAt: $completedAt, feedback: $feedback, newlyUnlockedVaccineIds: $newlyUnlockedVaccineIds)';
  }
}

/// @nodoc
abstract mixin class $QuizSubmitResponseCopyWith<$Res> {
  factory $QuizSubmitResponseCopyWith(
          QuizSubmitResponse value, $Res Function(QuizSubmitResponse) _then) =
      _$QuizSubmitResponseCopyWithImpl;
  @useResult
  $Res call(
      {String message,
      @JsonKey(name: 'completed_at') String completedAt,
      @JsonKey(name: 'feedback') List<QuizAnswerFeedback> feedback,
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds});
}

/// @nodoc
class _$QuizSubmitResponseCopyWithImpl<$Res>
    implements $QuizSubmitResponseCopyWith<$Res> {
  _$QuizSubmitResponseCopyWithImpl(this._self, this._then);

  final QuizSubmitResponse _self;
  final $Res Function(QuizSubmitResponse) _then;

  /// Create a copy of QuizSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? completedAt = null,
    Object? feedback = null,
    Object? newlyUnlockedVaccineIds = null,
  }) {
    return _then(QuizSubmitResponse(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
      feedback: null == feedback
          ? _self.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as List<QuizAnswerFeedback>,
      newlyUnlockedVaccineIds: null == newlyUnlockedVaccineIds
          ? _self.newlyUnlockedVaccineIds
          : newlyUnlockedVaccineIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [QuizSubmitResponse].
extension QuizSubmitResponsePatterns on QuizSubmitResponse {
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
    TResult Function(_QuizSubmitResponse value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizSubmitResponse() when $default != null:
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
    TResult Function(_QuizSubmitResponse value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizSubmitResponse():
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
    TResult? Function(_QuizSubmitResponse value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizSubmitResponse() when $default != null:
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
            String message,
            @JsonKey(name: 'completed_at') String completedAt,
            @JsonKey(name: 'feedback') List<QuizAnswerFeedback> feedback,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _QuizSubmitResponse() when $default != null:
        return $default(_that.message, _that.completedAt, _that.feedback,
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
            String message,
            @JsonKey(name: 'completed_at') String completedAt,
            @JsonKey(name: 'feedback') List<QuizAnswerFeedback> feedback,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizSubmitResponse():
        return $default(_that.message, _that.completedAt, _that.feedback,
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
            String message,
            @JsonKey(name: 'completed_at') String completedAt,
            @JsonKey(name: 'feedback') List<QuizAnswerFeedback> feedback,
            @JsonKey(name: 'newly_unlocked_vaccine_ids')
            List<int> newlyUnlockedVaccineIds)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _QuizSubmitResponse() when $default != null:
        return $default(_that.message, _that.completedAt, _that.feedback,
            _that.newlyUnlockedVaccineIds);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _QuizSubmitResponse implements QuizSubmitResponse {
  const _QuizSubmitResponse(
      {required this.message,
      @JsonKey(name: 'completed_at') required this.completedAt,
      @JsonKey(name: 'feedback')
      List<QuizAnswerFeedback> feedback = const <QuizAnswerFeedback>[],
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds = const <int>[]})
      : _feedback = feedback,
        _newlyUnlockedVaccineIds = newlyUnlockedVaccineIds;
  factory _QuizSubmitResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizSubmitResponseFromJson(json);

  @override
  final String message;
  @override
  @JsonKey(name: 'completed_at')
  final String completedAt;
  final List<QuizAnswerFeedback> _feedback;
  @override
  @JsonKey(name: 'feedback')
  List<QuizAnswerFeedback> get feedback {
    if (_feedback is EqualUnmodifiableListView) return _feedback;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feedback);
  }

  final List<int> _newlyUnlockedVaccineIds;
  @override
  @JsonKey(name: 'newly_unlocked_vaccine_ids')
  List<int> get newlyUnlockedVaccineIds {
    if (_newlyUnlockedVaccineIds is EqualUnmodifiableListView)
      return _newlyUnlockedVaccineIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newlyUnlockedVaccineIds);
  }

  /// Create a copy of QuizSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuizSubmitResponseCopyWith<_QuizSubmitResponse> get copyWith =>
      __$QuizSubmitResponseCopyWithImpl<_QuizSubmitResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuizSubmitResponseToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuizSubmitResponse &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality().equals(other._feedback, _feedback) &&
            const DeepCollectionEquality().equals(
                other._newlyUnlockedVaccineIds, _newlyUnlockedVaccineIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      completedAt,
      const DeepCollectionEquality().hash(_feedback),
      const DeepCollectionEquality().hash(_newlyUnlockedVaccineIds));

  @override
  String toString() {
    return 'QuizSubmitResponse(message: $message, completedAt: $completedAt, feedback: $feedback, newlyUnlockedVaccineIds: $newlyUnlockedVaccineIds)';
  }
}

/// @nodoc
abstract mixin class _$QuizSubmitResponseCopyWith<$Res>
    implements $QuizSubmitResponseCopyWith<$Res> {
  factory _$QuizSubmitResponseCopyWith(
          _QuizSubmitResponse value, $Res Function(_QuizSubmitResponse) _then) =
      __$QuizSubmitResponseCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String message,
      @JsonKey(name: 'completed_at') String completedAt,
      @JsonKey(name: 'feedback') List<QuizAnswerFeedback> feedback,
      @JsonKey(name: 'newly_unlocked_vaccine_ids')
      List<int> newlyUnlockedVaccineIds});
}

/// @nodoc
class __$QuizSubmitResponseCopyWithImpl<$Res>
    implements _$QuizSubmitResponseCopyWith<$Res> {
  __$QuizSubmitResponseCopyWithImpl(this._self, this._then);

  final _QuizSubmitResponse _self;
  final $Res Function(_QuizSubmitResponse) _then;

  /// Create a copy of QuizSubmitResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
    Object? completedAt = null,
    Object? feedback = null,
    Object? newlyUnlockedVaccineIds = null,
  }) {
    return _then(_QuizSubmitResponse(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
      feedback: null == feedback
          ? _self._feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as List<QuizAnswerFeedback>,
      newlyUnlockedVaccineIds: null == newlyUnlockedVaccineIds
          ? _self._newlyUnlockedVaccineIds
          : newlyUnlockedVaccineIds // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

// dart format on
