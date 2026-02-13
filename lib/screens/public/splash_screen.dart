import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // 1. Logo Display Time
    await Future.delayed(const Duration(seconds: 3));

    // 2. Recovery Session check (Asra3 mel currentSession)
    final user = Supabase.instance.client.auth.currentUser;

    if (!mounted) return;

    if (user == null) {
      // Login screen
      Navigator.pushReplacementNamed(context, '/'); 
    } else {
      // User connected -> Role logic with Timeout to prevent getting stuck
      _handleRoleRouting(user.id).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          if (mounted) Navigator.pushReplacementNamed(context, '/ultima');
        },
      );
    }
  }

  Future<void> _handleRoleRouting(String userId) async {
    try {
      // First check Metadata (Instant)
      final String? metadataRole = Supabase.instance.client.auth.currentUser?.userMetadata?['role'];
      
      if (metadataRole != null) {
        _navigateByRole(metadataRole);
        return;
      }

      // If metadata is empty, check DB
      final response = await Supabase.instance.client
          .from('profiles')
          .select('role')
          .eq('id', userId)
          .maybeSingle(); 

      String role = response?['role'] ?? 'player'; 
      _navigateByRole(role);
      
    } catch (e) {
      if (mounted) Navigator.pushReplacementNamed(context, '/');
    }
  }

  void _navigateByRole(String role) {
    if (!mounted) return;
    if (role == 'admin' || role == 'coach') {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/ultima'); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          'assets/images/ultima_splash.png', 
          fit: BoxFit.cover, 
        ),
      ),
    );
  }
}