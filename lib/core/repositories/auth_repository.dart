import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../services/google_sign_in_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  // Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'phone': phone,
      },
    );

    if (response.user != null) {
      // Create user profile in profiles table
      await _client.from('profiles').insert({
        'id': response.user!.id,
        'email': email,
        'full_name': fullName,
        'phone': phone,
      });
    }

    return response;
  }

  // Sign in with email and password
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign in with Google
  Future<AuthResponse?> signInWithGoogle() async {
    try {
      final response = await GoogleSignInService.signInWithGoogle();

      if (response?.user != null) {
        // Check if user profile exists, if not create one
        final existingProfile = await _client
            .from('profiles')
            .select()
            .eq('id', response!.user!.id)
            .maybeSingle();

        if (existingProfile == null) {
          // Create user profile
          await _client.from('profiles').insert({
            'id': response.user!.id,
            'email': response.user!.email,
            'full_name': response.user!.userMetadata?['full_name'] ??
                response.user!.userMetadata?['name'] ??
                'Google User',
            'avatar_url': response.user!.userMetadata?['avatar_url'],
          });
        }
      }

      return response;
    } catch (e) {
      throw Exception('Google ile giriş yapılırken hata oluştu: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // Get current user
  User? get currentUser => _client.auth.currentUser;

  // Get current user profile
  Future<UserModel?> getCurrentUserProfile() async {
    final user = currentUser;
    if (user == null) return null;

    try {
      final response =
          await _client.from('profiles').select().eq('id', user.id).single();

      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  // Update user profile
  Future<UserModel> updateUserProfile({
    required String userId,
    String? fullName,
    String? phone,
    String? avatarUrl,
  }) async {
    final updateData = <String, dynamic>{};

    if (fullName != null) updateData['full_name'] = fullName;
    if (phone != null) updateData['phone'] = phone;
    if (avatarUrl != null) updateData['avatar_url'] = avatarUrl;

    final response = await _client
        .from('profiles')
        .update(updateData)
        .eq('id', userId)
        .select()
        .single();

    return UserModel.fromJson(response);
  }

  // Auth state changes stream
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  // Reset password
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  // Update password
  Future<UserResponse> updatePassword(String newPassword) async {
    return await _client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  // Check if user account exists
  Future<bool> checkUserExists(String email) async {
    try {
      final response = await _client
          .from('profiles')
          .select('id')
          .eq('email', email)
          .maybeSingle();
      
      return response != null;
    } catch (e) {
      return false;
    }
  }

  // Validate user credentials
  Future<Map<String, dynamic>> validateUserCredentials({
    required String email,
    required String password,
  }) async {
    try {
      // First check if user exists in profiles table
      final userExists = await checkUserExists(email);
      
      if (!userExists) {
        return {
          'success': false,
          'error': 'Bu e-posta adresi ile kayıtlı bir hesap bulunamadı. Lütfen önce hesap oluşturun.',
          'errorType': 'user_not_found',
        };
      }

      // Try to sign in with Supabase
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return {
          'success': true,
          'user': response.user,
          'session': response.session,
        };
      } else {
        return {
          'success': false,
          'error': 'E-posta veya şifre hatalı. Lütfen bilgilerinizi kontrol edin.',
          'errorType': 'invalid_credentials',
        };
      }
    } catch (e) {
      // Handle specific Supabase errors
      if (e.toString().contains('Invalid login credentials')) {
        return {
          'success': false,
          'error': 'E-posta veya şifre hatalı. Lütfen bilgilerinizi kontrol edin.',
          'errorType': 'invalid_credentials',
        };
      } else if (e.toString().contains('Email not confirmed')) {
        return {
          'success': false,
          'error': 'E-posta adresiniz henüz doğrulanmamış. Lütfen e-posta kutunuzu kontrol edin.',
          'errorType': 'email_not_confirmed',
        };
      } else {
        return {
          'success': false,
          'error': 'Giriş yapılırken bir hata oluştu. Lütfen tekrar deneyin.',
          'errorType': 'unknown_error',
        };
      }
    }
  }
}
