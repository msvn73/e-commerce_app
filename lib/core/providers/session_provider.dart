import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Session state model
class SessionState {
  final bool isLoggedIn;
  final bool isAdmin;
  final String? userEmail;
  final String? userName;

  const SessionState({
    this.isLoggedIn = false,
    this.isAdmin = false,
    this.userEmail,
    this.userName,
  });

  SessionState copyWith({
    bool? isLoggedIn,
    bool? isAdmin,
    String? userEmail,
    String? userName,
  }) {
    return SessionState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isAdmin: isAdmin ?? this.isAdmin,
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
    );
  }
}

// Session notifier
class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier() : super(const SessionState()) {
    _loadSession();
  }

  // Load session from SharedPreferences
  Future<void> _loadSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final isAdmin = prefs.getBool('isAdmin') ?? false;
      final userEmail = prefs.getString('userEmail');
      final userName = prefs.getString('userName');

      if (isLoggedIn && userEmail != null) {
        state = SessionState(
          isLoggedIn: isLoggedIn,
          isAdmin: isAdmin,
          userEmail: userEmail,
          userName: userName,
        );
      }
    } catch (e) {
      // Handle error silently
    }
  }

  // Save session to SharedPreferences
  Future<void> _saveSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', state.isLoggedIn);
      await prefs.setBool('isAdmin', state.isAdmin);
      await prefs.setString('userEmail', state.userEmail ?? '');
      await prefs.setString('userName', state.userName ?? '');
    } catch (e) {
      // Handle error silently
    }
  }

  // Clear session from SharedPreferences
  Future<void> _clearSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
      await prefs.remove('isAdmin');
      await prefs.remove('userEmail');
      await prefs.remove('userName');
    } catch (e) {
      // Handle error silently
    }
  }

  void loginAsUser(String email, String name) {
    state = state.copyWith(
      isLoggedIn: true,
      isAdmin: false,
      userEmail: email,
      userName: name,
    );
    _saveSession();
  }

  void loginAsAdmin(String email) {
    state = state.copyWith(
      isLoggedIn: true,
      isAdmin: true,
      userEmail: email,
      userName: 'Admin',
    );
    _saveSession();
  }

  void logout() {
    state = const SessionState();
    _clearSession();
  }

  bool get isLoggedIn => state.isLoggedIn;
  bool get isAdmin => state.isAdmin;
  String? get userEmail => state.userEmail;
  String? get userName => state.userName;
}

// Session provider
final sessionProvider =
    StateNotifierProvider<SessionNotifier, SessionState>((ref) {
  return SessionNotifier();
});

// Convenience providers
final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(sessionProvider).isLoggedIn;
});

final isAdminProvider = Provider<bool>((ref) {
  return ref.watch(sessionProvider).isAdmin;
});

final currentUserEmailProvider = Provider<String?>((ref) {
  return ref.watch(sessionProvider).userEmail;
});

final currentUserNameProvider = Provider<String?>((ref) {
  return ref.watch(sessionProvider).userName;
});
