import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/services/audio_service.dart';

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
            content: Text('Audio file not found. Please add welcome_uzbek.mp3 to assets/audio/'),
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
        title: const Text('Available Audio Commands'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Available pre-recorded phrases:', style: TextStyle(fontWeight: FontWeight.bold)),
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
      case 'welcome':
        return 'AssistantDrive ga xush kelibsiz!';
      case 'turn_left':
        return 'Chapga burilinq';
      case 'turn_right':
        return "O'ngga burilinq";
      case 'continue_straight':
        return "To'g'ri davom eting";
      case 'speed_warning':
        return 'Tezlikni kamaytiring';
      case 'destination_reached':
        return 'Maqsadga yetib keldingiz';
      case 'traffic_ahead':
        return 'Oldinda tirbandlik bor';
      case 'rerouting':
        return "Yangi yo'l topilmoqda";
      default:
        return 'Uzbek driving instruction';
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
              Text('🎵 Pre-recorded Audio System', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 16),
              Text('This app uses pre-recorded audio files in Uzbek language for better pronunciation and reliability.'),
              SizedBox(height: 16),
              Text('📁 Required Audio Files:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• welcome_uzbek.mp3 - Welcome message'),
              Text('• turn_left_uzbek.mp3 - Turn left instruction'),
              Text('• turn_right_uzbek.mp3 - Turn right instruction'),
              Text('• continue_straight_uzbek.mp3 - Continue straight'),
              Text('• speed_warning_uzbek.mp3 - Speed warning'),
              Text('• destination_reached_uzbek.mp3 - Destination reached'),
              Text('• traffic_ahead_uzbek.mp3 - Traffic warning'),
              Text('• rerouting_uzbek.mp3 - Rerouting message'),
              SizedBox(height: 16),
              Text('📍 Location:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Place audio files in: assets/audio/'),
              SizedBox(height: 16),
              Text('🎙️ Recording Tips:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('• Use native Uzbek speaker'),
              Text('• Clear, calm voice'),
              Text('• 44.1kHz, 16-bit quality'),
              Text('• 2-5 seconds per phrase'),
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
              'Your AI driving assistant',
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
              icon: const Icon(Icons.list),
              label: const Text('All Audio Commands'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _showAudioInstructions,
              icon: const Icon(Icons.info),
              label: const Text('Audio Setup Guide'),
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
