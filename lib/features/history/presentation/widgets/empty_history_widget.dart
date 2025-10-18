import 'package:flutter/material.dart';
import '../../../../shared/constants/app_theme.dart';

class EmptyHistoryWidget extends StatelessWidget {
  const EmptyHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.traffic,
                size: 50,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            Text(
              'No Road Signs Detected',
              style: AppTextStyles.h4.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              'Start using the camera to detect road signs.\nYour road sign detection history will appear here.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingL),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to camera
                // TODO: Implement navigation to camera
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Start Road Sign Detection'),
            ),
          ],
        ),
      ),
    );
  }
}
