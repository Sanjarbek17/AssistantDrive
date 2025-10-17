import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

// Home State Provider
final homeStateProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

// App Settings Providers
final selectedLanguageProvider = StateProvider<String>((ref) => 'uz');

final isDrivingModeProvider = StateProvider<bool>((ref) => false);

final settingsVisibilityProvider = StateProvider<bool>((ref) => false);
