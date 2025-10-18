import 'dart:async';
import 'dart:math';

import '../../domain/entities/detection.dart';
import '../../domain/entities/road_sign.dart';

/// Mock data source for generating fake detection data for testing and demo
class MockDetectionDataSource {
  final Random _random = Random();
  Timer? _detectionTimer;
  StreamController<List<Detection>>? _streamController;

  /// Creates a stream of mock detections that simulates real-time road sign detection
  Stream<List<Detection>> getMockDetectionStream() {
    _streamController?.close();
    _streamController = StreamController<List<Detection>>.broadcast();

    // Generate detections every 2-4 seconds
    _detectionTimer = Timer.periodic(
      Duration(seconds: 2 + _random.nextInt(3)),
      (timer) {
        final detections = _generateRandomDetections();
        _streamController?.add(detections);
      },
    );

    return _streamController!.stream;
  }

  /// Stop the mock detection stream
  void stopMockDetections() {
    _detectionTimer?.cancel();
    _detectionTimer = null;
    _streamController?.close();
    _streamController = null;
  }

  /// Generate random detection data for testing
  List<Detection> _generateRandomDetections() {
    final detections = <Detection>[];

    // Randomly generate 0-3 detections
    final count = _random.nextInt(4);

    for (int i = 0; i < count; i++) {
      detections.add(_createRandomDetection());
    }

    return detections;
  }

  /// Create a single random detection
  Detection _createRandomDetection() {
    final roadSignTypes = RoadSignType.values;
    final randomType = roadSignTypes[_random.nextInt(roadSignTypes.length)];

    return Detection(
      id: 'detection_${DateTime.now().millisecondsSinceEpoch}_${_random.nextInt(1000)}',
      type: DetectionType.roadSign,
      confidence: 0.7 + (_random.nextDouble() * 0.3), // 70-100% confidence
      boundingBox: _generateRandomBoundingBox(),
      timestamp: DateTime.now(),
      metadata: {
        'road_sign_type': randomType.name,
        'audio_key': randomType.audioKey,
        'priority': randomType.defaultPriority,
        'is_urgent': randomType.isUrgentByDefault,
      },
    );
  }

  /// Generate random bounding box coordinates
  BoundingBox _generateRandomBoundingBox() {
    // Generate realistic bounding box positions
    // Keep boxes within reasonable camera view bounds
    final left = 0.1 + (_random.nextDouble() * 0.6); // 10-70% from left
    final top = 0.2 + (_random.nextDouble() * 0.4); // 20-60% from top
    final width = 0.15 + (_random.nextDouble() * 0.2); // 15-35% width
    final height = 0.1 + (_random.nextDouble() * 0.15); // 10-25% height

    return BoundingBox(
      left: left,
      top: top,
      width: width,
      height: height,
    );
  }

  /// Get specific mock detection for testing
  Detection createMockDetection({
    required RoadSignType roadSignType,
    double? confidence,
    BoundingBox? boundingBox,
  }) {
    return Detection(
      id: 'mock_${roadSignType.name}_${DateTime.now().millisecondsSinceEpoch}',
      type: DetectionType.roadSign,
      confidence: confidence ?? 0.85,
      boundingBox: boundingBox ?? _generateRandomBoundingBox(),
      timestamp: DateTime.now(),
      metadata: {
        'road_sign_type': roadSignType.name,
        'audio_key': roadSignType.audioKey,
        'priority': roadSignType.defaultPriority,
        'is_urgent': roadSignType.isUrgentByDefault,
      },
    );
  }

  /// Create a list of test detections for specific scenarios
  List<Detection> createTestScenario(String scenario) {
    switch (scenario) {
      case 'school_zone':
        return [
          createMockDetection(roadSignType: RoadSignType.schoolZone),
          createMockDetection(roadSignType: RoadSignType.speedLimit),
        ];

      case 'intersection':
        return [
          createMockDetection(roadSignType: RoadSignType.stop),
          createMockDetection(roadSignType: RoadSignType.trafficLight),
        ];

      case 'construction':
        return [
          createMockDetection(roadSignType: RoadSignType.constructionZone),
          createMockDetection(roadSignType: RoadSignType.speedLimit),
        ];

      case 'parking':
        return [
          createMockDetection(roadSignType: RoadSignType.noParking),
        ];

      default:
        return _generateRandomDetections();
    }
  }

  /// Dispose resources
  void dispose() {
    stopMockDetections();
  }
}
