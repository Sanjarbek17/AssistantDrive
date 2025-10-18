import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for tracking the current navigation index
final navigationIndexProvider = StateProvider<int>((ref) => 0);
