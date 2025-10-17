import 'package:flutter_riverpod/flutter_riverpod.dart';

enum HomeStatus { initial, loading, ready, error }

class HomeState {
  final HomeStatus status;
  final String? errorMessage;

  const HomeState({this.status = HomeStatus.initial, this.errorMessage});

  HomeState copyWith({HomeStatus? status, String? errorMessage}) {
    return HomeState(status: status ?? this.status, errorMessage: errorMessage);
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  Future<void> initialize() async {
    state = state.copyWith(status: HomeStatus.loading);

    try {
      // Simulate initialization delay
      await Future.delayed(const Duration(seconds: 1));

      // Initialize app components
      await _initializeServices();

      state = state.copyWith(status: HomeStatus.ready);
    } catch (e) {
      state = state.copyWith(status: HomeStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> _initializeServices() async {
    // TODO: Initialize camera, location, TTS services
    // This will be implemented in later phases
  }

  void reset() {
    state = const HomeState();
  }
}
