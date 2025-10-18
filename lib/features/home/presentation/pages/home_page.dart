import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/services/audio_service.dart';
import '../../../camera/presentation/pages/camera_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final AudioService _audioService = AudioService();
  bool isPlaying = false;
  String currentAudioKey = '';

  @override
  void initState() {
    super.initState();
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

  void _showAudioInstructions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Audio Setup Guide'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🚗 Complete Driving Assistant System', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 16),
              Text('This app uses pre-recorded audio for navigation commands and road sign alerts in English.'),
              SizedBox(height: 16),
              Text('📁 Required Audio Files:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                'Navigation Commands:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              Text('• welcome_english.mp3 - Welcome message'),
              Text('• turn_left_english.mp3 - Turn left instruction'),
              Text('• turn_right_english.mp3 - Turn right instruction'),
              Text('• continue_straight_english.mp3 - Continue straight'),
              Text('• destination_reached_english.mp3 - Destination reached'),
              Text('• rerouting_english.mp3 - Finding new route'),
              Text('• traffic_ahead_english.mp3 - Traffic warning'),
              SizedBox(height: 8),
              Text(
                'Road Sign Alerts:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
              ),
              Text('• stop_sign_english.mp3 - Stop sign alert'),
              Text('• no_stopping_english.mp3 - No stopping zone warning'),
              Text('• speed_limit_english.mp3 - Speed limit change alert'),
              Text('• no_parking_english.mp3 - No parking zone warning'),
              Text('• yield_ahead_english.mp3 - Yield sign alert'),
              Text('• school_zone_english.mp3 - School zone warning'),
              Text('• construction_zone_english.mp3 - Construction zone alert'),
              Text('• no_entry_english.mp3 - No entry warning'),
              Text('• pedestrian_crossing_english.mp3 - Pedestrian crossing alert'),
              Text('• traffic_light_ahead_english.mp3 - Traffic light warning'),
              SizedBox(height: 16),
              Text('📍 Location:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Place audio files in: assets/audio/'),
              SizedBox(height: 16),
              Text('🎙️ Recording Tips:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('• Use clear, calm English voice'),
              Text('• Navigation: Friendly, guiding tone'),
              Text('• Road signs: More urgent, safety-focused'),
              Text('• 44.1kHz, 16-bit quality'),
              Text('• 2-4 seconds per alert'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioService.stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AssistantDrive'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.drive_eta,
              size: 80,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to AssistantDrive',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Navigation & Road Sign Assistant',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: isPlaying ? _stop : _speak,
              icon: Icon(isPlaying ? Icons.stop : Icons.volume_up),
              label: Text(isPlaying ? 'Stop Audio' : 'Test Welcome Audio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            if (isPlaying && currentAudioKey.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Playing: ${currentAudioKey.replaceAll('_', ' ')}',
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _showAudioCommands,
              icon: const Icon(Icons.navigation),
              label: const Text('All Audio Commands'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraPage(),
                  ),
                );
              },
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera Detection'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _showAudioInstructions,
              icon: const Icon(Icons.info),
              label: const Text('Setup Guide'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
