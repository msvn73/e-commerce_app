import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

// Auth state provider
final authStateProvider = StreamProvider<AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

// Current user provider
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (data) => data.session?.user,
    loading: () => null,
    error: (_, __) => null,
  );
});

// Current user profile provider
final currentUserProfileProvider = FutureProvider<UserModel?>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return await authRepository.getCurrentUserProfile();
});

// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Sign up provider
final signUpProvider = FutureProvider.family<AuthResponse, SignUpParams>((ref, params) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return await authRepository.signUp(
    email: params.email,
    password: params.password,
    fullName: params.fullName,
    phone: params.phone,
  );
});

// Sign in provider
final signInProvider = FutureProvider.family<AuthResponse, SignInParams>((ref, params) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return await authRepository.signInWithEmail(
    email: params.email,
    password: params.password,
  );
});

// Sign out provider
final signOutProvider = FutureProvider<void>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  await authRepository.signOut();
});

// Update profile provider
final updateProfileProvider = FutureProvider.family<UserModel, UpdateProfileParams>((ref, params) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return await authRepository.updateUserProfile(
    userId: params.userId,
    fullName: params.fullName,
    phone: params.phone,
    avatarUrl: params.avatarUrl,
  );
});

// Reset password provider
final resetPasswordProvider = FutureProvider.family<void, String>((ref, email) async {
  final authRepository = ref.watch(authRepositoryProvider);
  await authRepository.resetPassword(email);
});

// Update password provider
final updatePasswordProvider = FutureProvider.family<UserResponse, String>((ref, newPassword) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return await authRepository.updatePassword(newPassword);
});

// Parameter classes
class SignUpParams {
  final String email;
  final String password;
  final String fullName;
  final String? phone;

  SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
    this.phone,
  });
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}

class UpdateProfileParams {
  final String userId;
  final String? fullName;
  final String? phone;
  final String? avatarUrl;

  UpdateProfileParams({
    required this.userId,
    this.fullName,
    this.phone,
    this.avatarUrl,
  });
}
