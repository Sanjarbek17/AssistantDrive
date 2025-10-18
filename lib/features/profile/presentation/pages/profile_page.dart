import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/app_theme.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/achievement_card_widget.dart';
import '../widgets/usage_stats_widget.dart';
import '../widgets/quick_actions_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTextStyles.h3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => _showEditProfileDialog(context),
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            const ProfileHeaderWidget(),

            const SizedBox(height: AppDimensions.paddingL),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
              child: QuickActionsWidget(),
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Usage Statistics
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
              child: UsageStatsWidget(),
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Achievements Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Achievements',
                        style: AppTextStyles.h4.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        onPressed: () => _showAllAchievements(context),
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _getAchievements().length,
                      separatorBuilder: (context, index) => const SizedBox(width: AppDimensions.paddingM),
                      itemBuilder: (context, index) {
                        final achievement = _getAchievements()[index];
                        return AchievementCardWidget(
                          title: achievement['title'] as String,
                          description: achievement['description'] as String,
                          icon: achievement['icon'] as IconData,
                          isUnlocked: achievement['isUnlocked'] as bool,
                          progress: achievement['progress'] as double,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Recent Activity
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: AppTextStyles.h4.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingM),
                  Card(
                    child: Column(
                      children: [
                        _buildActivityItem(
                          'Detected 15 objects in 3 sessions',
                          'Today',
                          Icons.camera_alt_outlined,
                          AppColors.primary,
                        ),
                        const Divider(height: 1),
                        _buildActivityItem(
                          'Completed First Week achievement',
                          'Yesterday',
                          Icons.emoji_events_outlined,
                          AppColors.warning,
                        ),
                        const Divider(height: 1),
                        _buildActivityItem(
                          'Updated accessibility preferences',
                          '2 days ago',
                          Icons.settings_outlined,
                          AppColors.info,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingXL),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getAchievements() {
    return [
      {
        'title': 'First Detection',
        'description': 'Detected your first object',
        'icon': Icons.visibility,
        'isUnlocked': true,
        'progress': 1.0,
      },
      {
        'title': 'Early Bird',
        'description': 'Used the app for 7 consecutive days',
        'icon': Icons.schedule,
        'isUnlocked': true,
        'progress': 1.0,
      },
      {
        'title': 'Explorer',
        'description': 'Detected 100 different objects',
        'icon': Icons.explore,
        'isUnlocked': false,
        'progress': 0.47,
      },
      {
        'title': 'Precision Master',
        'description': 'Achieved 95% detection accuracy',
        'icon': Icons.verified,
        'isUnlocked': false,
        'progress': 0.94,
      },
    ];
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        time,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
        size: 20,
      ),
      onTap: () {
        // TODO: Show activity details
      },
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Implement photo selection
              },
              child: const Text('Change Photo'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'Assistant User',
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: 'user@assistant-drive.com',
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAllAchievements(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              Text(
                'All Achievements',
                style: AppTextStyles.h3.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppDimensions.paddingM,
                    mainAxisSpacing: AppDimensions.paddingM,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: _getAchievements().length,
                  itemBuilder: (context, index) {
                    final achievement = _getAchievements()[index];
                    return AchievementCardWidget(
                      title: achievement['title'] as String,
                      description: achievement['description'] as String,
                      icon: achievement['icon'] as IconData,
                      isUnlocked: achievement['isUnlocked'] as bool,
                      progress: achievement['progress'] as double,
                      isExpanded: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
