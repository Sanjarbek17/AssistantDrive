import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  // Audio file paths for common driving assistant phrases
  static const Map<String, String> audioFiles = {
    'welcome': 'audio/welcome_english.mp3',
    'turn_left': 'audio/turn_left_english.mp3',
    'turn_right': 'audio/turn_right_english.mp3',
    'continue_straight': 'audio/continue_straight_english.mp3',
    'speed_warning': 'audio/speed_warning_english.mp3',
    'destination_reached': 'audio/destination_reached_english.mp3',
    'traffic_ahead': 'audio/traffic_ahead_english.mp3',
    'rerouting': 'audio/rerouting_english.mp3',
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
