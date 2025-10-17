# Flutter Development Guidelines with Copilot

## Overview
These instructions guide Copilot in generating Flutter code following best practices with feature-first architecture and Riverpod state management.

## Architecture Principles

### Feature-First Folder Structure
```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router/
│   └── theme/
├── shared/
│   ├── constants/
│   ├── extensions/
│   ├── utils/
│   ├── widgets/
│   ├── models/
│   └── services/
└── features/
    ├── authentication/
    │   ├── data/
    │   │   ├── datasources/
    │   │   ├── models/
    │   │   └── repositories/
    │   ├── domain/
    │   │   ├── entities/
    │   │   ├── repositories/
    │   │   └── usecases/
    │   └── presentation/
    │       ├── pages/
    │       ├── widgets/
    │       └── providers/
    └── [other_features]/
```

### State Management with Riverpod

#### Provider Naming Conventions
- **StateProvider**: `[feature]StateProvider`
- **StateNotifierProvider**: `[feature]NotifierProvider`
- **FutureProvider**: `[feature]FutureProvider`
- **StreamProvider**: `[feature]StreamProvider`
- **Provider**: `[feature]Provider`

#### Provider File Organization
```dart
// providers/auth_providers.dart
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authDataSourceProvider));
});
```

## Code Generation Guidelines

### 1. State Management Patterns

#### StateNotifier Implementation
```dart
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  
  AuthNotifier(this._repository) : super(const AuthState.initial());
  
  Future<void> signIn(String email, String password) async {
    state = const AuthState.loading();
    try {
      final user = await _repository.signIn(email, password);
      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}
```

#### State Classes with Freezed
```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}
```

### 2. Widget Patterns

#### Consumer Widgets
```dart
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return authState.when(
      initial: () => const SignInForm(),
      loading: () => const LoadingWidget(),
      authenticated: (user) => HomePage(user: user),
      error: (message) => ErrorWidget(message: message),
    );
  }
}
```

#### ConsumerStatefulWidget
```dart
class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Form fields
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
```

### 3. Repository Pattern

#### Abstract Repository
```dart
abstract class AuthRepository {
  Future<User> signIn(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Stream<User?> get authStateChanges;
}
```

#### Repository Implementation
```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;
  
  const AuthRepositoryImpl(this._dataSource);

  @override
  Future<User> signIn(String email, String password) async {
    try {
      final userModel = await _dataSource.signIn(email, password);
      return userModel.toEntity();
    } catch (e) {
      throw AuthException('Failed to sign in: ${e.toString()}');
    }
  }
}
```

### 4. Data Layer Patterns

#### Data Models with JSON Serialization
```dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? photoUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

extension UserModelX on UserModel {
  User toEntity() => User(
    id: id,
    email: email,
    name: name,
    photoUrl: photoUrl,
  );
}
```

#### Data Sources
```dart
abstract class AuthDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<void> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;
  
  const AuthDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> signIn(String email, String password) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    if (credential.user == null) {
      throw const AuthException('Failed to sign in');
    }
    
    return UserModel.fromFirebaseUser(credential.user!);
  }
}
```

## Best Practices

### 1. Provider Dependencies
- Always inject dependencies through providers
- Use `ref.read()` for one-time reads
- Use `ref.watch()` for reactive dependencies
- Use `ref.listen()` for side effects

### 2. Error Handling
```dart
// Custom exceptions
class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
  
  @override
  String toString() => 'AuthException: $message';
}

// Error handling in providers
Future<void> performAction() async {
  try {
    await _repository.performAction();
  } on AuthException catch (e) {
    state = AuthState.error(e.message);
  } catch (e) {
    state = AuthState.error('An unexpected error occurred');
  }
}
```

### 3. Widget Guidelines
- Prefer `ConsumerWidget` over `StatelessWidget`
- Use `ConsumerStatefulWidget` only when local state is needed
- Extract complex widgets into separate files
- Use `const` constructors wherever possible

### 4. File Naming Conventions
- **Screens/Pages**: `[feature_name]_page.dart`
- **Widgets**: `[widget_name]_widget.dart`
- **Providers**: `[feature_name]_providers.dart`
- **Models**: `[model_name]_model.dart`
- **Repositories**: `[feature_name]_repository.dart`
- **Data Sources**: `[feature_name]_data_source.dart`

### 5. Import Organization
```dart
// Dart imports
import 'dart:async';

// Flutter imports
import 'package:flutter/material.dart';

// Package imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports
import 'package:app_name/shared/constants/app_constants.dart';
import 'package:app_name/features/auth/domain/entities/user.dart';
```

### 6. Testing Patterns
```dart
// Provider testing
void main() {
  group('AuthNotifier', () {
    test('should emit loading then authenticated on successful sign in', () async {
      final container = ProviderContainer(
        overrides: [
          authRepositoryProvider.overrideWithValue(mockAuthRepository),
        ],
      );
      
      final notifier = container.read(authStateProvider.notifier);
      
      await notifier.signIn('test@test.com', 'password');
      
      expect(container.read(authStateProvider), isA<AuthStateAuthenticated>());
    });
  });
}
```

## Code Quality Standards

### 1. Documentation
- Add documentation comments for public APIs
- Use `///` for documentation comments
- Include examples for complex functions

### 2. Type Safety
- Always specify generic types
- Use nullable types appropriately
- Prefer explicit types over `var` for clarity

### 3. Performance
- Use `const` widgets wherever possible
- Implement proper `dispose` methods
- Use `ListView.builder` for large lists
- Optimize provider watching scope

### 4. Accessibility
- Add semantic labels to widgets
- Use proper contrast ratios
- Support screen readers
- Implement proper focus management

## Required Dependencies
When generating Flutter code, assume these dependencies are available:
```yaml
dependencies:
  flutter_riverpod: ^2.4.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  go_router: ^12.0.0

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

## Code Generation Commands
Remember to suggest running these commands after generating code with annotations:
```bash
flutter packages pub run build_runner build
# or for watching changes
flutter packages pub run build_runner watch
```

---

When generating Flutter code, always follow these patterns and conventions to ensure consistency, maintainability, and adherence to Flutter best practices with Riverpod state management.