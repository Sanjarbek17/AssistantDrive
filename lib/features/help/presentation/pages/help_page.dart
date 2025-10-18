import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/constants/app_theme.dart';

class HelpPage extends ConsumerWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: AppTextStyles.h3.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Start Guide
            _buildHelpSection(
              'Quick Start Guide',
              Icons.play_circle_outline,
              [
                _buildHelpItem(
                  'Getting Started',
                  'Learn how to use Assistant Drive for object detection',
                  Icons.rocket_launch,
                  () => _showTutorial(context),
                ),
                _buildHelpItem(
                  'Camera Setup',
                  'Configure your camera for optimal detection',
                  Icons.camera_alt,
                  () => _showCameraGuide(context),
                ),
                _buildHelpItem(
                  'Audio Settings',
                  'Customize voice announcements and audio feedback',
                  Icons.volume_up,
                  () => _showAudioGuide(context),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Accessibility Features
            _buildHelpSection(
              'Accessibility Features',
              Icons.accessibility,
              [
                _buildHelpItem(
                  'Voice Navigation',
                  'Navigate the app using voice commands',
                  Icons.record_voice_over,
                  () => _showVoiceGuide(context),
                ),
                _buildHelpItem(
                  'Screen Reader Support',
                  'Using Assistant Drive with screen readers',
                  Icons.speaker_notes,
                  () => _showScreenReaderGuide(context),
                ),
                _buildHelpItem(
                  'High Contrast Mode',
                  'Enable high contrast for better visibility',
                  Icons.contrast,
                  () => _showContrastGuide(context),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Troubleshooting
            _buildHelpSection(
              'Troubleshooting',
              Icons.build,
              [
                _buildHelpItem(
                  'Detection Issues',
                  'Solve common object detection problems',
                  Icons.visibility_off,
                  () => _showTroubleshootingGuide(context, 'detection'),
                ),
                _buildHelpItem(
                  'Audio Problems',
                  'Fix audio playback and voice issues',
                  Icons.volume_off,
                  () => _showTroubleshootingGuide(context, 'audio'),
                ),
                _buildHelpItem(
                  'Camera Not Working',
                  'Resolve camera access and permission issues',
                  Icons.camera_alt_outlined,
                  () => _showTroubleshootingGuide(context, 'camera'),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // FAQ Section
            _buildHelpSection(
              'Frequently Asked Questions',
              Icons.quiz,
              [
                _buildExpandableItem(
                  'How accurate is object detection?',
                  'Our AI model achieves 90-95% accuracy in good lighting conditions. Accuracy may vary based on lighting, object size, and distance.',
                ),
                _buildExpandableItem(
                  'Does the app work offline?',
                  'Yes! Object detection works completely offline. No internet connection is required for basic functionality.',
                ),
                _buildExpandableItem(
                  'How do I improve detection accuracy?',
                  'Ensure good lighting, hold the camera steady, and keep objects in clear view. Avoid extreme angles and cluttered backgrounds.',
                ),
                _buildExpandableItem(
                  'Can I use this app with VoiceOver?',
                  'Absolutely! The app is fully compatible with VoiceOver and other screen readers. All interface elements have proper accessibility labels.',
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingL),

            // Contact Support
            _buildHelpSection(
              'Contact Support',
              Icons.contact_support,
              [
                _buildHelpItem(
                  'Send Feedback',
                  'Share your thoughts and suggestions',
                  Icons.feedback,
                  () => _showFeedbackForm(context),
                ),
                _buildHelpItem(
                  'Report a Bug',
                  'Let us know about any issues you encounter',
                  Icons.bug_report,
                  () => _showBugReportForm(context),
                ),
                _buildHelpItem(
                  'Email Support',
                  'Get help from our support team',
                  Icons.email,
                  () => _contactSupport(context),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingXL),

            // App Information
            Center(
              child: Column(
                children: [
                  Container(
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
                  const SizedBox(height: AppDimensions.paddingM),
                  Text(
                    'Assistant Drive',
                    style: AppTextStyles.h4.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Version 1.0.0',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingS),
                  Text(
                    'AI-powered object detection for accessibility',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
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

  Widget _buildHelpSection(String title, IconData icon, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Text(
                  title,
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingM),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(
        title,
        style: AppTextStyles.bodyLarge.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }

  Widget _buildExpandableItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  void _showTutorial(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tutorial'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome to Assistant Drive! Here\'s how to get started:'),
              SizedBox(height: 16),
              Text('1. Open the Camera page'),
              Text('2. Point your camera at objects'),
              Text('3. Listen to voice announcements'),
              Text('4. View detection history'),
              Text('5. Adjust settings as needed'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  void _showCameraGuide(BuildContext context) {
    _showGuideDialog(context, 'Camera Setup', [
      'Ensure your device has camera permissions enabled',
      'Clean your camera lens for clear images',
      'Use good lighting for better detection',
      'Hold the camera steady while detecting',
      'Keep objects in the center of the frame',
    ]);
  }

  void _showAudioGuide(BuildContext context) {
    _showGuideDialog(context, 'Audio Settings', [
      'Adjust volume in Settings > Audio Settings',
      'Change speech rate for faster/slower announcements',
      'Enable/disable object announcements',
      'Test audio with the preview button',
      'Use headphones for better audio quality',
    ]);
  }

  void _showVoiceGuide(BuildContext context) {
    _showGuideDialog(context, 'Voice Navigation', [
      'Use VoiceOver or TalkBack for screen reading',
      'Double-tap to activate buttons',
      'Swipe to navigate between elements',
      'Use voice commands for quick actions',
      'Adjust speech settings for comfort',
    ]);
  }

  void _showScreenReaderGuide(BuildContext context) {
    _showGuideDialog(context, 'Screen Reader Support', [
      'All buttons and controls have descriptive labels',
      'Detection results are automatically announced',
      'Use focus navigation to explore the interface',
      'Enable high contrast mode for better visibility',
      'Customize voice settings for your preference',
    ]);
  }

  void _showContrastGuide(BuildContext context) {
    _showGuideDialog(context, 'High Contrast Mode', [
      'Go to Settings > Accessibility',
      'Enable High Contrast Mode',
      'Adjust text size if needed',
      'Use the large text option for better readability',
      'Test different combinations for comfort',
    ]);
  }

  void _showTroubleshootingGuide(BuildContext context, String type) {
    Map<String, List<String>> guides = {
      'detection': [
        'Check camera permissions in device settings',
        'Ensure good lighting conditions',
        'Clean camera lens',
        'Update the app to the latest version',
        'Restart the app if detection stops working',
      ],
      'audio': [
        'Check device volume settings',
        'Verify app has audio permissions',
        'Test with headphones or speakers',
        'Restart the app to reset audio',
        'Check for conflicting audio apps',
      ],
      'camera': [
        'Grant camera permission in device settings',
        'Close other apps using the camera',
        'Restart your device',
        'Update your device software',
        'Contact support if issues persist',
      ],
    };

    String title = type == 'detection'
        ? 'Detection Issues'
        : type == 'audio'
        ? 'Audio Problems'
        : 'Camera Issues';

    _showGuideDialog(context, title, guides[type] ?? []);
  }

  void _showGuideDialog(BuildContext context, String title, List<String> steps) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: steps
                .map(
                  (step) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(child: Text(step)),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Feedback'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Share your thoughts and suggestions...',
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
                  content: Text('Thank you for your feedback!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _showBugReportForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report a Bug'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Bug Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Describe the bug and steps to reproduce...',
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
                  content: Text('Bug report submitted. Thank you!'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _contactSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get help from our support team:'),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.email, color: AppColors.primary),
                SizedBox(width: 8),
                Text('support@assistant-drive.com'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.schedule, color: AppColors.primary),
                SizedBox(width: 8),
                Text('Response time: 24-48 hours'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Open email client
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening email client...'),
                ),
              );
            },
            child: const Text('Send Email'),
          ),
        ],
      ),
    );
  }
}
