import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

/// Widget that displays the live camera feed
class CameraViewWidget extends StatelessWidget {
  final CameraController cameraController;

  const CameraViewWidget({
    super.key,
    required this.cameraController,
  });

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: cameraController.value.previewSize!.height,
          height: cameraController.value.previewSize!.width,
          child: CameraPreview(cameraController),
        ),
      ),
    );
  }
}
