import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      home: Scaffold(
        body: Center(child: Text('ULTIMA : Connexion OK')),
      ),
    );
  }
}