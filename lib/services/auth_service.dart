import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart' as app_user;
import '../config/supabase_config.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Mevcut kullanıcıyı al
  app_user.User? get currentUser {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    return app_user.User(
      id: user.id,
      email: user.email ?? '',
      fullName: user.userMetadata?['full_name'] as String? ?? '',
      phone: user.phone,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: user.createdAt != null
          ? DateTime.parse(user.createdAt!)
          : DateTime.now(),
      updatedAt: user.updatedAt != null
          ? DateTime.parse(user.updatedAt!)
          : DateTime.now(),
    );
  }

  // Stream olarak kullanıcı değişikliklerini dinle
  Stream<app_user.User?> get authStateChanges {
    return _supabase.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      if (user == null) return null;

      return app_user.User(
        id: user.id,
        email: user.email ?? '',
        fullName: user.userMetadata?['full_name'] as String? ?? '',
        phone: user.phone,
        avatarUrl: user.userMetadata?['avatar_url'] as String?,
        createdAt: user.createdAt != null
            ? DateTime.parse(user.createdAt!)
            : DateTime.now(),
        updatedAt: user.updatedAt != null
            ? DateTime.parse(user.updatedAt!)
            : DateTime.now(),
      );
    });
  }

  // E-posta/şifre ile kayıt
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );

    if (response.user != null) {
      // Kullanıcı profilini oluştur
      await _createUserProfile(response.user!);
    }

    return response;
  }

  // E-posta/şifre ile giriş
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Google ile giriş
  Future<AuthResponse> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      if (response.user != null) {
        // Kullanıcı profilini oluştur veya güncelle
        await _createOrUpdateUserProfile(response.user!);
      }

      return response;
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  // Çıkış yap
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supabase.auth.signOut();
  }

  // Şifre sıfırlama
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  // Şifre güncelleme
  Future<void> updatePassword(String newPassword) async {
    await _supabase.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  // Kullanıcı profilini oluştur
  Future<void> _createUserProfile(User user) async {
    try {
      await _supabase.from('profiles').insert({
        'id': user.id,
        'email': user.email,
        'full_name': user.userMetadata?['full_name'] as String? ?? '',
        'phone': user.phone,
        'avatar_url': user.userMetadata?['avatar_url'] as String?,
      });
    } catch (e) {
      // Profil zaten mevcut olabilir
      print('User profile creation error: $e');
    }
  }

  // Kullanıcı profilini oluştur veya güncelle
  Future<void> _createOrUpdateUserProfile(User user) async {
    try {
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'email': user.email,
        'full_name': user.userMetadata?['full_name'] as String? ?? '',
        'phone': user.phone,
        'avatar_url': user.userMetadata?['avatar_url'] as String?,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('User profile upsert error: $e');
    }
  }

  // Kullanıcı profilini güncelle
  Future<void> updateProfile({
    required String fullName,
    String? phone,
    String? avatarUrl,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    await _supabase.from('profiles').update({
      'full_name': fullName,
      'phone': phone,
      'avatar_url': avatarUrl,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', user.id);
  }

  // Kullanıcı profilini getir
  Future<app_user.User?> getUserProfile(String userId) async {
    try {
      final response =
          await _supabase.from('profiles').select().eq('id', userId).single();

      if (response == null) return null;

      return app_user.User(
        id: response['id'] as String,
        email: response['email'] as String,
        fullName: response['full_name'] as String? ?? '',
        phone: response['phone'] as String?,
        avatarUrl: response['avatar_url'] as String?,
        createdAt: response['created_at'] != null
            ? DateTime.parse(response['created_at'] as String)
            : DateTime.now(),
        updatedAt: response['updated_at'] != null
            ? DateTime.parse(response['updated_at'] as String)
            : DateTime.now(),
      );
    } catch (e) {
      return null;
    }
  }
}
