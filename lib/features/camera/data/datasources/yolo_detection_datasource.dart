import 'dart:async';
import 'package:camera/camera.dart';

import '../../domain/entities/detection.dart';
import '../../../../shared/services/yolo_detection_service.dart';

/// Real-time YOLO-based detection data source
class YoloDetectionDataSource {
  final YoloDetectionService _yoloService;
  StreamController<List<Detection>>? _streamController;
  StreamController<CameraImage>? _frameController;
  StreamSubscription<CameraImage>? _frameSubscription;
  bool _isProcessing = false;

  YoloDetectionDataSource(this._yoloService);

  /// Initialize YOLO model
  Future<bool> initialize() async {
    print('🚀 Initializing YOLO detection datasource...');
    final success = await _yoloService.initializeModel();
    if (success) {
      print('✅ YOLO detection datasource initialized');
    } else {
      print('❌ Failed to initialize YOLO detection datasource');
    }
    return success;
  }

  /// Start real-time detection from camera frames
  Stream<List<Detection>> startDetection() {
    if (_streamController != null) {
      _streamController!.close();
    }

    _streamController = StreamController<List<Detection>>.broadcast();
    _frameController = StreamController<CameraImage>();

    // Process camera frames for detection
    _frameSubscription = _frameController!.stream.listen(_processFrame);

    print('🎯 Started YOLO real-time detection');
    return _streamController!.stream;
  }

  /// Process individual camera frame
  Future<void> _processFrame(CameraImage frame) async {
    if (_isProcessing || !_yoloService.isReady) return;

    _isProcessing = true;

    try {
      // Run YOLO inference on the frame
      final detections = await _yoloService.detectObjects(frame);

      // Emit detections to stream
      if (_streamController != null && !_streamController!.isClosed) {
        _streamController!.add(detections);

        if (detections.isNotEmpty) {
          print('🎯 Detected ${detections.length} objects: ${detections.map((d) => d.metadata['yolo_class_name']).join(', ')}');
        }
      }
    } catch (e) {
      print('❌ Error processing camera frame: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// Add camera frame for processing
  void addFrame(CameraImage frame) {
    if (_frameController != null && !_frameController!.isClosed) {
      _frameController!.add(frame);
    }
  }

  /// Stop detection
  Future<void> stopDetection() async {
    print('🛑 Stopping YOLO detection...');

    await _frameSubscription?.cancel();
    _frameSubscription = null;

    await _frameController?.close();
    _frameController = null;

    _isProcessing = false;

    print('✅ YOLO detection stopped');
  }

  /// Dispose resources
  void dispose() {
    print('🗑️ Disposing YOLO detection datasource...');

    stopDetection();
    _streamController?.close();
    _streamController = null;
    _yoloService.dispose();

    print('✅ YOLO detection datasource disposed');
  }

  /// Check if YOLO service is ready
  bool get isReady => _yoloService.isReady;

  /// Get processing status
  bool get isProcessing => _isProcessing;
}
