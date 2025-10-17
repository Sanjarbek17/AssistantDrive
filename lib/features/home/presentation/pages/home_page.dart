import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/constants/app_theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../providers/home_providers.dart';
import '../providers/home_state.dart';
import '../widgets/feature_card.dart';
import '../widgets/status_dashboard.dart';
import '../widgets/quick_actions.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    // Initialize home state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeStateProvider.notifier).initialize();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeStateProvider);
    final isDrivingMode = ref.watch(isDrivingModeProvider);
    final settingsVisible = ref.watch(settingsVisibilityProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context, isDrivingMode, settingsVisible),
              SliverPadding(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([_buildWelcomeSection(homeState), const SizedBox(height: AppDimensions.paddingL), _buildStatusDashboard(homeState), const SizedBox(height: AppDimensions.paddingL), _buildQuickActions(isDrivingMode), const SizedBox(height: AppDimensions.paddingL), _buildFeaturesSection(), const SizedBox(height: AppDimensions.paddingL), _buildSystemRequirements(), const SizedBox(height: AppDimensions.paddingXL)]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDrivingMode, bool settingsVisible) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(AppConstants.appName, style: AppTextStyles.h3.copyWith(color: Colors.white)),
        background: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
          child: const Center(child: Icon(Icons.drive_eta, size: 48, color: Colors.white70)),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            ref.read(settingsVisibilityProvider.notifier).state = !settingsVisible;
          },
        ),
      ],
    );
  }

  Widget _buildWelcomeSection(HomeState homeState) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.waving_hand, color: AppColors.warning, size: AppDimensions.iconL),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome to AssistantDrive', style: AppTextStyles.h3),
                    const SizedBox(height: AppDimensions.paddingS),
                    Text(AppConstants.appDescription, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingM),
          _buildStatusIndicator(homeState),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(HomeState homeState) {
    String statusText;
    Color statusColor;
    IconData statusIcon;

    switch (homeState.status) {
      case HomeStatus.initial:
        statusText = 'Initializing...';
        statusColor = AppColors.textSecondary;
        statusIcon = Icons.hourglass_empty;
        break;
      case HomeStatus.loading:
        statusText = 'Setting up services...';
        statusColor = AppColors.info;
        statusIcon = Icons.sync;
        break;
      case HomeStatus.ready:
        statusText = 'Ready to assist your drive';
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        break;
      case HomeStatus.error:
        statusText = 'Error: ${homeState.errorMessage}';
        statusColor = AppColors.error;
        statusIcon = Icons.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(statusIcon, color: statusColor),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Text(statusText, style: AppTextStyles.bodyMedium.copyWith(color: statusColor)),
          ),
          if (homeState.status == HomeStatus.loading) SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(statusColor))),
        ],
      ),
    );
  }

  Widget _buildStatusDashboard(HomeState homeState) {
    return const StatusDashboard();
  }

  Widget _buildQuickActions(bool isDrivingMode) {
    return QuickActions(isDrivingMode: isDrivingMode);
  }

  Widget _buildFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('🎯 Key Features', style: AppTextStyles.h3),
        const SizedBox(height: AppDimensions.paddingM),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: AppDimensions.paddingM, mainAxisSpacing: AppDimensions.paddingM, childAspectRatio: 1.2),
          itemCount: AppConstants.keyFeatures.length,
          itemBuilder: (context, index) {
            return FeatureCard(title: AppConstants.keyFeatures[index], icon: _getFeatureIcon(index));
          },
        ),
      ],
    );
  }

  Widget _buildSystemRequirements() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('📱 System Requirements', style: AppTextStyles.h4),
          const SizedBox(height: AppDimensions.paddingM),
          _buildRequirementItem(Icons.phone_iphone, AppConstants.minIOSVersion),
          _buildRequirementItem(Icons.phone_android, AppConstants.minAndroidVersion),
          _buildRequirementItem(Icons.wifi, AppConstants.recommendedBandwidth),
          const SizedBox(height: AppDimensions.paddingM),
          Text('🎯 Performance Targets', style: AppTextStyles.h4),
          const SizedBox(height: AppDimensions.paddingM),
          _buildRequirementItem(Icons.precision_manufacturing, 'Accuracy: ≥ ${(AppConstants.targetAccuracy * 100).toInt()}%'),
          _buildRequirementItem(Icons.speed, 'Latency: ≤ ${AppConstants.maxLatency}s'),
          _buildRequirementItem(Icons.trending_up, 'Uptime: ${(AppConstants.targetUptime * 100).toInt()}%'),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
      child: Row(
        children: [
          Icon(icon, size: AppDimensions.iconS, color: AppColors.primary),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }

  IconData _getFeatureIcon(int index) {
    const icons = [Icons.videocam, Icons.route, Icons.traffic, Icons.warning, Icons.record_voice_over, Icons.navigation];
    return icons[index % icons.length];
  }
}
