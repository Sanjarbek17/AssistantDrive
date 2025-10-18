import '../entities/detection.dart';
import '../entities/road_sign.dart';

/// Repository interface for camera-related operations
abstract class CameraRepository {
  /// Initialize the camera with specified settings
  Future<void> initializeCamera();

  /// Dispose camera resources
  Future<void> disposeCamera();

  /// Start real-time detection analysis
  Stream<List<Detection>> startDetection();

  /// Stop detection analysis
  Future<void> stopDetection();

  /// Get list of predefined road signs that can be detected
  List<RoadSign> getPredefinedRoadSigns();

  /// Get road sign information by type
  RoadSign? getRoadSignByType(RoadSignType type);

  /// Check if camera permissions are granted
  Future<bool> hasCameraPermission();

  /// Request camera permissions
  Future<bool> requestCameraPermission();
}
