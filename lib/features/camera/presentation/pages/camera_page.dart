import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';

import '../providers/camera_providers.dart';
import '../widgets/camera_view_widget.dart';
import '../widgets/detection_overlay_widget.dart';
import '../widgets/analysis_status_widget.dart';
import '../../../../shared/services/audio_service.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  final AudioService _audioService = AudioService();
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    // Initialize camera controller
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _cameraController = CameraController(
          cameras[0], // Use the first available camera
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController.initialize();

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });

          // Initialize camera state
          await ref.read(cameraStateProvider.notifier).initializeCamera();

          // Start camera stream for YOLO processing
          _startCameraStream();
        }
      }
    } catch (e) {
      print('Error initializing camera: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera initialization failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// Start camera stream for YOLO processing
  void _startCameraStream() {
    if (!_isCameraInitialized) return;

    try {
      _cameraController.startImageStream((CameraImage image) {
        // Pass camera frames to YOLO detection service
        final yoloDataSource = ref.read(yoloDetectionDataSourceProvider);
        yoloDataSource.addFrame(image);
      });

      print('📹 Camera stream started for YOLO processing');
    } catch (e) {
      print('❌ Error starting camera stream: $e');
    }
  }

  /// Stop camera stream
  void _stopCameraStream() {
    try {
      _cameraController.stopImageStream();
      print('⏹️ Camera stream stopped');
    } catch (e) {
      print('❌ Error stopping camera stream: $e');
    }
  }

  void _toggleDetection() {
    final cameraState = ref.read(cameraStateProvider);
    final notifier = ref.read(cameraStateProvider.notifier);

    cameraState.when(
      initial: () => notifier.initializeCamera(),
      initializing: () {},
      ready: () => notifier.startDetection(ref),
      detecting: () => notifier.stopDetection(ref),
      error: (message) => notifier.reset(),
      permissionDenied: () => notifier.requestPermission(),
    );
  }

  void _showDetectionSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Detection Settings',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final roadSigns = ref.watch(roadSignsProvider);

                  return ListView.builder(
                    itemCount: roadSigns.length,
                    itemBuilder: (context, index) {
                      final sign = roadSigns[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getColorFromEnum(sign.color),
                            child: Icon(
                              _getIconFromType(sign.type),
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          title: Text(sign.name),
                          subtitle: Text(sign.description),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (sign.isUrgent) const Icon(Icons.warning, color: Colors.orange, size: 16),
                              IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () => _audioService.playAudio(sign.audioKey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColorFromEnum(color) {
    switch (color.toString().split('.').last) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.amber;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'white':
        return Colors.grey.shade300;
      case 'black':
        return Colors.black;
      default:
        return Colors.grey;
    }
  }

  IconData _getIconFromType(type) {
    switch (type.toString().split('.').last) {
      case 'stop':
        return Icons.stop;
      case 'yield':
        return Icons.warning;
      case 'speedLimit':
        return Icons.speed;
      case 'noParking':
        return Icons.local_parking;
      case 'noStopping':
        return Icons.do_not_step;
      case 'noEntry':
        return Icons.do_not_disturb;
      case 'schoolZone':
        return Icons.school;
      case 'constructionZone':
        return Icons.construction;
      case 'pedestrianCrossing':
        return Icons.directions_walk;
      case 'trafficLight':
        return Icons.traffic;
      default:
        return Icons.traffic;
    }
  }

  @override
  void dispose() {
    _stopCameraStream();
    _cameraController.dispose();
    ref.read(cameraStateProvider.notifier).disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraStateProvider);
    final detections = ref.watch(currentDetectionsProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
        foregroundColor: Colors.white,
        title: const Text(
          'Camera Detection',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _showDetectionSettings,
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera view
          if (_isCameraInitialized)
            CameraViewWidget(cameraController: _cameraController)
          else
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          // Detection overlays
          if (detections.isNotEmpty)
            DetectionOverlayWidget(
              detections: detections,
              onDetectionTap: (detection) {
                // Play audio for detected road sign
                final audioKey = detection.metadata['audio_key'] as String?;
                if (audioKey != null) {
                  _audioService.playAudio(audioKey);
                }
              },
            ),

          // Analysis status
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: AnalysisStatusWidget(
              cameraState: cameraState,
              detectionCount: detections.length,
            ),
          ),

          // Control buttons
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Voice recording button (future feature)
                FloatingActionButton(
                  onPressed: () {
                    // Future: Voice command feature
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Voice commands coming soon!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.mic, color: Colors.white),
                ),

                // Main detection toggle button
                GestureDetector(
                  onTap: _toggleDetection,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cameraState.when(
                        initial: () => Colors.grey,
                        initializing: () => Colors.orange,
                        ready: () => Colors.green,
                        detecting: () => Colors.red,
                        error: (message) => Colors.red,
                        permissionDenied: () => Colors.orange,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      cameraState.when(
                        initial: () => Icons.camera_alt,
                        initializing: () => Icons.hourglass_empty,
                        ready: () => Icons.play_arrow,
                        detecting: () => Icons.stop,
                        error: (message) => Icons.refresh,
                        permissionDenied: () => Icons.security,
                      ),
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),

                // Map button (future feature)
                FloatingActionButton(
                  onPressed: () {
                    // Future: Show mini map
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Map view coming soon!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
