import 'dart:async';
import 'dart:math';

import '../../domain/entities/detection.dart';
import '../../domain/entities/road_sign.dart';
import '../../domain/repositories/camera_repository.dart';
import '../datasources/mock_detection_datasource.dart';

/// Implementation of CameraRepository with mock detection capabilities
class CameraRepositoryImpl implements CameraRepository {
  final MockDetectionDataSource _detectionDataSource;
  StreamSubscription<List<Detection>>? _detectionSubscription;
  StreamController<List<Detection>>? _detectionController;

  CameraRepositoryImpl(this._detectionDataSource);

  @override
  Future<void> initializeCamera() async {
    // Simulate camera initialization delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real implementation, this would initialize the camera
    print('Camera initialized successfully');
  }

  @override
  Future<void> disposeCamera() async {
    await stopDetection();
    _detectionController?.close();
    _detectionController = null;

    print('Camera disposed successfully');
  }

  @override
  Stream<List<Detection>> startDetection() {
    _detectionController?.close();
    _detectionController = StreamController<List<Detection>>.broadcast();

    // Start mock detection stream
    _detectionSubscription = _detectionDataSource.getMockDetectionStream().listen((detections) {
      _detectionController?.add(detections);
    });

    return _detectionController!.stream;
  }

  @override
  Future<void> stopDetection() async {
    await _detectionSubscription?.cancel();
    _detectionSubscription = null;
  }

  @override
  List<RoadSign> getPredefinedRoadSigns() {
    return [
      RoadSign(
        id: 'stop_001',
        type: RoadSignType.stop,
        name: RoadSignType.stop.displayName,
        description: 'Come to a complete stop',
        audioKey: RoadSignType.stop.audioKey,
        priority: RoadSignType.stop.defaultPriority,
        color: RoadSignType.stop.primaryColor,
        isUrgent: RoadSignType.stop.isUrgentByDefault,
      ),
      RoadSign(
        id: 'yield_001',
        type: RoadSignType.yield,
        name: RoadSignType.yield.displayName,
        description: 'Give way to other traffic',
        audioKey: RoadSignType.yield.audioKey,
        priority: RoadSignType.yield.defaultPriority,
        color: RoadSignType.yield.primaryColor,
        isUrgent: RoadSignType.yield.isUrgentByDefault,
      ),
      RoadSign(
        id: 'speed_limit_001',
        type: RoadSignType.speedLimit,
        name: RoadSignType.speedLimit.displayName,
        description: 'Adjust your speed accordingly',
        audioKey: RoadSignType.speedLimit.audioKey,
        priority: RoadSignType.speedLimit.defaultPriority,
        color: RoadSignType.speedLimit.primaryColor,
        isUrgent: RoadSignType.speedLimit.isUrgentByDefault,
      ),
      RoadSign(
        id: 'no_parking_001',
        type: RoadSignType.noParking,
        name: RoadSignType.noParking.displayName,
        description: 'No parking allowed in this area',
        audioKey: RoadSignType.noParking.audioKey,
        priority: RoadSignType.noParking.defaultPriority,
        color: RoadSignType.noParking.primaryColor,
        isUrgent: RoadSignType.noParking.isUrgentByDefault,
      ),
      RoadSign(
        id: 'school_zone_001',
        type: RoadSignType.schoolZone,
        name: RoadSignType.schoolZone.displayName,
        description: 'Reduce speed, watch for children',
        audioKey: RoadSignType.schoolZone.audioKey,
        priority: RoadSignType.schoolZone.defaultPriority,
        color: RoadSignType.schoolZone.primaryColor,
        isUrgent: RoadSignType.schoolZone.isUrgentByDefault,
      ),
      RoadSign(
        id: 'construction_001',
        type: RoadSignType.constructionZone,
        name: RoadSignType.constructionZone.displayName,
        description: 'Construction ahead, be cautious',
        audioKey: RoadSignType.constructionZone.audioKey,
        priority: RoadSignType.constructionZone.defaultPriority,
        color: RoadSignType.constructionZone.primaryColor,
        isUrgent: RoadSignType.constructionZone.isUrgentByDefault,
      ),
      RoadSign(
        id: 'pedestrian_001',
        type: RoadSignType.pedestrianCrossing,
        name: RoadSignType.pedestrianCrossing.displayName,
        description: 'Pedestrian crossing ahead',
        audioKey: RoadSignType.pedestrianCrossing.audioKey,
        priority: RoadSignType.pedestrianCrossing.defaultPriority,
        color: RoadSignType.pedestrianCrossing.primaryColor,
        isUrgent: RoadSignType.pedestrianCrossing.isUrgentByDefault,
      ),
      RoadSign(
        id: 'traffic_light_001',
        type: RoadSignType.trafficLight,
        name: RoadSignType.trafficLight.displayName,
        description: 'Traffic light ahead',
        audioKey: RoadSignType.trafficLight.audioKey,
        priority: RoadSignType.trafficLight.defaultPriority,
        color: RoadSignType.trafficLight.primaryColor,
        isUrgent: RoadSignType.trafficLight.isUrgentByDefault,
      ),
    ];
  }

  @override
  RoadSign? getRoadSignByType(RoadSignType type) {
    try {
      return getPredefinedRoadSigns().firstWhere(
        (sign) => sign.type == type,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> hasCameraPermission() async {
    // Simulate permission check
    await Future.delayed(const Duration(milliseconds: 100));

    // In a real implementation, this would check actual camera permissions
    // For now, we'll randomly return true most of the time for demo purposes
    return Random().nextBool() || Random().nextBool();
  }

  @override
  Future<bool> requestCameraPermission() async {
    // Simulate permission request delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real implementation, this would request actual camera permissions
    // For demo purposes, we'll assume permission is granted
    return true;
  }
}
