import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/services/audio_service.dart';
import '../../../../shared/constants/app_theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../shared/widgets/app_button.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with TickerProviderStateMixin {
  final AudioService _audioService = AudioService();
  bool isPlaying = false;
  String currentAudioKey = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Mock data for dashboard stats
  final int totalDetections = 147;
  final int todayDetections = 12;
  final String lastDetectionTime = "2 minutes ago";
  final bool isSystemActive = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _animationController.forward();
  }

  Future<void> _speak() async {
    try {
      setState(() {
        isPlaying = true;
        currentAudioKey = 'welcome';
      });

      await _audioService.playAudio('welcome');

      // Simulate audio completion (in real app, you'd listen to audio completion)
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            isPlaying = false;
            currentAudioKey = '';
          });
        }
      });
    } catch (e) {
      print("Error playing audio: $e");
      setState(() {
        isPlaying = false;
        currentAudioKey = '';
      });

      // Show error message to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Audio file not found. Please add welcome_english.mp3 to assets/audio/'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _stop() async {
    await _audioService.stopAudio();
    setState(() {
      isPlaying = false;
      currentAudioKey = '';
    });
  }

  void _showAudioCommands() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Navigation & Road Sign Commands'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Available navigation and road sign alerts:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: AudioService.availableCommands.length,
                  itemBuilder: (context, index) {
                    final command = AudioService.availableCommands[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.audiotrack, color: Colors.blue),
                        title: Text(command.replaceAll('_', ' ').toUpperCase()),
                        subtitle: Text(_getAudioDescription(command)),
                        trailing: IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () => _playSpecificAudio(command),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Note: Audio files must be placed in assets/audio/ directory',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _playSpecificAudio(String audioKey) async {
    try {
      setState(() {
        isPlaying = true;
        currentAudioKey = audioKey;
      });

      await _audioService.playAudio(audioKey);

      // Simulate audio completion
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            isPlaying = false;
            currentAudioKey = '';
          });
        }
      });
    } catch (e) {
      print("Error playing audio: $e");
      setState(() {
        isPlaying = false;
        currentAudioKey = '';
      });
    }
  }

  String _getAudioDescription(String command) {
    switch (command) {
      // Welcome
      case 'welcome':
        return 'Welcome to your driving assistant!';

      // Navigation Commands
      case 'turn_left':
        return 'Turn left';
      case 'turn_right':
        return 'Turn right';
      case 'continue_straight':
        return 'Continue straight';
      case 'destination_reached':
        return 'You have reached your destination';
      case 'rerouting':
        return 'Finding new route';
      case 'traffic_ahead':
        return 'Traffic ahead';

      // Road Sign Alerts
      case 'stop_sign':
        return 'Stop sign ahead - come to a complete stop';
      case 'no_stopping':
        return 'No stopping zone - keep moving';
      case 'speed_limit':
        return 'Speed limit change - adjust your speed';
      case 'no_parking':
        return 'No parking zone - do not park here';
      case 'yield_ahead':
        return 'Yield sign ahead - give way to other traffic';
      case 'school_zone':
        return 'School zone - reduce speed, watch for children';
      case 'construction_zone':
        return 'Construction zone - slow down, be cautious';
      case 'no_entry':
        return 'No entry - do not proceed';
      case 'pedestrian_crossing':
        return 'Pedestrian crossing ahead - watch for people';
      case 'traffic_light_ahead':
        return 'Traffic light ahead - prepare to stop if needed';

      default:
        return 'Driving assistant command';
    }
  }

  @override
  void dispose() {
    _audioService.stopAudio();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildWelcomeHeader() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.radiusXL),
          bottomRight: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back!',
                        style: AppTextStyles.h2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your AI driving assistant is ready',
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppDimensions.paddingM),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    ),
                    child: Icon(
                      Icons.drive_eta,
                      size: AppDimensions.iconXL,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingL),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM,
                      vertical: AppDimensions.paddingS,
                    ),
                    decoration: BoxDecoration(
                      color: isSystemActive ? AppColors.success : AppColors.warning,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSystemActive ? Icons.check_circle : Icons.warning,
                          color: Colors.white,
                          size: AppDimensions.iconS,
                        ),
                        const SizedBox(width: AppDimensions.paddingS),
                        Text(
                          isSystemActive ? 'System Active' : 'System Offline',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today\'s Overview',
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: AppColors.primary,
                            size: AppDimensions.iconL,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.trending_up,
                            color: AppColors.success,
                            size: AppDimensions.iconM,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.paddingM),
                      Text(
                        '$todayDetections',
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Today\'s Detections',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.analytics,
                            color: AppColors.secondary,
                            size: AppDimensions.iconL,
                          ),
                          const Spacer(),
                          Icon(
                            Icons.star,
                            color: AppColors.warning,
                            size: AppDimensions.iconM,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.paddingM),
                      Text(
                        '$totalDetections',
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total Detections',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          AppCard(
            onTap: () => context.goNamed('camera'),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: AppColors.primary,
                    size: AppDimensions.iconL,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Camera Detection',
                        style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Begin real-time object detection',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: AppDimensions.iconS,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          AppCard(
            onTap: () => context.goNamed('history'),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingM),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  child: Icon(
                    Icons.history,
                    color: AppColors.secondary,
                    size: AppDimensions.iconL,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detection History',
                        style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'View past detection records',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondary,
                  size: AppDimensions.iconS,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activity',
                style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () => context.goNamed('history'),
                child: Text(
                  'View All',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingM),
          AppCard(
            child: Column(
              children: [
                _buildActivityItem(
                  icon: Icons.stop,
                  title: 'Stop Sign Detected',
                  subtitle: lastDetectionTime,
                  color: AppColors.error,
                ),
                const Divider(),
                _buildActivityItem(
                  icon: Icons.speed,
                  title: 'Speed Limit Sign',
                  subtitle: '5 minutes ago',
                  color: AppColors.warning,
                ),
                const Divider(),
                _buildActivityItem(
                  icon: Icons.school,
                  title: 'School Zone Alert',
                  subtitle: '12 minutes ago',
                  color: AppColors.info,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(
              icon,
              color: color,
              size: AppDimensions.iconM,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: isPlaying ? 'Stop Audio' : 'Test Audio',
                  icon: Icon(
                    isPlaying ? Icons.stop : Icons.volume_up,
                    size: AppDimensions.iconM,
                  ),
                  onPressed: isPlaying ? _stop : _speak,
                  type: ButtonType.secondary,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: AppButton(
                  text: 'Audio Guide',
                  icon: Icon(
                    Icons.navigation,
                    size: AppDimensions.iconM,
                  ),
                  onPressed: _showAudioCommands,
                  type: ButtonType.primary,
                ),
              ),
            ],
          ),
          if (isPlaying && currentAudioKey.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: AppDimensions.paddingM),
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.audiotrack,
                    color: AppColors.primary,
                    size: AppDimensions.iconM,
                  ),
                  const SizedBox(width: AppDimensions.paddingS),
                  Expanded(
                    child: Text(
                      'Playing: ${currentAudioKey.replaceAll('_', ' ')}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildWelcomeHeader(),
              _buildStatsGrid(),
              _buildQuickActions(),
              _buildRecentActivity(),
              _buildBottomActions(),
              const SizedBox(height: AppDimensions.paddingL),
            ],
          ),
        ),
      ),
    );
  }
}
