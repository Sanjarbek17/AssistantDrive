import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/app_theme.dart';
import '../widgets/settings_section_widget.dart';
import '../widgets/settings_item_widget.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTextStyles.h3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => context.goNamed('help'),
            icon: const Icon(Icons.help_outline, color: Colors.white),
            tooltip: 'Help',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audio Settings Section
            SettingsSectionWidget(
              title: 'Audio Settings',
              icon: Icons.volume_up,
              children: [
                SettingsItemWidget(
                  title: 'Voice Volume',
                  subtitle: 'Adjust text-to-speech volume',
                  leading: const Icon(Icons.volume_up_outlined),
                  trailing: Slider(
                    value: 0.8,
                    onChanged: (value) {
                      // TODO: Implement volume control
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItemWidget(
                  title: 'Speech Rate',
                  subtitle: 'Speed of voice announcements',
                  leading: const Icon(Icons.speed_outlined),
                  trailing: Slider(
                    value: 0.5,
                    onChanged: (value) {
                      // TODO: Implement speech rate control
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItemWidget(
                  title: 'Voice Language',
                  subtitle: 'English (US)',
                  leading: const Icon(Icons.language_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Implement language selection
                    _showLanguageDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Camera Settings Section
            SettingsSectionWidget(
              title: 'Camera Settings',
              icon: Icons.camera_alt,
              children: [
                SettingsItemWidget(
                  title: 'Detection Sensitivity',
                  subtitle: 'Adjust object detection sensitivity',
                  leading: const Icon(Icons.tune_outlined),
                  trailing: Slider(
                    value: 0.7,
                    onChanged: (value) {
                      // TODO: Implement sensitivity control
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItemWidget(
                  title: 'Camera Resolution',
                  subtitle: 'High Quality',
                  leading: const Icon(Icons.high_quality_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Implement resolution selection
                    _showResolutionDialog(context);
                  },
                ),
                SettingsItemWidget(
                  title: 'Auto-announce Objects',
                  subtitle: 'Automatically announce detected objects',
                  leading: const Icon(Icons.record_voice_over_outlined),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // TODO: Implement auto-announce toggle
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Accessibility Settings Section
            SettingsSectionWidget(
              title: 'Accessibility',
              icon: Icons.accessibility,
              children: [
                SettingsItemWidget(
                  title: 'High Contrast Mode',
                  subtitle: 'Increase visual contrast',
                  leading: const Icon(Icons.contrast_outlined),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // TODO: Implement high contrast mode
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItemWidget(
                  title: 'Large Text',
                  subtitle: 'Increase text size',
                  leading: const Icon(Icons.text_fields_outlined),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      // TODO: Implement large text mode
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
                SettingsItemWidget(
                  title: 'Vibration Feedback',
                  subtitle: 'Haptic feedback for interactions',
                  leading: const Icon(Icons.vibration_outlined),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // TODO: Implement vibration toggle
                    },
                    activeColor: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // App Settings Section
            SettingsSectionWidget(
              title: 'App Settings',
              icon: Icons.settings_applications,
              children: [
                SettingsItemWidget(
                  title: 'Notifications',
                  subtitle: 'Manage app notifications',
                  leading: const Icon(Icons.notifications_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Navigate to notifications settings
                  },
                ),
                SettingsItemWidget(
                  title: 'Privacy Policy',
                  subtitle: 'View privacy policy',
                  leading: const Icon(Icons.privacy_tip_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Navigate to privacy policy
                  },
                ),
                SettingsItemWidget(
                  title: 'About',
                  subtitle: 'App version and information',
                  leading: const Icon(Icons.info_outlined),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingXL),

            // Reset Settings
            Center(
              child: OutlinedButton.icon(
                onPressed: () {
                  _showResetDialog(context);
                },
                icon: const Icon(Icons.restore_outlined),
                label: const Text('Reset to Defaults'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingXL),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English (US)'),
              leading: Radio<String>(
                value: 'en-US',
                groupValue: 'en-US',
                onChanged: (value) {
                  Navigator.of(context).pop();
                },
              ),
            ),
            ListTile(
              title: const Text('English (UK)'),
              leading: Radio<String>(
                value: 'en-UK',
                groupValue: 'en-US',
                onChanged: (value) {
                  Navigator.of(context).pop();
                },
              ),
            ),
            ListTile(
              title: const Text('Spanish'),
              leading: Radio<String>(
                value: 'es',
                groupValue: 'en-US',
                onChanged: (value) {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showResolutionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Resolution'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('High Quality'),
              subtitle: const Text('Best for detection accuracy'),
              leading: Radio<String>(
                value: 'high',
                groupValue: 'high',
                onChanged: (value) {
                  Navigator.of(context).pop();
                },
              ),
            ),
            ListTile(
              title: const Text('Medium Quality'),
              subtitle: const Text('Balanced performance'),
              leading: Radio<String>(
                value: 'medium',
                groupValue: 'high',
                onChanged: (value) {
                  Navigator.of(context).pop();
                },
              ),
            ),
            ListTile(
              title: const Text('Low Quality'),
              subtitle: const Text('Faster processing'),
              leading: Radio<String>(
                value: 'low',
                groupValue: 'high',
                onChanged: (value) {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Assistant Drive',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.primary,
        ),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
          size: 32,
        ),
      ),
      children: [
        const Text('An AI-powered object detection app designed to assist visually impaired users in identifying objects in their environment.'),
        const SizedBox(height: 16),
        const Text('© 2025 Assistant Drive Team'),
      ],
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text('Are you sure you want to reset all settings to their default values? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement reset functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings reset to defaults'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
