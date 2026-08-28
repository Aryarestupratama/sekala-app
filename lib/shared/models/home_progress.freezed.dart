// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EraProgress {
  EraRef get era;
  int get completed;
  int get total;

  /// Create a copy of EraProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EraProgressCopyWith<EraProgress> get copyWith =>
      _$EraProgressCopyWithImpl<EraProgress>(this as EraProgress, _$identity);

  /// Serializes this EraProgress to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraProgress &&
            (identical(other.era, era) || other.era == era) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, era, completed, total);

  @override
  String toString() {
    return 'EraProgress(era: $era, completed: $completed, total: $total)';
  }
}

/// @nodoc
abstract mixin class $EraProgressCopyWith<$Res> {
  factory $EraProgressCopyWith(
          EraProgress value, $Res Function(EraProgress) _then) =
      _$EraProgressCopyWithImpl;
  @useResult
  $Res call({EraRef era, int completed, int total});

  $EraRefCopyWith<$Res> get era;
}

/// @nodoc
class _$EraProgressCopyWithImpl<$Res> implements $EraProgressCopyWith<$Res> {
  _$EraProgressCopyWithImpl(this._self, this._then);

  final EraProgress _self;
  final $Res Function(EraProgress) _then;

  /// Create a copy of EraProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? era = null,
    Object? completed = null,
    Object? total = null,
  }) {
    return _then(EraProgress(
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as EraRef,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of EraProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EraRefCopyWith<$Res> get era {
    return $EraRefCopyWith<$Res>(_self.era, (value) {
      return _then(_self.copyWith(era: value));
    });
  }
}

/// Adds pattern-matching-related methods to [EraProgress].
extension EraProgressPatterns on EraProgress {
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
    TResult Function(_EraProgress value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraProgress() when $default != null:
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
    TResult Function(_EraProgress value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraProgress():
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
    TResult? Function(_EraProgress value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraProgress() when $default != null:
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
    TResult Function(EraRef era, int completed, int total)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EraProgress() when $default != null:
        return $default(_that.era, _that.completed, _that.total);
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
    TResult Function(EraRef era, int completed, int total) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraProgress():
        return $default(_that.era, _that.completed, _that.total);
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
    TResult? Function(EraRef era, int completed, int total)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EraProgress() when $default != null:
        return $default(_that.era, _that.completed, _that.total);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EraProgress extends EraProgress {
  const _EraProgress(
      {required this.era, required this.completed, required this.total})
      : super._();
  factory _EraProgress.fromJson(Map<String, dynamic> json) =>
      _$EraProgressFromJson(json);

  @override
  final EraRef era;
  @override
  final int completed;
  @override
  final int total;

  /// Create a copy of EraProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EraProgressCopyWith<_EraProgress> get copyWith =>
      __$EraProgressCopyWithImpl<_EraProgress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EraProgressToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EraProgress &&
            (identical(other.era, era) || other.era == era) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, era, completed, total);

  @override
  String toString() {
    return 'EraProgress(era: $era, completed: $completed, total: $total)';
  }
}

/// @nodoc
abstract mixin class _$EraProgressCopyWith<$Res>
    implements $EraProgressCopyWith<$Res> {
  factory _$EraProgressCopyWith(
          _EraProgress value, $Res Function(_EraProgress) _then) =
      __$EraProgressCopyWithImpl;
  @override
  @useResult
  $Res call({EraRef era, int completed, int total});

  @override
  $EraRefCopyWith<$Res> get era;
}

/// @nodoc
class __$EraProgressCopyWithImpl<$Res> implements _$EraProgressCopyWith<$Res> {
  __$EraProgressCopyWithImpl(this._self, this._then);

  final _EraProgress _self;
  final $Res Function(_EraProgress) _then;

  /// Create a copy of EraProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? era = null,
    Object? completed = null,
    Object? total = null,
  }) {
    return _then(_EraProgress(
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as EraRef,
      completed: null == completed
          ? _self.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of EraProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EraRefCopyWith<$Res> get era {
    return $EraRefCopyWith<$Res>(_self.era, (value) {
      return _then(_self.copyWith(era: value));
    });
  }
}

/// @nodoc
mixin _$HomeRecommendation {
  String get type;
  EraRef get era;
  RecommendationYear? get year;

  /// Create a copy of HomeRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeRecommendationCopyWith<HomeRecommendation> get copyWith =>
      _$HomeRecommendationCopyWithImpl<HomeRecommendation>(
          this as HomeRecommendation, _$identity);

  /// Serializes this HomeRecommendation to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeRecommendation &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.era, era) || other.era == era) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, era, year);

  @override
  String toString() {
    return 'HomeRecommendation(type: $type, era: $era, year: $year)';
  }
}

/// @nodoc
abstract mixin class $HomeRecommendationCopyWith<$Res> {
  factory $HomeRecommendationCopyWith(
          HomeRecommendation value, $Res Function(HomeRecommendation) _then) =
      _$HomeRecommendationCopyWithImpl;
  @useResult
  $Res call({String type, EraRef era, RecommendationYear? year});

  $EraRefCopyWith<$Res> get era;
  $RecommendationYearCopyWith<$Res>? get year;
}

/// @nodoc
class _$HomeRecommendationCopyWithImpl<$Res>
    implements $HomeRecommendationCopyWith<$Res> {
  _$HomeRecommendationCopyWithImpl(this._self, this._then);

  final HomeRecommendation _self;
  final $Res Function(HomeRecommendation) _then;

  /// Create a copy of HomeRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? era = null,
    Object? year = freezed,
  }) {
    return _then(HomeRecommendation(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as EraRef,
      year: freezed == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as RecommendationYear?,
    ));
  }

  /// Create a copy of HomeRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EraRefCopyWith<$Res> get era {
    return $EraRefCopyWith<$Res>(_self.era, (value) {
      return _then(_self.copyWith(era: value));
    });
  }

  /// Create a copy of HomeRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecommendationYearCopyWith<$Res>? get year {
    if (_self.year == null) {
      return null;
    }

    return $RecommendationYearCopyWith<$Res>(_self.year!, (value) {
      return _then(_self.copyWith(year: value));
    });
  }
}

/// Adds pattern-matching-related methods to [HomeRecommendation].
extension HomeRecommendationPatterns on HomeRecommendation {
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
    TResult Function(_HomeRecommendation value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeRecommendation() when $default != null:
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
    TResult Function(_HomeRecommendation value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeRecommendation():
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
    TResult? Function(_HomeRecommendation value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeRecommendation() when $default != null:
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
    TResult Function(String type, EraRef era, RecommendationYear? year)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeRecommendation() when $default != null:
        return $default(_that.type, _that.era, _that.year);
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
    TResult Function(String type, EraRef era, RecommendationYear? year)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeRecommendation():
        return $default(_that.type, _that.era, _that.year);
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
    TResult? Function(String type, EraRef era, RecommendationYear? year)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeRecommendation() when $default != null:
        return $default(_that.type, _that.era, _that.year);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeRecommendation extends HomeRecommendation {
  const _HomeRecommendation({required this.type, required this.era, this.year})
      : super._();
  factory _HomeRecommendation.fromJson(Map<String, dynamic> json) =>
      _$HomeRecommendationFromJson(json);

  @override
  final String type;
  @override
  final EraRef era;
  @override
  final RecommendationYear? year;

  /// Create a copy of HomeRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeRecommendationCopyWith<_HomeRecommendation> get copyWith =>
      __$HomeRecommendationCopyWithImpl<_HomeRecommendation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeRecommendationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeRecommendation &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.era, era) || other.era == era) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, era, year);

  @override
  String toString() {
    return 'HomeRecommendation(type: $type, era: $era, year: $year)';
  }
}

/// @nodoc
abstract mixin class _$HomeRecommendationCopyWith<$Res>
    implements $HomeRecommendationCopyWith<$Res> {
  factory _$HomeRecommendationCopyWith(
          _HomeRecommendation value, $Res Function(_HomeRecommendation) _then) =
      __$HomeRecommendationCopyWithImpl;
  @override
  @useResult
  $Res call({String type, EraRef era, RecommendationYear? year});

  @override
  $EraRefCopyWith<$Res> get era;
  @override
  $RecommendationYearCopyWith<$Res>? get year;
}

/// @nodoc
class __$HomeRecommendationCopyWithImpl<$Res>
    implements _$HomeRecommendationCopyWith<$Res> {
  __$HomeRecommendationCopyWithImpl(this._self, this._then);

  final _HomeRecommendation _self;
  final $Res Function(_HomeRecommendation) _then;

  /// Create a copy of HomeRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? era = null,
    Object? year = freezed,
  }) {
    return _then(_HomeRecommendation(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as EraRef,
      year: freezed == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as RecommendationYear?,
    ));
  }

  /// Create a copy of HomeRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EraRefCopyWith<$Res> get era {
    return $EraRefCopyWith<$Res>(_self.era, (value) {
      return _then(_self.copyWith(era: value));
    });
  }

  /// Create a copy of HomeRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecommendationYearCopyWith<$Res>? get year {
    if (_self.year == null) {
      return null;
    }

    return $RecommendationYearCopyWith<$Res>(_self.year!, (value) {
      return _then(_self.copyWith(year: value));
    });
  }
}

/// @nodoc
mixin _$RecommendationYear {
  int get id;
  int get year;
  String get title;

  /// Create a copy of RecommendationYear
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecommendationYearCopyWith<RecommendationYear> get copyWith =>
      _$RecommendationYearCopyWithImpl<RecommendationYear>(
          this as RecommendationYear, _$identity);

  /// Serializes this RecommendationYear to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecommendationYear &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, title);

  @override
  String toString() {
    return 'RecommendationYear(id: $id, year: $year, title: $title)';
  }
}

/// @nodoc
abstract mixin class $RecommendationYearCopyWith<$Res> {
  factory $RecommendationYearCopyWith(
          RecommendationYear value, $Res Function(RecommendationYear) _then) =
      _$RecommendationYearCopyWithImpl;
  @useResult
  $Res call({int id, int year, String title});
}

/// @nodoc
class _$RecommendationYearCopyWithImpl<$Res>
    implements $RecommendationYearCopyWith<$Res> {
  _$RecommendationYearCopyWithImpl(this._self, this._then);

  final RecommendationYear _self;
  final $Res Function(RecommendationYear) _then;

  /// Create a copy of RecommendationYear
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? title = null,
  }) {
    return _then(RecommendationYear(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecommendationYear].
extension RecommendationYearPatterns on RecommendationYear {
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
    TResult Function(_RecommendationYear value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecommendationYear() when $default != null:
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
    TResult Function(_RecommendationYear value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendationYear():
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
    TResult? Function(_RecommendationYear value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendationYear() when $default != null:
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
    TResult Function(int id, int year, String title)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecommendationYear() when $default != null:
        return $default(_that.id, _that.year, _that.title);
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
    TResult Function(int id, int year, String title) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendationYear():
        return $default(_that.id, _that.year, _that.title);
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
    TResult? Function(int id, int year, String title)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecommendationYear() when $default != null:
        return $default(_that.id, _that.year, _that.title);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecommendationYear implements RecommendationYear {
  const _RecommendationYear(
      {required this.id, required this.year, required this.title});
  factory _RecommendationYear.fromJson(Map<String, dynamic> json) =>
      _$RecommendationYearFromJson(json);

  @override
  final int id;
  @override
  final int year;
  @override
  final String title;

  /// Create a copy of RecommendationYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecommendationYearCopyWith<_RecommendationYear> get copyWith =>
      __$RecommendationYearCopyWithImpl<_RecommendationYear>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecommendationYearToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecommendationYear &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, year, title);

  @override
  String toString() {
    return 'RecommendationYear(id: $id, year: $year, title: $title)';
  }
}

/// @nodoc
abstract mixin class _$RecommendationYearCopyWith<$Res>
    implements $RecommendationYearCopyWith<$Res> {
  factory _$RecommendationYearCopyWith(
          _RecommendationYear value, $Res Function(_RecommendationYear) _then) =
      __$RecommendationYearCopyWithImpl;
  @override
  @useResult
  $Res call({int id, int year, String title});
}

/// @nodoc
class __$RecommendationYearCopyWithImpl<$Res>
    implements _$RecommendationYearCopyWith<$Res> {
  __$RecommendationYearCopyWithImpl(this._self, this._then);

  final _RecommendationYear _self;
  final $Res Function(_RecommendationYear) _then;

  /// Create a copy of RecommendationYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? title = null,
  }) {
    return _then(_RecommendationYear(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$HomeSummary {
  @JsonKey(name: 'progress_by_era')
  List<EraProgress> get progressByEra;
  HomeRecommendation? get recommendation;

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeSummaryCopyWith<HomeSummary> get copyWith =>
      _$HomeSummaryCopyWithImpl<HomeSummary>(this as HomeSummary, _$identity);

  /// Serializes this HomeSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeSummary &&
            const DeepCollectionEquality()
                .equals(other.progressByEra, progressByEra) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(progressByEra), recommendation);

  @override
  String toString() {
    return 'HomeSummary(progressByEra: $progressByEra, recommendation: $recommendation)';
  }
}

/// @nodoc
abstract mixin class $HomeSummaryCopyWith<$Res> {
  factory $HomeSummaryCopyWith(
          HomeSummary value, $Res Function(HomeSummary) _then) =
      _$HomeSummaryCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'progress_by_era') List<EraProgress> progressByEra,
      HomeRecommendation? recommendation});

  $HomeRecommendationCopyWith<$Res>? get recommendation;
}

/// @nodoc
class _$HomeSummaryCopyWithImpl<$Res> implements $HomeSummaryCopyWith<$Res> {
  _$HomeSummaryCopyWithImpl(this._self, this._then);

  final HomeSummary _self;
  final $Res Function(HomeSummary) _then;

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progressByEra = null,
    Object? recommendation = freezed,
  }) {
    return _then(HomeSummary(
      progressByEra: null == progressByEra
          ? _self.progressByEra
          : progressByEra // ignore: cast_nullable_to_non_nullable
              as List<EraProgress>,
      recommendation: freezed == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as HomeRecommendation?,
    ));
  }

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeRecommendationCopyWith<$Res>? get recommendation {
    if (_self.recommendation == null) {
      return null;
    }

    return $HomeRecommendationCopyWith<$Res>(_self.recommendation!, (value) {
      return _then(_self.copyWith(recommendation: value));
    });
  }
}

/// Adds pattern-matching-related methods to [HomeSummary].
extension HomeSummaryPatterns on HomeSummary {
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
    TResult Function(_HomeSummary value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeSummary() when $default != null:
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
    TResult Function(_HomeSummary value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeSummary():
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
    TResult? Function(_HomeSummary value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeSummary() when $default != null:
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
            @JsonKey(name: 'progress_by_era') List<EraProgress> progressByEra,
            HomeRecommendation? recommendation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeSummary() when $default != null:
        return $default(_that.progressByEra, _that.recommendation);
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
            @JsonKey(name: 'progress_by_era') List<EraProgress> progressByEra,
            HomeRecommendation? recommendation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeSummary():
        return $default(_that.progressByEra, _that.recommendation);
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
            @JsonKey(name: 'progress_by_era') List<EraProgress> progressByEra,
            HomeRecommendation? recommendation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeSummary() when $default != null:
        return $default(_that.progressByEra, _that.recommendation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeSummary implements HomeSummary {
  const _HomeSummary(
      {@JsonKey(name: 'progress_by_era')
      List<EraProgress> progressByEra = const <EraProgress>[],
      this.recommendation})
      : _progressByEra = progressByEra;
  factory _HomeSummary.fromJson(Map<String, dynamic> json) =>
      _$HomeSummaryFromJson(json);

  final List<EraProgress> _progressByEra;
  @override
  @JsonKey(name: 'progress_by_era')
  List<EraProgress> get progressByEra {
    if (_progressByEra is EqualUnmodifiableListView) return _progressByEra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_progressByEra);
  }

  @override
  final HomeRecommendation? recommendation;

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeSummaryCopyWith<_HomeSummary> get copyWith =>
      __$HomeSummaryCopyWithImpl<_HomeSummary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeSummaryToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeSummary &&
            const DeepCollectionEquality()
                .equals(other._progressByEra, _progressByEra) &&
            (identical(other.recommendation, recommendation) ||
                other.recommendation == recommendation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_progressByEra), recommendation);

  @override
  String toString() {
    return 'HomeSummary(progressByEra: $progressByEra, recommendation: $recommendation)';
  }
}

/// @nodoc
abstract mixin class _$HomeSummaryCopyWith<$Res>
    implements $HomeSummaryCopyWith<$Res> {
  factory _$HomeSummaryCopyWith(
          _HomeSummary value, $Res Function(_HomeSummary) _then) =
      __$HomeSummaryCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'progress_by_era') List<EraProgress> progressByEra,
      HomeRecommendation? recommendation});

  @override
  $HomeRecommendationCopyWith<$Res>? get recommendation;
}

/// @nodoc
class __$HomeSummaryCopyWithImpl<$Res> implements _$HomeSummaryCopyWith<$Res> {
  __$HomeSummaryCopyWithImpl(this._self, this._then);

  final _HomeSummary _self;
  final $Res Function(_HomeSummary) _then;

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? progressByEra = null,
    Object? recommendation = freezed,
  }) {
    return _then(_HomeSummary(
      progressByEra: null == progressByEra
          ? _self._progressByEra
          : progressByEra // ignore: cast_nullable_to_non_nullable
              as List<EraProgress>,
      recommendation: freezed == recommendation
          ? _self.recommendation
          : recommendation // ignore: cast_nullable_to_non_nullable
              as HomeRecommendation?,
    ));
  }

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeRecommendationCopyWith<$Res>? get recommendation {
    if (_self.recommendation == null) {
      return null;
    }

    return $HomeRecommendationCopyWith<$Res>(_self.recommendation!, (value) {
      return _then(_self.copyWith(recommendation: value));
    });
  }
}

// dart format on
