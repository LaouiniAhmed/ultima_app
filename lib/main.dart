import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ultima_application/screens/public/splash_screen.dart';
import 'package:ultima_application/screens/public/login_screen.dart';
import 'package:ultima_application/screens/public/register_screen.dart'; 
import 'package:ultima_application/screens/public/dashboard_screen.dart';
import 'package:ultima_application/screens/public/forgot_password_screen.dart';
import 'package:ultima_application/screens/public/ultima_screen.dart';
import 'package:ultima_application/screens/public/almus_screen.dart';
import 'package:ultima_application/screens/public/summa_screen.dart';
import 'package:ultima_application/screens/public/live_match_screen.dart';
import 'package:ultima_application/screens/public/profile_screen.dart';
import 'package:ultima_application/screens/public/booking_screen.dart';
// --- EL IMPORTS EL JDOD ---
import 'package:ultima_application/screens/public/mymatches_screen.dart';
import 'package:ultima_application/screens/public/mystats_screen.dart';
import 'package:ultima_application/screens/public/hydration_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://eflxicthczsxnoegeinx.supabase.co', 
    anonKey: 'sb_publishable_3bY7o03fB4Io943Gq_ihgw_Pw3OtFHP', 
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ULTIMA',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Orbitron', 
      ),
      
      initialRoute: '/splash',

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const LoginScreen(), 
        '/register': (context) => const RegisterScreen(),
        '/ultima': (context) => const UltimaScreen(),         
        '/dashboard': (context) => const DashboardScreen(),   
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/almus': (context) => const AlmusScreen(),
        '/summa':(context) => const SummaScreen(),
        '/live-match':(context) => const LiveMatchScreen(),
        '/admin-home': (context) => const DashboardScreen(), 
        '/profile': (context) => const ProfileScreen(),
        //'/booking': (context) => const BookingScreen(),
        
        // --- EL ROUTES EL JDOD MTA3 EL DASHBOARD ---
        '/my-matches': (context) => const MyMatchesScreen(),
        '/my-stats': (context) => const MyStatsScreen(),
        '/hydration': (context) => const HydrationScreen(),
      },
    );
  }
}