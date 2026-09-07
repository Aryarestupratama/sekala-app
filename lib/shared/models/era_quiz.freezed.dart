// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'era_quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraQuiz {
  int get id;
  @JsonKey(name: 'era_id')
  int get eraId;
  @JsonKey(name: 'is_published')
  bool get isPublished;
  List<EraQuizQuestion> get questions;

  /// Create a copy of EraQuiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraQuizCopyWith<EraQuiz> get copyWith =>
      _$EraQuizCopyWithImpl<EraQuiz>(this as EraQuiz, _$identity);

  /// Serializes this EraQuiz to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraQuiz &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eraId, eraId) || other.eraId == eraId) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            const DeepCollectionEquality().equals(other.questions, questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, eraId, isPublished,
      const DeepCollectionEquality().hash(questions));

  @override
  String toString() {
    return 'EraQuiz(id: $id, eraId: $eraId, isPublished: $isPublished, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class $EraQuizCopyWith<$Res> {
  factory $EraQuizCopyWith(EraQuiz value, $Res Function(EraQuiz) _then) =
      _$EraQuizCopyWithImpl;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'era_id') int eraId,
      @JsonKey(name: 'is_published') bool isPublished,
      List<EraQuizQuestion> questions});
}

/// @nodoc
class _$EraQuizCopyWithImpl<$Res> implements $EraQuizCopyWith<$Res> {
  _$EraQuizCopyWithImpl(this._self, this._then);

  final EraQuiz _self;
  final $Res Function(EraQuiz) _then;

  /// Create a copy of EraQuiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eraId = null,
    Object? isPublished = null,
    Object? questions = null,
  }) {
    return _then(EraQuiz(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eraId: null == eraId
          ? _self.eraId
          : eraId // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      questions: null == questions
          ? _self.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<EraQuizQuestion>,
    ));
  }
}

/// Adds pattern-matching-related methods to [EraQuiz].
extension EraQuizPatterns on EraQuiz {
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
    TResult Function(_EraQuiz value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuiz() when $default != null:
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
    TResult Function(_EraQuiz value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuiz():
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
    TResult? Function(_EraQuiz value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuiz() when $default != null:
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
            @JsonKey(name: 'era_id') int eraId,
            @JsonKey(name: 'is_published') bool isPublished,
            List<EraQuizQuestion> questions)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraQuiz() when $default != null:
        return $default(
            _that.id, _that.eraId, _that.isPublished, _that.questions);
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
            @JsonKey(name: 'era_id') int eraId,
            @JsonKey(name: 'is_published') bool isPublished,
            List<EraQuizQuestion> questions)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuiz():
        return $default(
            _that.id, _that.eraId, _that.isPublished, _that.questions);
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
            @JsonKey(name: 'era_id') int eraId,
            @JsonKey(name: 'is_published') bool isPublished,
            List<EraQuizQuestion> questions)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraQuiz() when $default != null:
        return $default(
            _that.id, _that.eraId, _that.isPublished, _that.questions);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraQuiz implements EraQuiz {
  const _EraQuiz(
      {required this.id,
      @JsonKey(name: 'era_id') required this.eraId,
      @JsonKey(name: 'is_published') required this.isPublished,
      List<EraQuizQuestion> questions = const <EraQuizQuestion>[]})
      : _questions = questions;
  factory _EraQuiz.fromJson(Map<String, dynamic> json) =>
      _$EraQuizFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'era_id')
  final int eraId;
  @override
  @JsonKey(name: 'is_published')
  final bool isPublished;
  final List<EraQuizQuestion> _questions;
  @override
  @JsonKey()
  List<EraQuizQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  /// Create a copy of EraQuiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraQuizCopyWith<_EraQuiz> get copyWith =>
      __$EraQuizCopyWithImpl<_EraQuiz>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraQuizToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraQuiz &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eraId, eraId) || other.eraId == eraId) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, eraId, isPublished,
      const DeepCollectionEquality().hash(_questions));

  @override
  String toString() {
    return 'EraQuiz(id: $id, eraId: $eraId, isPublished: $isPublished, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class _$EraQuizCopyWith<$Res> implements $EraQuizCopyWith<$Res> {
  factory _$EraQuizCopyWith(_EraQuiz value, $Res Function(_EraQuiz) _then) =
      __$EraQuizCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'era_id') int eraId,
      @JsonKey(name: 'is_published') bool isPublished,
      List<EraQuizQuestion> questions});
}

/// @nodoc
class __$EraQuizCopyWithImpl<$Res> implements _$EraQuizCopyWith<$Res> {
  __$EraQuizCopyWithImpl(this._self, this._then);

  final _EraQuiz _self;
  final $Res Function(_EraQuiz) _then;

  /// Create a copy of EraQuiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? eraId = null,
    Object? isPublished = null,
    Object? questions = null,
  }) {
    return _then(_EraQuiz(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      eraId: null == eraId
          ? _self.eraId
          : eraId // ignore: cast_nullable_to_non_nullable
              as int,
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      questions: null == questions
          ? _self._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<EraQuizQuestion>,
    ));
  }
}

// dart format on
