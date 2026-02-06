import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // --- SIGN UP ---
  Future<AuthResponse> signUp(
    String email, 
    String password, 
    String fullName, 
    String role,
    String phone,
  ) async {
    // Khallina el error t-oussel kima hiya bech n-catchiwha f'el UI
    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'role': role,
        'phone': phone,
      },
    );
  }

  // --- SIGN IN (FIXED) ---
  Future<AuthResponse> signIn(String email, String password) async {
    // Na77ina el try-catch men hna bech el 'AuthException' ma t-tbadalch l-Exception 3adeya
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // --- LOGOUT ---
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // --- GET CURRENT USER ---
  User? get currentUser => _supabase.auth.currentUser;

  // --- RESET PASSWORD ---
  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }
}