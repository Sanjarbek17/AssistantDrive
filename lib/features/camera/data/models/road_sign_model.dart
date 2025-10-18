import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/road_sign.dart';

part 'road_sign_model.freezed.dart';
part 'road_sign_model.g.dart';

@freezed
class RoadSignModel with _$RoadSignModel {
  const factory RoadSignModel({
    required String id,
    required String type,
    required String name,
    required String description,
    required String audioKey,
    required int priority,
    required String color,
    @Default(false) bool isUrgent,
  }) = _RoadSignModel;

  factory RoadSignModel.fromJson(Map<String, dynamic> json) => _$RoadSignModelFromJson(json);
}

extension RoadSignModelX on RoadSignModel {
  RoadSign toEntity() {
    return RoadSign(
      id: id,
      type: _parseRoadSignType(type),
      name: name,
      description: description,
      audioKey: audioKey,
      priority: priority,
      color: _parseRoadSignColor(color),
      isUrgent: isUrgent,
    );
  }

  RoadSignType _parseRoadSignType(String type) {
    switch (type.toLowerCase()) {
      case 'stop':
        return RoadSignType.stop;
      case 'yield':
        return RoadSignType.yield;
      case 'speed_limit':
        return RoadSignType.speedLimit;
      case 'no_parking':
        return RoadSignType.noParking;
      case 'no_stopping':
        return RoadSignType.noStopping;
      case 'no_entry':
        return RoadSignType.noEntry;
      case 'school_zone':
        return RoadSignType.schoolZone;
      case 'construction_zone':
        return RoadSignType.constructionZone;
      case 'pedestrian_crossing':
        return RoadSignType.pedestrianCrossing;
      case 'traffic_light':
        return RoadSignType.trafficLight;
      default:
        return RoadSignType.stop;
    }
  }

  RoadSignColor _parseRoadSignColor(String color) {
    switch (color.toLowerCase()) {
      case 'red':
        return RoadSignColor.red;
      case 'yellow':
        return RoadSignColor.yellow;
      case 'green':
        return RoadSignColor.green;
      case 'blue':
        return RoadSignColor.blue;
      case 'orange':
        return RoadSignColor.orange;
      case 'white':
        return RoadSignColor.white;
      case 'black':
        return RoadSignColor.black;
      default:
        return RoadSignColor.white;
    }
  }
}

extension RoadSignX on RoadSign {
  RoadSignModel toModel() {
    return RoadSignModel(
      id: id,
      type: type.name,
      name: name,
      description: description,
      audioKey: audioKey,
      priority: priority,
      color: color.name,
      isUrgent: isUrgent,
    );
  }
}
