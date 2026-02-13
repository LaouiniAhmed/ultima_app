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
    
    // 🛡️ Security Check: Thabbet el email fih "prefix.uadmin@ultima.tn"
    // Zidna el logic elli thabbet el prefix (atwal men 18 characters)
    if (role.toLowerCase() == 'admin') {
      final emailLower = email.toLowerCase().trim();
      if (!emailLower.endsWith(".uadmin@ultima.tn") || emailLower.length <= 18) {
        throw const AuthException("Unauthorized: Admin email must follow 'prefix.uadmin@ultima.tn'");
      }
    }

    return await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'role': role.toLowerCase(),
        'phone': phone,
      },
    );
  }

  // --- SIGN IN ---
  Future<AuthResponse> signIn(String email, String password) async {
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

  // --- GET USER ROLE ---
  String? get currentUserRole {
    return _supabase.auth.currentUser?.userMetadata?['role'];
  }

  // --- RESET PASSWORD (Phase 1: Send Link) ---
  Future<void> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(
        email.trim(),
        // redirectTo lazem t-koun maktouba f'Supabase Dashboard kima hkina
        redirectTo: 'io.supabase.ultima://reset-callback/', 
      );
    } catch (e) {
      rethrow;
    }
  }

  // --- UPDATE PASSWORD (Phase 2: New Password) ---
  // Hedhi zidha bech el user i-najem i-baddel password-ou ba3d ma i-cliqui 3al link
  Future<void> updatePassword(String newPassword) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      rethrow;
    }
  }
}