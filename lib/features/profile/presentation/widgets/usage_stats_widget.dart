import 'package:flutter/material.dart';
import '../../../../shared/constants/app_theme.dart';

class UsageStatsWidget extends StatelessWidget {
  const UsageStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Usage Statistics',
              style: AppTextStyles.h4.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'This Week',
                    '24',
                    'objects detected',
                    Icons.trending_up,
                    AppColors.success,
                    '+15%',
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Expanded(
                  child: _buildStatCard(
                    'This Month',
                    '156',
                    'total detections',
                    Icons.visibility,
                    AppColors.info,
                    '+8%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Average',
                    '3.2',
                    'sessions per day',
                    Icons.access_time,
                    AppColors.warning,
                    '+5%',
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Expanded(
                  child: _buildStatCard(
                    'Best Day',
                    '12',
                    'objects in one day',
                    Icons.emoji_events,
                    AppColors.primary,
                    'Yesterday',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
    String trend,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  trend,
                  style: AppTextStyles.caption.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
