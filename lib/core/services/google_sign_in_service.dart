import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  static GoogleSignIn get instance => _googleSignIn;

  /// Google ile giriş yap
  static Future<AuthResponse?> signInWithGoogle() async {
    try {
      // Google Sign-In işlemini başlat
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // Kullanıcı giriş işlemini iptal etti
        return null;
      }

      // Google'dan authentication detaylarını al
      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      // Supabase ile Google OAuth token'ını kullan
      final AuthResponse response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      return response;
    } catch (error) {
      throw Exception('Google ile giriş yapılırken hata oluştu: $error');
    }
  }

  /// Google hesabından çıkış yap
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await Supabase.instance.client.auth.signOut();
    } catch (error) {
      throw Exception('Çıkış yapılırken hata oluştu: $error');
    }
  }

  /// Mevcut Google kullanıcısını kontrol et
  static Future<GoogleSignInAccount?> getCurrentUser() async {
    return await _googleSignIn.signInSilently();
  }

  /// Google hesabının bağlı olup olmadığını kontrol et
  static Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }
}
