import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'package:ultima_application/navigation/custom_bottom_nav.dart';

class UltimaScreen extends StatefulWidget {
  const UltimaScreen({super.key});

  @override
  State<UltimaScreen> createState() => _UltimaScreenState();
}

class _UltimaScreenState extends State<UltimaScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF142B2B), Color(0xFF0D141C)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, 
        // 1. Na7ina el drawer mel blassa hedhi 🗑️
        
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          // 2. Na7ina el 'leading' (Hamburger icon) 🗑️
          automaticallyImplyLeading: false, // Dima 7ott hedhi false bch ma y-talach fleche sghira
          title: const Text("ULTIMA", 
            style: TextStyle(color: Colors.white, letterSpacing: 8, fontSize: 16, fontWeight: FontWeight.w300)),
          centerTitle: true,
        ),
        
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildHeroSection(context),
                  _buildDescriptionSection(),
                  _buildFeaturesSection(),
                  _buildContactSection(),
                  _buildFooter(),
                  
                  const SizedBox(height: 120),
                ],
              ),
            ),

            // 3. Navigation Bar dima louta
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

  // --- Helper Widgets (Nفسهم mte3ek ama nadhafna el drawer logic) ---

  Widget _buildHeroSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Choose Your Experience", 
            style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          _buildExperienceCard(
            title: "SUMMA",
            subtitle: "Padel Sports Dashboard",
            imagePath: "assets/images/summa_bg.jpg",
            lineColor: const Color(0xFF00FF00),
            onTap: () => Navigator.pushNamed(context, '/summa'),
          ),
          const SizedBox(height: 20),
          _buildExperienceCard(
            title: "ALMUS",
            subtitle: "Smart Water Station",
            imagePath: "assets/images/water.png", 
            lineColor: const Color(0xFF00E5FF),
            onTap: () => Navigator.pushNamed(context, '/almus'),
          ),
        ],
      ),
    );
  }

  // ... (Ba9i el Helper Widgets kima huma) ...
  // Nsika: Itha t7eb Logout, tnajem t-zidou icon sghira f'el AppBar 3al imin (actions) 
  // wala t-khallih f'el page 'Profile' f'el Bottom Nav.

  Widget _buildDescriptionSection() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Text(
            "ULTIMA delivers innovative healthcare products and intelligent systems designed to enhance safety, efficiency, and care quality in modern environments.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15, height: 1.6),
          ),
        ),
        _buildOutlineChip("Smart products"),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildOutlineChip("Technology"),
            const SizedBox(width: 12),
            _buildOutlineChip("Innovation"),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    return Column(
      children: [
        const SizedBox(height: 60),
        _buildSectionHeader("Designed for real healthcare challenges"),
        _buildFeatureItem("Built for professionals"),
        _buildFeatureItem("Privacy & reliability focused"),
        _buildFeatureItem("Scalable systems"),
        _buildFeatureItem("Future-ready infrastructure"),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      children: [
        const SizedBox(height: 60),
        _buildSectionHeader("Let's build safer smarter healthcare environment"),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color(0xFF1A222C).withOpacity(0.9),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Column(
              children: [
                _buildContactField("Name", "Your name"),
                _buildContactField("Company", "Facility or company name"),
                _buildContactField("Email", "your-email@example.com"),
                _buildContactField("Phone", "+216 00 000 000"),
                _buildContactField("Message", "Tell us about your facility", isLong: true),
                const SizedBox(height: 30),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard({required String title, required String subtitle, required String imagePath, required Color lineColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 230, width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: Colors.black45))),
            Positioned.fill(child: Container(color: Colors.black.withOpacity(0.35))),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 12),
                  Container(height: 4, width: 60, decoration: BoxDecoration(color: lineColor, borderRadius: BorderRadius.circular(10))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlineChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.2),
        color: Colors.white.withOpacity(0.06),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.2)),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1A222C).withOpacity(0.5), 
          borderRadius: BorderRadius.circular(20), 
          border: Border.all(color: Colors.white.withOpacity(0.05))
        ),
        child: Row(children: [
          const Icon(Icons.check_circle, color: Color(0xFF00FF00), size: 22),
          const SizedBox(width: 15),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ]),
      ),
    );
  }

  Widget _buildContactField(String label, String hint, {bool isLong = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          TextField(
            maxLines: isLong ? 4 : 1,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint, 
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 14),
              filled: true, fillColor: const Color(0xFF080E14),
              contentPadding: const EdgeInsets.all(20),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: 200, height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30), 
        boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withOpacity(0.35), blurRadius: 20, offset: const Offset(0, 6))]
      ),
      child: ElevatedButton(
        onPressed: () {}, 
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF), shape: const StadiumBorder(), elevation: 0), 
        child: const Text("Get in touch", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const Text("ULTIMA", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 6)),
          const SizedBox(height: 30),
          Text("© 2026 ULTIMA. All rights reserved.", style: TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 11)),
        ],
      ),
    );
  }
}