import 'package:flutter/foundation.dart';

/// Represents a detected object in the camera feed
@immutable
class Detection {
  /// Unique identifier for this detection
  final String id;

  /// Type of detection (road_sign, traffic_light, vehicle, etc.)
  final DetectionType type;

  /// Confidence score (0.0 to 1.0)
  final double confidence;

  /// Bounding box coordinates (normalized 0.0 to 1.0)
  final BoundingBox boundingBox;

  /// Timestamp when detection was made
  final DateTime timestamp;

  /// Additional metadata specific to detection type
  final Map<String, dynamic> metadata;

  const Detection({
    required this.id,
    required this.type,
    required this.confidence,
    required this.boundingBox,
    required this.timestamp,
    this.metadata = const {},
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is Detection && runtimeType == other.runtimeType && id == other.id && type == other.type && confidence == other.confidence && boundingBox == other.boundingBox && timestamp == other.timestamp && mapEquals(metadata, other.metadata);

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ confidence.hashCode ^ boundingBox.hashCode ^ timestamp.hashCode ^ metadata.hashCode;

  @override
  String toString() {
    return 'Detection{id: $id, type: $type, confidence: $confidence, boundingBox: $boundingBox, timestamp: $timestamp, metadata: $metadata}';
  }
}

/// Types of objects that can be detected
enum DetectionType {
  roadSign,
  trafficLight,
  vehicle,
  pedestrian,
  construction,
  other,
}

/// Represents a bounding box with normalized coordinates
@immutable
class BoundingBox {
  /// Left edge (0.0 to 1.0)
  final double left;

  /// Top edge (0.0 to 1.0)
  final double top;

  /// Width (0.0 to 1.0)
  final double width;

  /// Height (0.0 to 1.0)
  final double height;

  const BoundingBox({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  /// Right edge coordinate
  double get right => left + width;

  /// Bottom edge coordinate
  double get bottom => top + height;

  /// Center X coordinate
  double get centerX => left + (width / 2);

  /// Center Y coordinate
  double get centerY => top + (height / 2);

  @override
  bool operator ==(Object other) => identical(this, other) || other is BoundingBox && runtimeType == other.runtimeType && left == other.left && top == other.top && width == other.width && height == other.height;

  @override
  int get hashCode => left.hashCode ^ top.hashCode ^ width.hashCode ^ height.hashCode;

  @override
  String toString() {
    return 'BoundingBox{left: $left, top: $top, width: $width, height: $height}';
  }
}
