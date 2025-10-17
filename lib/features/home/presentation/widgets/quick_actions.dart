import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/constants/app_theme.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_card.dart';
import '../providers/home_providers.dart';

class QuickActions extends ConsumerWidget {
  final bool isDrivingMode;

  const QuickActions({super.key, required this.isDrivingMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🚀 Quick Actions', style: AppTextStyles.h3),
        const SizedBox(height: AppDimensions.paddingM),
        if (isDrivingMode) _buildDrivingModeActions(ref) else _buildNormalModeActions(ref),
        const SizedBox(height: AppDimensions.paddingM),
        _buildLanguageSelector(ref),
      ],
    );
  }

  Widget _buildNormalModeActions(WidgetRef ref) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.info, size: AppDimensions.iconM),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(child: Text('Ready to start your safe driving experience?', style: AppTextStyles.bodyMedium)),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingL),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Start Driving',
                  icon: const Icon(Icons.drive_eta, color: Colors.white),
                  type: ButtonType.primary,
                  onPressed: () {
                    ref.read(isDrivingModeProvider.notifier).state = true;
                    _showDrivingModeDialog(ref);
                  },
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: AppButton(
                  text: 'Test Features',
                  icon: const Icon(Icons.play_arrow),
                  type: ButtonType.secondary,
                  onPressed: () {
                    _showTestFeaturesDialog();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrivingModeActions(WidgetRef ref) {
    return AppCard(
      backgroundColor: AppColors.primary.withOpacity(0.1),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingS),
                decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: AppDimensions.iconS),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Driving Mode Active', style: AppTextStyles.h4.copyWith(color: AppColors.success)),
                    Text('AI assistance is monitoring your drive', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingL),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Stop Driving',
                  icon: const Icon(Icons.stop, color: Colors.white),
                  type: ButtonType.primary,
                  onPressed: () {
                    ref.read(isDrivingModeProvider.notifier).state = false;
                  },
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: AppButton(
                  text: 'Settings',
                  icon: const Icon(Icons.settings),
                  type: ButtonType.secondary,
                  onPressed: () {
                    ref.read(settingsVisibilityProvider.notifier).state = !ref.read(settingsVisibilityProvider);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSelector(WidgetRef ref) {
    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🌐 Language Settings', style: AppTextStyles.h4),
          const SizedBox(height: AppDimensions.paddingM),
          Wrap(
            spacing: AppDimensions.paddingM,
            children: AppConstants.supportedLanguages.map((language) {
              final isSelected = selectedLanguage == language['code'];
              return FilterChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(language['flag']!),
                    const SizedBox(width: AppDimensions.paddingS),
                    Text(language['name']!),
                  ],
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    ref.read(selectedLanguageProvider.notifier).state = language['code']!;
                  }
                },
                selectedColor: AppColors.primary.withOpacity(0.2),
                checkmarkColor: AppColors.primary,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showDrivingModeDialog(WidgetRef ref) {
    // TODO: Show driving mode setup dialog
    // This would include camera permission, GPS setup, etc.
  }

  void _showTestFeaturesDialog() {
    // TODO: Show test features dialog
    // This would demonstrate each feature capability
  }
}
