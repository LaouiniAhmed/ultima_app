import 'package:flutter/material.dart';
import 'package:ultima_application/navigation/custom_bottom_nav.dart';

class SummaScreen extends StatefulWidget {
  const SummaScreen({super.key});

  @override
  State<SummaScreen> createState() => _SummaScreenState();
}

class _ScrollControllerWrapper {
  final ScrollController controller = ScrollController();
}

class _SummaScreenState extends State<SummaScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌌 1. Background consistent m3a Almus/Ultima
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF142B2B), Color(0xFF0D141C)],
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // 🎾 2. Padel2 Image as Top Background with Gradient Overlay
                  Stack(
                    children: [
                      _buildHeroImage('assets/images/padel2.jpg'),
                      _buildTopStatsOverlay(),
                    ],
                  ),
                  
                  _buildHeroTitle(),
                  _buildImageSection('assets/images/scoreboard.jpg'),
                  _buildDescriptionText(),
                  _buildFeaturesSection(),
                  _buildInterfaceSection(),
                  _buildWhyChooseSection(),
                  _buildContactForm(),

                  const SizedBox(height: 120),
                ],
              ),
            ),

            // 📱 Floating Bottom Navigation Bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNav(scrollController: _scrollController),
            ),
          ],
        ),
      ),
    );
  }

  // --- 🆕 New Hero Section for Padel2 ---

  Widget _buildHeroImage(String path) {
    return Container(
      height: 450,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(path, fit: BoxFit.cover),
          // Gradient Fade mel louta lel fou9 bech t-ji "Degradé" m3a el background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  const Color(0xFF0D141C), // Nafs loun el background louta
                  const Color(0xFF0D141C).withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopStatsOverlay() {
    return Positioned(
      top: 60,
      left: 0,
      right: 0,
      child: _buildTopStats(),
    );
  }

  // --- El Helper Widgets (Optimized) ---

  Widget _buildTopStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 15, runSpacing: 15, alignment: WrapAlignment.center,
        children: [
          _statCard("1200+", "Active Players", const Color(0xFF00E5FF)), // Cyan
          _statCard("50+", "Coaches", const Color(0xFF39FF14)), // Neon Green
          _statCard("100+", "Sessions", const Color(0xFF00E5FF)),
          _statCard("24/7", "Support", const Color(0xFF39FF14)),
        ],
      ),
    );
  }

  Widget _statCard(String val, String label, Color color) {
    return Container(
      width: 160, padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A222C).withOpacity(0.7),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(val, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Orbitron')),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildHeroTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Text(
        "A complete scouting system for sport facilities",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Orbitron', height: 1.2),
      ),
    );
  }

  Widget _buildImageSection(String path) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), 
        border: Border.all(color: Colors.white10),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)]
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.asset(path, fit: BoxFit.cover)),
    );
  }

  Widget _buildDescriptionText() {
    return const Padding(
      padding: EdgeInsets.all(30),
      child: Text(
        "ULTIMA is a cutting-edge scouting and facility management platform designed to help sports clubs and training centers streamline their operations.",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Column(
      children: [
        const Text("Our features", style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Orbitron')),
        const SizedBox(height: 20),
        _featureItem("Live Scouting", "Real-time statistics during matches."),
        _featureItem("Player Database", "Manage every player profile easily."),
        _featureItem("AI Analysis", "Detailed analytics for every athlete."),
      ],
    );
  }

  Widget _featureItem(String title, String desc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A222C).withOpacity(0.6), 
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05))
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF39FF14), size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterfaceSection() {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.symmetric(vertical: 30), child: Text("Interfaces", style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Orbitron'))),
        _buildImageSection('assets/images/scoreboard.jpg'),
      ],
    );
  }

  Widget _buildWhyChooseSection() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Text("Why choose ULTIMA", style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Orbitron')),
          const SizedBox(height: 20),
          _whyItem(Icons.bolt, "Performance", "Track every move on the court."),
          _whyItem(Icons.security, "Security", "Your data is protected."),
        ],
      ),
    );
  }

  Widget _whyItem(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF00E5FF), size: 28),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(desc, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF1A222C).withOpacity(0.8), 
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.cyan.withOpacity(0.2))
      ),
      child: Column(
        children: [
          const Text("Bring ULTIMA to your facility", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          _field("Name"), _field("Facility Name"), _field("Email"), _field("Message", maxLines: 3),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, height: 55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00E5FF), 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 10,
                shadowColor: const Color(0xFF00E5FF).withOpacity(0.4)
              ),
              child: const Text("GET ULTIMA", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        maxLines: maxLines, style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint, hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
          filled: true, fillColor: const Color(0xFF0D141C),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}