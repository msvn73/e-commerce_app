import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

part 'auth_provider.freezed.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.value;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final currentUser = ref.watch(currentUserProvider);
  return currentUser != null;
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AuthState.initial());

  // E-posta/şifre ile kayıt
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      state = const AuthState.loading();

      final response = await _authService.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );

      if (response.user != null) {
        final user = User(
          id: response.user!.id,
          email: response.user!.email ?? '',
          fullName: response.user!.userMetadata?['full_name'] as String? ?? '',
          phone: response.user!.phone,
          avatarUrl: response.user!.userMetadata?['avatar_url'] as String?,
          createdAt: response.user!.createdAt != null
              ? DateTime.parse(response.user!.createdAt!)
              : DateTime.now(),
          updatedAt: response.user!.updatedAt != null
              ? DateTime.parse(response.user!.updatedAt!)
              : DateTime.now(),
        );
        state = AuthState.success(user);
      } else {
        state = const AuthState.error('Kayıt başarısız');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // E-posta/şifre ile giriş
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = const AuthState.loading();

      final response = await _authService.signIn(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final user = User(
          id: response.user!.id,
          email: response.user!.email ?? '',
          fullName: response.user!.userMetadata?['full_name'] as String? ?? '',
          phone: response.user!.phone,
          avatarUrl: response.user!.userMetadata?['avatar_url'] as String?,
          createdAt: response.user!.createdAt != null
              ? DateTime.parse(response.user!.createdAt!)
              : DateTime.now(),
          updatedAt: response.user!.updatedAt != null
              ? DateTime.parse(response.user!.updatedAt!)
              : DateTime.now(),
        );
        state = AuthState.success(user);
      } else {
        state = const AuthState.error('Giriş başarısız');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Google ile giriş
  Future<void> signInWithGoogle() async {
    try {
      state = const AuthState.loading();

      final response = await _authService.signInWithGoogle();

      if (response.user != null) {
        final user = User(
          id: response.user!.id,
          email: response.user!.email ?? '',
          fullName: response.user!.userMetadata?['full_name'] as String? ?? '',
          phone: response.user!.phone,
          avatarUrl: response.user!.userMetadata?['avatar_url'] as String?,
          createdAt: response.user!.createdAt != null
              ? DateTime.parse(response.user!.createdAt!)
              : DateTime.now(),
          updatedAt: response.user!.updatedAt != null
              ? DateTime.parse(response.user!.updatedAt!)
              : DateTime.now(),
        );
        state = AuthState.success(user);
      } else {
        state = const AuthState.error('Google girişi başarısız');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Çıkış yap
  Future<void> signOut() async {
    try {
      state = const AuthState.loading();
      await _authService.signOut();
      state = const AuthState.initial();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Şifre sıfırlama
  Future<void> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Profil güncelleme
  Future<void> updateProfile({
    required String fullName,
    String? phone,
    String? avatarUrl,
  }) async {
    try {
      state = const AuthState.loading();

      await _authService.updateProfile(
        fullName: fullName,
        phone: phone,
        avatarUrl: avatarUrl,
      );

      // Güncel kullanıcı bilgilerini al
      final currentUser = _authService.currentUser;
      if (currentUser != null) {
        state = AuthState.success(currentUser);
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Kullanıcı profilini getir
  Future<void> getUserProfile(String userId) async {
    try {
      state = const AuthState.loading();

      final user = await _authService.getUserProfile(userId);
      if (user != null) {
        state = AuthState.success(user);
      } else {
        state = const AuthState.error('Kullanıcı profili bulunamadı');
      }
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  // Durumu sıfırla
  void resetState() {
    state = const AuthState.initial();
  }
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(User user) = _Success;
  const factory AuthState.error(String message) = _Error;
}
