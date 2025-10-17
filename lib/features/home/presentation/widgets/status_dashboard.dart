import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/constants/app_theme.dart';
import '../../../../shared/widgets/app_card.dart';

class StatusDashboard extends ConsumerWidget {
  const StatusDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('📊 System Status', style: AppTextStyles.h3),
        const SizedBox(height: AppDimensions.paddingM),
        Row(
          children: [
            Expanded(
              child: _buildStatusCard(title: 'Camera', status: 'Ready', icon: Icons.videocam, color: AppColors.success, isActive: true),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: _buildStatusCard(title: 'GPS', status: 'Ready', icon: Icons.location_on, color: AppColors.success, isActive: true),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingM),
        Row(
          children: [
            Expanded(
              child: _buildStatusCard(title: 'TTS', status: 'Ready', icon: Icons.record_voice_over, color: AppColors.success, isActive: true),
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: _buildStatusCard(title: 'AI Backend', status: 'Connecting...', icon: Icons.cloud, color: AppColors.warning, isActive: false),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingM),
        _buildPerformanceMetrics(),
      ],
    );
  }

  Widget _buildStatusCard({required String title, required String status, required IconData icon, required Color color, required bool isActive}) {
    return AppCard(
      child: Column(
        children: [
          Icon(icon, size: AppDimensions.iconL, color: color),
          const SizedBox(height: AppDimensions.paddingS),
          Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppDimensions.paddingXS),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS, vertical: AppDimensions.paddingXS),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(AppDimensions.radiusS)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(width: AppDimensions.paddingXS),
                Text(status, style: AppTextStyles.bodySmall.copyWith(color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('⚡ Performance Metrics', style: AppTextStyles.h4),
          const SizedBox(height: AppDimensions.paddingM),
          _buildMetricRow('Detection Accuracy', '${(AppConstants.targetAccuracy * 100).toInt()}%', AppColors.success, 0.85),
          const SizedBox(height: AppDimensions.paddingS),
          _buildMetricRow('Response Time', '${AppConstants.maxLatency}s', AppColors.info, 0.75),
          const SizedBox(height: AppDimensions.paddingS),
          _buildMetricRow('System Uptime', '${(AppConstants.targetUptime * 100).toInt()}%', AppColors.success, 0.99),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, Color color, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.bodyMedium),
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingXS),
        LinearProgressIndicator(value: progress, backgroundColor: color.withOpacity(0.2), valueColor: AlwaysStoppedAnimation<Color>(color)),
      ],
    );
  }
}
