import 'package:flutter/material.dart';
import 'package:ultima_application/navigation/custom_bottom_nav.dart'; // 👈 Import jdid

class AlmusScreen extends StatefulWidget {
  const AlmusScreen({super.key});

  @override
  State<AlmusScreen> createState() => _AlmusScreenState();
}

class _AlmusScreenState extends State<AlmusScreen> {
  // 1. Create ScrollController bech el BottomNav t-fhem wa9teh tetkhabba
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
        // Na77ina el Drawer khater walla 3ana Bottom Nav
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("ALMUS", style: TextStyle(color: Colors.white, letterSpacing: 5)),
          centerTitle: true,
        ),
        // 2. Nest3mlou Stack bech el BottomNav t-koun floating mel louta
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController, // 👈 Nadhi el controller hna
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildHeroWithGradient("assets/images/hydration.jpg"),
                  const SizedBox(height: 20),
                  _buildQuoteButton(),
                  const SizedBox(height: 30),
                  _buildTextSection(
                    "A hydration solution designed for your facility",
                    "ALMUS offers a smart, sustainable way to keep your environment hydrated with premium quality and intelligent tracking.",
                  ),
                  _buildImageCard("assets/images/water.png", height: 400),
                  const SizedBox(height: 40),
                  _buildSectionHeader("Why choose ALMUS"),
                  _buildImageCard("assets/images/water1.jpg", height: 250),
                  const SizedBox(height: 15),
                  _buildFeatureCard("Eco-friendly design", "Reducing plastic waste significantly."),
                  _buildFeatureCard("Smart monitoring", "Track usage and filter health in real-time."),
                  _buildFeatureCard("Premium filtration", "Ensuring the purest water quality."),
                  const SizedBox(height: 40),
                  _buildSectionHeader("Flavorful hydration options"),
                  _buildImageCard("assets/images/water3.jpg", height: 300),
                  _buildFlavorGrid(),
                  const SizedBox(height: 40),
                  _buildSectionHeader("How it works"),
                  const Icon(Icons.play_circle_fill, color: Color(0xFF00E5FF), size: 80),
                  const SizedBox(height: 60),
                  _buildSectionHeader("Bring ALMUS to your facility"),
                  _buildContactForm(),
                  _buildFooter(),
                  const SizedBox(height: 100), // Space bech el content may-tghatich b'el Nav Bar
                ],
              ),
            ),
            
            // 3. Floating Bottom Navigation Bar
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

  // --- El Widgets el okhra (Hero, FeatureCard, etc.) yabqaw nafs-hom ---
  // ... (Copy/Paste l-khedma mte3ek mta3 _buildHeroWithGradient, _buildFeatureCard louta)
  
  Widget _buildQuoteButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00E5FF),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
      ),
      child: const Text("Request a Quote", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _buildHeroWithGradient(String path) {
    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.black, Colors.transparent],
      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height)),
      blendMode: BlendMode.dstIn,
      child: Image.asset(path, width: double.infinity, height: 450, fit: BoxFit.cover),
    );
  }

  Widget _buildImageCard(String path, {double height = 300}) {
    return Container(
      width: double.infinity, height: height,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))]),
      child: ClipRRect(borderRadius: BorderRadius.circular(30), child: Image.asset(path, fit: BoxFit.cover)),
    );
  }

  Widget _buildTextSection(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Column(children: [Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.2)), const SizedBox(height: 15), Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.5))]),
    );
  }

  Widget _buildFeatureCard(String title, String desc) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8), padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(25), border: Border.all(color: Colors.white.withOpacity(0.08))),
      child: Row(children: [const Icon(Icons.check_circle_outline, color: Color(0xFF00E5FF), size: 28), const SizedBox(width: 15), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), Text(desc, style: const TextStyle(color: Colors.white54, fontSize: 13))]))]),
    );
  }

  Widget _buildFlavorGrid() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15, childAspectRatio: 1.5, children: [_buildFlavorCard("Lemon", Colors.yellow), _buildFlavorCard("Berry", Colors.pink), _buildFlavorCard("Mint", Colors.greenAccent), _buildFlavorCard("Orange", Colors.orange)]),
    );
  }

  Widget _buildFlavorCard(String name, Color color) {
    return Container(decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.3), width: 1.5)), child: Center(child: Text(name, style: TextStyle(color: color, fontWeight: FontWeight.bold))));
  }

  Widget _buildSectionHeader(String title) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), child: Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)));
  }

  Widget _buildContactForm() {
    return Container(
      margin: const EdgeInsets.all(25), padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: const Color(0xFF1A222C).withOpacity(0.8), borderRadius: BorderRadius.circular(35)),
      child: Column(children: [_buildField("Facility Name"), const Divider(color: Colors.white10), _buildField("Contact Person"), const Divider(color: Colors.white10), _buildField("Email"), const SizedBox(height: 30), _buildSubmitButton()]),
    );
  }

  Widget _buildField(String hint) {
    return TextField(decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white24), border: InputBorder.none), style: const TextStyle(color: Colors.white));
  }

  Widget _buildSubmitButton() {
    return Container(width: double.infinity, height: 55, decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: const Color(0xFF00E5FF)), child: const Center(child: Text("Send Request", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))));
  }

  Widget _buildFooter() {
    return const Padding(padding: EdgeInsets.symmetric(vertical: 60), child: Text("© 2026 ALMUS. Smart Hydration.", style: TextStyle(color: Colors.white12, fontSize: 11)));
  }
}