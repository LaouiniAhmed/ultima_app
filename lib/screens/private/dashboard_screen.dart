import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/auth_service.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Njibou el user data mel session
    final user = Supabase.instance.client.auth.currentUser;
    final String name = user?.userMetadata?['full_name'] ?? "User";
    final String role = user?.userMetadata?['role'] ?? "Member";
    final String phone = user?.userMetadata?['phone'] ?? "No Phone";

    return Scaffold(
      body: Stack(
        children: [
          // Background Industrial
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.4, -0.2),
                radius: 1.5,
                colors: [Color(0xFF1A1A1A), Color(0xFF0A0A0A), Color(0xFF000000)],
              ),
            ),
          ),
          
          // Tech Lines décoratives
          Positioned.fill(child: CustomPaint(painter: TechLinesPainter())),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  
                  // Top Bar: Logo & SignOut
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("ULTIMA", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 4)),
                      IconButton(
                        icon: const Icon(Icons.logout_rounded, color: Colors.white70),
                        onPressed: () async => await AuthService().signOut(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // User Info Card
                  _buildProfileHeader(name, role, phone),

                  const SizedBox(height: 30),

                  // Main Content (Adaptive according to role)
                  const Text("SYSTEM STATUS", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        _buildStatCard("Tournaments", "12", Icons.emoji_events_outlined),
                        _buildStatCard("Active Teams", "4", Icons.groups_outlined),
                        _buildStatCard("Ranking", "#1", Icons.leaderboard_outlined),
                        _buildStatCard("Messages", "0", Icons.chat_bubble_outline),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Header avec Glassmorphism
  Widget _buildProfileHeader(String name, String role, String phone) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("WELCOME BACK,", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10, letterSpacing: 2)),
          const SizedBox(height: 5),
          Text(name.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildBadge(role.toUpperCase()),
              const SizedBox(width: 10),
              Text(phone, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(label, style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        color: Colors.white.withOpacity(0.02),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white54, size: 24),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(title, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10)),
        ],
      ),
    );
  }
}

// TechLinesPainter nafsou elli sta3melnah
class TechLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.05)..strokeWidth = 2..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width * 0.2, 0), Offset(size.width, size.height * 0.8), paint);
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width * 0.6, size.height), paint);
  }
  @override bool shouldRepaint(CustomPainter oldDelegate) => false;
}