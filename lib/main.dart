import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ultima_application/screens/public/login_screen.dart';
import 'package:ultima_application/screens/public/register_screen.dart'; 
import 'package:ultima_application/screens/public/dashboard_screen.dart';
import 'package:ultima_application/screens/public/forgot_password_screen.dart'; // <--- 1. Zid el import hedha!

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
      ),
      
      initialRoute: '/',

      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(), // <--- 2. Zid el route hedhi hna!
      },
    );
  }
}