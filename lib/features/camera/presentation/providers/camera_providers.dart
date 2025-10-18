import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/detection.dart';
import '../../domain/entities/road_sign.dart';
import '../../domain/repositories/camera_repository.dart';
import '../../data/repositories/camera_repository_impl.dart';
import '../../data/datasources/mock_detection_datasource.dart';

part 'camera_providers.freezed.dart';

// Data source provider
final mockDetectionDataSourceProvider = Provider<MockDetectionDataSource>((ref) {
  final dataSource = MockDetectionDataSource();
  ref.onDispose(() => dataSource.dispose());
  return dataSource;
});

// Repository provider
final cameraRepositoryProvider = Provider<CameraRepository>((ref) {
  return CameraRepositoryImpl(ref.read(mockDetectionDataSourceProvider));
});

// Camera state provider
final cameraStateProvider = StateNotifierProvider<CameraNotifier, CameraState>((ref) {
  return CameraNotifier(ref.read(cameraRepositoryProvider));
});

// Current detections provider
final currentDetectionsProvider = StateProvider<List<Detection>>((ref) => []);

// Camera permissions provider
final cameraPermissionProvider = FutureProvider<bool>((ref) async {
  final repository = ref.read(cameraRepositoryProvider);
  return await repository.hasCameraPermission();
});

// Predefined road signs provider
final roadSignsProvider = Provider<List<RoadSign>>((ref) {
  final repository = ref.read(cameraRepositoryProvider);
  return repository.getPredefinedRoadSigns();
});

// Camera state management
@freezed
class CameraState with _$CameraState {
  const factory CameraState.initial() = _Initial;
  const factory CameraState.initializing() = _Initializing;
  const factory CameraState.ready() = _Ready;
  const factory CameraState.detecting() = _Detecting;
  const factory CameraState.error(String message) = _Error;
  const factory CameraState.permissionDenied() = _PermissionDenied;
}

class CameraNotifier extends StateNotifier<CameraState> {
  final CameraRepository _repository;

  CameraNotifier(this._repository) : super(const CameraState.initial());

  /// Initialize camera with permission checks
  Future<void> initializeCamera() async {
    state = const CameraState.initializing();

    try {
      // Check permissions first
      bool hasPermission = await _repository.hasCameraPermission();

      if (!hasPermission) {
        hasPermission = await _repository.requestCameraPermission();

        if (!hasPermission) {
          state = const CameraState.permissionDenied();
          return;
        }
      }

      // Initialize camera
      await _repository.initializeCamera();
      state = const CameraState.ready();
    } catch (e) {
      state = CameraState.error('Failed to initialize camera: ${e.toString()}');
    }
  }

  /// Start detection analysis
  Future<void> startDetection(WidgetRef ref) async {
    if (state != const CameraState.ready()) {
      return;
    }

    state = const CameraState.detecting();

    try {
      final detectionStream = _repository.startDetection();

      detectionStream.listen(
        (detections) {
          // Update current detections
          ref.read(currentDetectionsProvider.notifier).state = detections;
        },
        onError: (error) {
          state = CameraState.error('Detection error: ${error.toString()}');
        },
      );
    } catch (e) {
      state = CameraState.error('Failed to start detection: ${e.toString()}');
    }
  }

  /// Stop detection analysis
  Future<void> stopDetection(WidgetRef ref) async {
    try {
      await _repository.stopDetection();
      ref.read(currentDetectionsProvider.notifier).state = [];

      if (state == const CameraState.detecting()) {
        state = const CameraState.ready();
      }
    } catch (e) {
      state = CameraState.error('Failed to stop detection: ${e.toString()}');
    }
  }

  /// Dispose camera resources
  Future<void> disposeCamera() async {
    try {
      await _repository.disposeCamera();
      state = const CameraState.initial();
    } catch (e) {
      state = CameraState.error('Failed to dispose camera: ${e.toString()}');
    }
  }

  /// Request camera permission
  Future<void> requestPermission() async {
    try {
      final granted = await _repository.requestCameraPermission();

      if (granted) {
        await initializeCamera();
      } else {
        state = const CameraState.permissionDenied();
      }
    } catch (e) {
      state = CameraState.error('Permission request failed: ${e.toString()}');
    }
  }

  /// Reset camera state
  void reset() {
    state = const CameraState.initial();
  }
}
