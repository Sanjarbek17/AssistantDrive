// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DetectionModel _$DetectionModelFromJson(Map<String, dynamic> json) {
  return _DetectionModel.fromJson(json);
}

/// @nodoc
mixin _$DetectionModel {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  BoundingBoxModel get boundingBox => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;

  /// Serializes this DetectionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetectionModelCopyWith<DetectionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetectionModelCopyWith<$Res> {
  factory $DetectionModelCopyWith(
    DetectionModel value,
    $Res Function(DetectionModel) then,
  ) = _$DetectionModelCopyWithImpl<$Res, DetectionModel>;
  @useResult
  $Res call({
    String id,
    String type,
    double confidence,
    BoundingBoxModel boundingBox,
    DateTime timestamp,
    Map<String, dynamic> metadata,
  });

  $BoundingBoxModelCopyWith<$Res> get boundingBox;
}

/// @nodoc
class _$DetectionModelCopyWithImpl<$Res, $Val extends DetectionModel>
    implements $DetectionModelCopyWith<$Res> {
  _$DetectionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? confidence = null,
    Object? boundingBox = null,
    Object? timestamp = null,
    Object? metadata = null,
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
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            boundingBox: null == boundingBox
                ? _value.boundingBox
                : boundingBox // ignore: cast_nullable_to_non_nullable
                      as BoundingBoxModel,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }

  /// Create a copy of DetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoundingBoxModelCopyWith<$Res> get boundingBox {
    return $BoundingBoxModelCopyWith<$Res>(_value.boundingBox, (value) {
      return _then(_value.copyWith(boundingBox: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetectionModelImplCopyWith<$Res>
    implements $DetectionModelCopyWith<$Res> {
  factory _$$DetectionModelImplCopyWith(
    _$DetectionModelImpl value,
    $Res Function(_$DetectionModelImpl) then,
  ) = __$$DetectionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String type,
    double confidence,
    BoundingBoxModel boundingBox,
    DateTime timestamp,
    Map<String, dynamic> metadata,
  });

  @override
  $BoundingBoxModelCopyWith<$Res> get boundingBox;
}

/// @nodoc
class __$$DetectionModelImplCopyWithImpl<$Res>
    extends _$DetectionModelCopyWithImpl<$Res, _$DetectionModelImpl>
    implements _$$DetectionModelImplCopyWith<$Res> {
  __$$DetectionModelImplCopyWithImpl(
    _$DetectionModelImpl _value,
    $Res Function(_$DetectionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? confidence = null,
    Object? boundingBox = null,
    Object? timestamp = null,
    Object? metadata = null,
  }) {
    return _then(
      _$DetectionModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        boundingBox: null == boundingBox
            ? _value.boundingBox
            : boundingBox // ignore: cast_nullable_to_non_nullable
                  as BoundingBoxModel,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        metadata: null == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DetectionModelImpl implements _DetectionModel {
  const _$DetectionModelImpl({
    required this.id,
    required this.type,
    required this.confidence,
    required this.boundingBox,
    required this.timestamp,
    final Map<String, dynamic> metadata = const {},
  }) : _metadata = metadata;

  factory _$DetectionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetectionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String type;
  @override
  final double confidence;
  @override
  final BoundingBoxModel boundingBox;
  @override
  final DateTime timestamp;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  String toString() {
    return 'DetectionModel(id: $id, type: $type, confidence: $confidence, boundingBox: $boundingBox, timestamp: $timestamp, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetectionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.boundingBox, boundingBox) ||
                other.boundingBox == boundingBox) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    confidence,
    boundingBox,
    timestamp,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of DetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetectionModelImplCopyWith<_$DetectionModelImpl> get copyWith =>
      __$$DetectionModelImplCopyWithImpl<_$DetectionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DetectionModelImplToJson(this);
  }
}

abstract class _DetectionModel implements DetectionModel {
  const factory _DetectionModel({
    required final String id,
    required final String type,
    required final double confidence,
    required final BoundingBoxModel boundingBox,
    required final DateTime timestamp,
    final Map<String, dynamic> metadata,
  }) = _$DetectionModelImpl;

  factory _DetectionModel.fromJson(Map<String, dynamic> json) =
      _$DetectionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  double get confidence;
  @override
  BoundingBoxModel get boundingBox;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic> get metadata;

  /// Create a copy of DetectionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetectionModelImplCopyWith<_$DetectionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BoundingBoxModel _$BoundingBoxModelFromJson(Map<String, dynamic> json) {
  return _BoundingBoxModel.fromJson(json);
}

/// @nodoc
mixin _$BoundingBoxModel {
  double get left => throw _privateConstructorUsedError;
  double get top => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;

  /// Serializes this BoundingBoxModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoundingBoxModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoundingBoxModelCopyWith<BoundingBoxModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoundingBoxModelCopyWith<$Res> {
  factory $BoundingBoxModelCopyWith(
    BoundingBoxModel value,
    $Res Function(BoundingBoxModel) then,
  ) = _$BoundingBoxModelCopyWithImpl<$Res, BoundingBoxModel>;
  @useResult
  $Res call({double left, double top, double width, double height});
}

/// @nodoc
class _$BoundingBoxModelCopyWithImpl<$Res, $Val extends BoundingBoxModel>
    implements $BoundingBoxModelCopyWith<$Res> {
  _$BoundingBoxModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoundingBoxModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? left = null,
    Object? top = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(
      _value.copyWith(
            left: null == left
                ? _value.left
                : left // ignore: cast_nullable_to_non_nullable
                      as double,
            top: null == top
                ? _value.top
                : top // ignore: cast_nullable_to_non_nullable
                      as double,
            width: null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as double,
            height: null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BoundingBoxModelImplCopyWith<$Res>
    implements $BoundingBoxModelCopyWith<$Res> {
  factory _$$BoundingBoxModelImplCopyWith(
    _$BoundingBoxModelImpl value,
    $Res Function(_$BoundingBoxModelImpl) then,
  ) = __$$BoundingBoxModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double left, double top, double width, double height});
}

/// @nodoc
class __$$BoundingBoxModelImplCopyWithImpl<$Res>
    extends _$BoundingBoxModelCopyWithImpl<$Res, _$BoundingBoxModelImpl>
    implements _$$BoundingBoxModelImplCopyWith<$Res> {
  __$$BoundingBoxModelImplCopyWithImpl(
    _$BoundingBoxModelImpl _value,
    $Res Function(_$BoundingBoxModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoundingBoxModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? left = null,
    Object? top = null,
    Object? width = null,
    Object? height = null,
  }) {
    return _then(
      _$BoundingBoxModelImpl(
        left: null == left
            ? _value.left
            : left // ignore: cast_nullable_to_non_nullable
                  as double,
        top: null == top
            ? _value.top
            : top // ignore: cast_nullable_to_non_nullable
                  as double,
        width: null == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as double,
        height: null == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BoundingBoxModelImpl implements _BoundingBoxModel {
  const _$BoundingBoxModelImpl({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  factory _$BoundingBoxModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoundingBoxModelImplFromJson(json);

  @override
  final double left;
  @override
  final double top;
  @override
  final double width;
  @override
  final double height;

  @override
  String toString() {
    return 'BoundingBoxModel(left: $left, top: $top, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoundingBoxModelImpl &&
            (identical(other.left, left) || other.left == left) &&
            (identical(other.top, top) || other.top == top) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, left, top, width, height);

  /// Create a copy of BoundingBoxModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoundingBoxModelImplCopyWith<_$BoundingBoxModelImpl> get copyWith =>
      __$$BoundingBoxModelImplCopyWithImpl<_$BoundingBoxModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BoundingBoxModelImplToJson(this);
  }
}

abstract class _BoundingBoxModel implements BoundingBoxModel {
  const factory _BoundingBoxModel({
    required final double left,
    required final double top,
    required final double width,
    required final double height,
  }) = _$BoundingBoxModelImpl;

  factory _BoundingBoxModel.fromJson(Map<String, dynamic> json) =
      _$BoundingBoxModelImpl.fromJson;

  @override
  double get left;
  @override
  double get top;
  @override
  double get width;
  @override
  double get height;

  /// Create a copy of BoundingBoxModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoundingBoxModelImplCopyWith<_$BoundingBoxModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
