import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  // Audio file paths for driving assistant - navigation + road signs
  static const Map<String, String> audioFiles = {
    // Welcome
    'welcome': 'audio/welcome_english.mp3',

    // Navigation Commands
    'turn_left': 'audio/turn_left_english.mp3',
    'turn_right': 'audio/turn_right_english.mp3',
    'continue_straight': 'audio/continue_straight_english.mp3',
    'destination_reached': 'audio/destination_reached_english.mp3',
    'rerouting': 'audio/rerouting_english.mp3',
    'traffic_ahead': 'audio/traffic_ahead_english.mp3',

    // Road Sign Alerts
    'stop_sign': 'audio/stop_sign_english.mp3',
    'no_stopping': 'audio/no_stopping_english.mp3',
    'speed_limit': 'audio/speed_limit_english.mp3',
    'no_parking': 'audio/no_parking_english.mp3',
    'yield_ahead': 'audio/yield_ahead_english.mp3',
    'school_zone': 'audio/school_zone_english.mp3',
    'construction_zone': 'audio/construction_zone_english.mp3',
    'no_entry': 'audio/no_entry_english.mp3',
    'pedestrian_crossing': 'audio/pedestrian_crossing_english.mp3',
    'traffic_light_ahead': 'audio/traffic_light_ahead_english.mp3',
  };

  // Play specific audio file
  Future<void> playAudio(String audioKey) async {
    try {
      final audioPath = audioFiles[audioKey];
      if (audioPath != null) {
        await _audioPlayer.play(AssetSource(audioPath));
        print('Playing audio: $audioKey from $audioPath');
      } else {
        print('Audio file not found for key: $audioKey');
        // Fallback to a default audio or show message
        _playFallbackMessage(audioKey);
      }
    } catch (e) {
      print('Error playing audio: $e');
      _playFallbackMessage(audioKey);
    }
  }

  // Stop current audio
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
  }

  // Check if audio is currently playing
  bool get isPlaying => _audioPlayer.state == PlayerState.playing;

  // Fallback message when audio file is not available
  void _playFallbackMessage(String audioKey) {
    print('Audio file for "$audioKey" is not available. Please add the audio file to assets/audio/');
  }

  // Get all available audio commands
  static List<String> get availableCommands => audioFiles.keys.toList();

  // Clean up resources
  void dispose() {
    _audioPlayer.dispose();
  }
}
