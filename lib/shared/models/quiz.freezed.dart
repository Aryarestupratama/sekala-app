// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Quiz {
  int get id;
  @JsonKey(name: 'year_id')
  int get yearId;
  @JsonKey(name: 'is_published')
  bool get isPublished;
  List<QuizQuestion> get questions;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuizCopyWith<Quiz> get copyWith =>
      _$QuizCopyWithImpl<Quiz>(this as Quiz, _$identity);

  /// Serializes this Quiz to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Quiz &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.yearId, yearId) || other.yearId == yearId) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            const DeepCollectionEquality().equals(other.questions, questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, yearId, isPublished,
      const DeepCollectionEquality().hash(questions));

  @override
  String toString() {
    return 'Quiz(id: $id, yearId: $yearId, isPublished: $isPublished, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class $QuizCopyWith<$Res> {
  factory $QuizCopyWith(Quiz value, $Res Function(Quiz) _then) =
      _$QuizCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'year_id') int yearId,
      @JsonKey(name: 'is_published') bool isPublished,
      List<QuizQuestion> questions});
}

/// @nodoc
class _$QuizCopyWithImpl<$Res> implements $QuizCopyWith<$Res> {
  _$QuizCopyWithImpl(this._self, this._then);

  final Quiz _self;
  final $Res Function(Quiz) _then;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? yearId = null,
    Object? isPublished = null,
    Object? questions = null,
  }) {
    return _then(Quiz(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      yearId: null == yearId
          ? _self.yearId
          : yearId // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      questions: null == questions
          ? _self.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuizQuestion>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Quiz].
extension QuizPatterns on Quiz {
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
    TResult Function(_Quiz value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Quiz() when $default != null:
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
    TResult Function(_Quiz value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Quiz():
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
    TResult? Function(_Quiz value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Quiz() when $default != null:
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
            int id,
            @JsonKey(name: 'year_id') int yearId,
            @JsonKey(name: 'is_published') bool isPublished,
            List<QuizQuestion> questions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Quiz() when $default != null:
        return $default(
            _that.id, _that.yearId, _that.isPublished, _that.questions);
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
            int id,
            @JsonKey(name: 'year_id') int yearId,
            @JsonKey(name: 'is_published') bool isPublished,
            List<QuizQuestion> questions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Quiz():
        return $default(
            _that.id, _that.yearId, _that.isPublished, _that.questions);
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
            int id,
            @JsonKey(name: 'year_id') int yearId,
            @JsonKey(name: 'is_published') bool isPublished,
            List<QuizQuestion> questions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Quiz() when $default != null:
        return $default(
            _that.id, _that.yearId, _that.isPublished, _that.questions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Quiz implements Quiz {
  const _Quiz(
      {required this.id,
      @JsonKey(name: 'year_id') required this.yearId,
      @JsonKey(name: 'is_published') required this.isPublished,
      List<QuizQuestion> questions = const <QuizQuestion>[]})
      : _questions = questions;
  factory _Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'year_id')
  final int yearId;
  @override
  @JsonKey(name: 'is_published')
  final bool isPublished;
  final List<QuizQuestion> _questions;
  @override
  @JsonKey()
  List<QuizQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuizCopyWith<_Quiz> get copyWith =>
      __$QuizCopyWithImpl<_Quiz>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuizToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Quiz &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.yearId, yearId) || other.yearId == yearId) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, yearId, isPublished,
      const DeepCollectionEquality().hash(_questions));

  @override
  String toString() {
    return 'Quiz(id: $id, yearId: $yearId, isPublished: $isPublished, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class _$QuizCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$QuizCopyWith(_Quiz value, $Res Function(_Quiz) _then) =
      __$QuizCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'year_id') int yearId,
      @JsonKey(name: 'is_published') bool isPublished,
      List<QuizQuestion> questions});
}

/// @nodoc
class __$QuizCopyWithImpl<$Res> implements _$QuizCopyWith<$Res> {
  __$QuizCopyWithImpl(this._self, this._then);

  final _Quiz _self;
  final $Res Function(_Quiz) _then;

  /// Create a copy of Quiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? yearId = null,
    Object? isPublished = null,
    Object? questions = null,
  }) {
    return _then(_Quiz(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      yearId: null == yearId
          ? _self.yearId
          : yearId // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      questions: null == questions
          ? _self._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuizQuestion>,
    ));
  }
}

// dart format on
