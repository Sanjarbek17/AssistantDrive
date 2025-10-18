import 'package:flutter/foundation.dart';

/// Represents a detected road sign with specific information
@immutable
class RoadSign {
  /// Unique identifier for this road sign
  final String id;

  /// Type of road sign
  final RoadSignType type;

  /// Display name for the road sign
  final String name;

  /// Description of what the sign means
  final String description;

  /// Audio key for voice announcement (matches AudioService keys)
  final String audioKey;

  /// Priority level for alerts (1-5, 5 being highest)
  final int priority;

  /// Color associated with the sign type
  final RoadSignColor color;

  /// Whether this sign requires immediate attention
  final bool isUrgent;

  const RoadSign({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.audioKey,
    required this.priority,
    required this.color,
    this.isUrgent = false,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is RoadSign && runtimeType == other.runtimeType && id == other.id && type == other.type && name == other.name && description == other.description && audioKey == other.audioKey && priority == other.priority && color == other.color && isUrgent == other.isUrgent;

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ name.hashCode ^ description.hashCode ^ audioKey.hashCode ^ priority.hashCode ^ color.hashCode ^ isUrgent.hashCode;

  @override
  String toString() {
    return 'RoadSign{id: $id, type: $type, name: $name, description: $description, audioKey: $audioKey, priority: $priority, color: $color, isUrgent: $isUrgent}';
  }
}

/// Types of road signs that can be detected
enum RoadSignType {
  stop,
  yield,
  speedLimit,
  noParking,
  noStopping,
  noEntry,
  schoolZone,
  constructionZone,
  pedestrianCrossing,
  trafficLight,
}

/// Colors associated with road sign types
enum RoadSignColor {
  red,
  yellow,
  green,
  blue,
  orange,
  white,
  black,
}

/// Extension to get display properties for road sign types
extension RoadSignTypeExtension on RoadSignType {
  String get displayName {
    switch (this) {
      case RoadSignType.stop:
        return 'Stop Sign';
      case RoadSignType.yield:
        return 'Yield Sign';
      case RoadSignType.speedLimit:
        return 'Speed Limit';
      case RoadSignType.noParking:
        return 'No Parking';
      case RoadSignType.noStopping:
        return 'No Stopping';
      case RoadSignType.noEntry:
        return 'No Entry';
      case RoadSignType.schoolZone:
        return 'School Zone';
      case RoadSignType.constructionZone:
        return 'Construction Zone';
      case RoadSignType.pedestrianCrossing:
        return 'Pedestrian Crossing';
      case RoadSignType.trafficLight:
        return 'Traffic Light';
    }
  }

  String get audioKey {
    switch (this) {
      case RoadSignType.stop:
        return 'stop_sign';
      case RoadSignType.yield:
        return 'yield_ahead';
      case RoadSignType.speedLimit:
        return 'speed_limit';
      case RoadSignType.noParking:
        return 'no_parking';
      case RoadSignType.noStopping:
        return 'no_stopping';
      case RoadSignType.noEntry:
        return 'no_entry';
      case RoadSignType.schoolZone:
        return 'school_zone';
      case RoadSignType.constructionZone:
        return 'construction_zone';
      case RoadSignType.pedestrianCrossing:
        return 'pedestrian_crossing';
      case RoadSignType.trafficLight:
        return 'traffic_light_ahead';
    }
  }

  RoadSignColor get primaryColor {
    switch (this) {
      case RoadSignType.stop:
      case RoadSignType.noEntry:
        return RoadSignColor.red;
      case RoadSignType.yield:
      case RoadSignType.speedLimit:
      case RoadSignType.schoolZone:
        return RoadSignColor.yellow;
      case RoadSignType.noParking:
      case RoadSignType.noStopping:
        return RoadSignColor.white;
      case RoadSignType.constructionZone:
        return RoadSignColor.orange;
      case RoadSignType.pedestrianCrossing:
        return RoadSignColor.yellow;
      case RoadSignType.trafficLight:
        return RoadSignColor.green;
    }
  }

  int get defaultPriority {
    switch (this) {
      case RoadSignType.stop:
      case RoadSignType.noEntry:
        return 5; // Highest priority
      case RoadSignType.yield:
      case RoadSignType.trafficLight:
        return 4;
      case RoadSignType.schoolZone:
      case RoadSignType.constructionZone:
      case RoadSignType.pedestrianCrossing:
        return 3;
      case RoadSignType.speedLimit:
        return 2;
      case RoadSignType.noParking:
      case RoadSignType.noStopping:
        return 1; // Lowest priority
    }
  }

  bool get isUrgentByDefault {
    switch (this) {
      case RoadSignType.stop:
      case RoadSignType.yield:
      case RoadSignType.noEntry:
      case RoadSignType.schoolZone:
      case RoadSignType.constructionZone:
      case RoadSignType.pedestrianCrossing:
      case RoadSignType.trafficLight:
        return true;
      case RoadSignType.speedLimit:
      case RoadSignType.noParking:
      case RoadSignType.noStopping:
        return false;
    }
  }
}
