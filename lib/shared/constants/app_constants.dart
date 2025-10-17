// App Constants
class AppConstants {
  // App Info
  static const String appName = 'AssistantDrive';
  static const String appVersion = '0.1.0';
  static const String appDescription = 'AI-powered driving assistance for new drivers';

  // Features
  static const List<String> keyFeatures = ['Real-time Video Analysis', 'Lane Departure Detection', 'Traffic Sign Recognition', 'Proximity Alerts', 'Voice Guidance', 'Route Assistance'];

  // Target Audience
  static const List<String> targetAudience = ['New Drivers (0-2 years experience)', 'Urban Drivers', 'Driving Schools', 'Safety-Conscious Drivers'];

  // System Requirements
  static const String minIOSVersion = 'iOS 14+';
  static const String minAndroidVersion = 'Android 8+';
  static const String recommendedBandwidth = '1-2 Mbps';

  // Performance Targets
  static const double targetAccuracy = 0.85; // 85%
  static const double maxLatency = 1.5; // seconds
  static const double targetUptime = 0.99; // 99%

  // Supported Languages
  static const List<Map<String, String>> supportedLanguages = [
    {'code': 'uz', 'name': 'O\'zbek', 'flag': '🇺🇿'},
    {'code': 'ru', 'name': 'Русский', 'flag': '🇷🇺'},
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
  ];

  // Event Types
  static const List<String> eventTypes = ['Lane Departure', 'Wrong Turn', 'Speed Limit Detection', 'Pedestrian Alert', 'Proximity Warning'];

  // Development Status
  static const String currentPhase = 'Phase 1: MVP Development';
  static const List<String> roadmapPhases = ['Phase 0: Concept & PRD ✅', 'Phase 1: MVP Development (8-12 weeks)', 'Phase 2: Beta Testing (12 weeks)', 'Phase 3: Production Release (8-12 weeks)'];
}
