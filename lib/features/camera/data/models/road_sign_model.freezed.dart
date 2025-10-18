// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'road_sign_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RoadSignModel _$RoadSignModelFromJson(Map<String, dynamic> json) {
  return _RoadSignModel.fromJson(json);
}

/// @nodoc
mixin _$RoadSignModel {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get audioKey => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;

  /// Serializes this RoadSignModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoadSignModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoadSignModelCopyWith<RoadSignModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoadSignModelCopyWith<$Res> {
  factory $RoadSignModelCopyWith(
    RoadSignModel value,
    $Res Function(RoadSignModel) then,
  ) = _$RoadSignModelCopyWithImpl<$Res, RoadSignModel>;
  @useResult
  $Res call({
    String id,
    String type,
    String name,
    String description,
    String audioKey,
    int priority,
    String color,
    bool isUrgent,
  });
}

/// @nodoc
class _$RoadSignModelCopyWithImpl<$Res, $Val extends RoadSignModel>
    implements $RoadSignModelCopyWith<$Res> {
  _$RoadSignModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoadSignModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? audioKey = null,
    Object? priority = null,
    Object? color = null,
    Object? isUrgent = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            audioKey: null == audioKey
                ? _value.audioKey
                : audioKey // ignore: cast_nullable_to_non_nullable
                      as String,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as int,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            isUrgent: null == isUrgent
                ? _value.isUrgent
                : isUrgent // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RoadSignModelImplCopyWith<$Res>
    implements $RoadSignModelCopyWith<$Res> {
  factory _$$RoadSignModelImplCopyWith(
    _$RoadSignModelImpl value,
    $Res Function(_$RoadSignModelImpl) then,
  ) = __$$RoadSignModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    String name,
    String description,
    String audioKey,
    int priority,
    String color,
    bool isUrgent,
  });
}

/// @nodoc
class __$$RoadSignModelImplCopyWithImpl<$Res>
    extends _$RoadSignModelCopyWithImpl<$Res, _$RoadSignModelImpl>
    implements _$$RoadSignModelImplCopyWith<$Res> {
  __$$RoadSignModelImplCopyWithImpl(
    _$RoadSignModelImpl _value,
    $Res Function(_$RoadSignModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RoadSignModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? audioKey = null,
    Object? priority = null,
    Object? color = null,
    Object? isUrgent = null,
  }) {
    return _then(
      _$RoadSignModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        audioKey: null == audioKey
            ? _value.audioKey
            : audioKey // ignore: cast_nullable_to_non_nullable
                  as String,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as int,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        isUrgent: null == isUrgent
            ? _value.isUrgent
            : isUrgent // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RoadSignModelImpl implements _RoadSignModel {
  const _$RoadSignModelImpl({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.audioKey,
    required this.priority,
    required this.color,
    this.isUrgent = false,
  });

  factory _$RoadSignModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoadSignModelImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final String name;
  @override
  final String description;
  @override
  final String audioKey;
  @override
  final int priority;
  @override
  final String color;
  @override
  @JsonKey()
  final bool isUrgent;

  @override
  String toString() {
    return 'RoadSignModel(id: $id, type: $type, name: $name, description: $description, audioKey: $audioKey, priority: $priority, color: $color, isUrgent: $isUrgent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoadSignModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.audioKey, audioKey) ||
                other.audioKey == audioKey) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    name,
    description,
    audioKey,
    priority,
    color,
    isUrgent,
  );

  /// Create a copy of RoadSignModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoadSignModelImplCopyWith<_$RoadSignModelImpl> get copyWith =>
      __$$RoadSignModelImplCopyWithImpl<_$RoadSignModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoadSignModelImplToJson(this);
  }
}

abstract class _RoadSignModel implements RoadSignModel {
  const factory _RoadSignModel({
    required final String id,
    required final String type,
    required final String name,
    required final String description,
    required final String audioKey,
    required final int priority,
    required final String color,
    final bool isUrgent,
  }) = _$RoadSignModelImpl;

  factory _RoadSignModel.fromJson(Map<String, dynamic> json) =
      _$RoadSignModelImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get name;
  @override
  String get description;
  @override
  String get audioKey;
  @override
  int get priority;
  @override
  String get color;
  @override
  bool get isUrgent;

  /// Create a copy of RoadSignModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoadSignModelImplCopyWith<_$RoadSignModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
