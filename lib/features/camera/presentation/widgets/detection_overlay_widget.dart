import 'package:flutter/material.dart';
import '../../domain/entities/detection.dart';

/// Widget that displays detection overlays on the camera feed
class DetectionOverlayWidget extends StatelessWidget {
  final List<Detection> detections;
  final Function(Detection)? onDetectionTap;

  const DetectionOverlayWidget({
    super.key,
    required this.detections,
    this.onDetectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: detections.map((detection) {
        return _buildDetectionOverlay(context, detection);
      }).toList(),
    );
  }

  Widget _buildDetectionOverlay(BuildContext context, Detection detection) {
    final screenSize = MediaQuery.of(context).size;
    final boundingBox = detection.boundingBox;

    // Convert normalized coordinates to screen coordinates
    final left = boundingBox.left * screenSize.width;
    final top = boundingBox.top * screenSize.height;
    final width = boundingBox.width * screenSize.width;
    final height = boundingBox.height * screenSize.height;

    // Get road sign information from metadata
    final roadSignType = detection.metadata['road_sign_type'] as String?;
    final isUrgent = detection.metadata['is_urgent'] as bool? ?? false;
    final priority = detection.metadata['priority'] as int? ?? 1;

    // Determine colors based on urgency and confidence
    final borderColor = _getBorderColor(isUrgent, priority, detection.confidence);
    final backgroundColor = borderColor.withOpacity(0.2);

    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () => onDetectionTap?.call(detection),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          child: Stack(
            children: [
              // Confidence indicator
              Positioned(
                top: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(detection.confidence * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Detection label
              if (roadSignType != null)
                Positioned(
                  bottom: 4,
                  left: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _formatRoadSignType(roadSignType),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

              // Urgency indicator
              if (isUrgent)
                const Positioned(
                  top: 4,
                  left: 4,
                  child: Icon(
                    Icons.warning,
                    color: Colors.orange,
                    size: 16,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBorderColor(bool isUrgent, int priority, double confidence) {
    if (isUrgent || priority >= 4) {
      return Colors.red;
    } else if (priority >= 2) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String _formatRoadSignType(String roadSignType) {
    // Convert snake_case to display format
    return roadSignType.replaceAll('_', ' ').split(' ').map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : word).join(' ');
  }
}
