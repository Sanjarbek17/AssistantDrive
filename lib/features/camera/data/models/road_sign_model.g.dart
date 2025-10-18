// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'road_sign_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoadSignModelImpl _$$RoadSignModelImplFromJson(Map<String, dynamic> json) =>
    _$RoadSignModelImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      audioKey: json['audioKey'] as String,
      priority: (json['priority'] as num).toInt(),
      color: json['color'] as String,
      isUrgent: json['isUrgent'] as bool? ?? false,
    );

Map<String, dynamic> _$$RoadSignModelImplToJson(_$RoadSignModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'audioKey': instance.audioKey,
      'priority': instance.priority,
      'color': instance.color,
      'isUrgent': instance.isUrgent,
    };
