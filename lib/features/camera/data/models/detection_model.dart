import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/detection.dart';

part 'detection_model.freezed.dart';
part 'detection_model.g.dart';

@freezed
class DetectionModel with _$DetectionModel {
  const factory DetectionModel({
    required String id,
    required String type,
    required double confidence,
    required BoundingBoxModel boundingBox,
    required DateTime timestamp,
    @Default({}) Map<String, dynamic> metadata,
  }) = _DetectionModel;

  factory DetectionModel.fromJson(Map<String, dynamic> json) => _$DetectionModelFromJson(json);
}

@freezed
class BoundingBoxModel with _$BoundingBoxModel {
  const factory BoundingBoxModel({
    required double left,
    required double top,
    required double width,
    required double height,
  }) = _BoundingBoxModel;

  factory BoundingBoxModel.fromJson(Map<String, dynamic> json) => _$BoundingBoxModelFromJson(json);
}

extension DetectionModelX on DetectionModel {
  Detection toEntity() {
    return Detection(
      id: id,
      type: _parseDetectionType(type),
      confidence: confidence,
      boundingBox: boundingBox.toEntity(),
      timestamp: timestamp,
      metadata: metadata,
    );
  }

  DetectionType _parseDetectionType(String type) {
    switch (type.toLowerCase()) {
      case 'road_sign':
        return DetectionType.roadSign;
      case 'traffic_light':
        return DetectionType.trafficLight;
      case 'vehicle':
        return DetectionType.vehicle;
      case 'pedestrian':
        return DetectionType.pedestrian;
      case 'construction':
        return DetectionType.construction;
      default:
        return DetectionType.other;
    }
  }
}

extension BoundingBoxModelX on BoundingBoxModel {
  BoundingBox toEntity() {
    return BoundingBox(
      left: left,
      top: top,
      width: width,
      height: height,
    );
  }
}

extension DetectionX on Detection {
  DetectionModel toModel() {
    return DetectionModel(
      id: id,
      type: type.name,
      confidence: confidence,
      boundingBox: boundingBox.toModel(),
      timestamp: timestamp,
      metadata: metadata,
    );
  }
}

extension BoundingBoxX on BoundingBox {
  BoundingBoxModel toModel() {
    return BoundingBoxModel(
      left: left,
      top: top,
      width: width,
      height: height,
    );
  }
}
