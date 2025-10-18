// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetectionModelImpl _$$DetectionModelImplFromJson(Map<String, dynamic> json) =>
    _$DetectionModelImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      boundingBox: BoundingBoxModel.fromJson(
        json['boundingBox'] as Map<String, dynamic>,
      ),
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$DetectionModelImplToJson(
  _$DetectionModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'confidence': instance.confidence,
  'boundingBox': instance.boundingBox,
  'timestamp': instance.timestamp.toIso8601String(),
  'metadata': instance.metadata,
};

_$BoundingBoxModelImpl _$$BoundingBoxModelImplFromJson(
  Map<String, dynamic> json,
) => _$BoundingBoxModelImpl(
  left: (json['left'] as num).toDouble(),
  top: (json['top'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
);

Map<String, dynamic> _$$BoundingBoxModelImplToJson(
  _$BoundingBoxModelImpl instance,
) => <String, dynamic>{
  'left': instance.left,
  'top': instance.top,
  'width': instance.width,
  'height': instance.height,
};
