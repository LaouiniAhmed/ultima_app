import 'package:flutter/material.dart';
import 'package:ultima_application/navigation/custom_bottom_nav.dart';

class LiveMatchScreen extends StatefulWidget {
  const LiveMatchScreen({super.key});

  @override
  State<LiveMatchScreen> createState() => _LiveMatchScreenState();
}

class _LiveMatchScreenState extends State<LiveMatchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Nestamlou Container fih el Gradient kima page Ultima
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF142B2B), // Teal dhelmi
            Color(0xFF0D141C), // K7al m-zarra9
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // 👈 Hedhi lezemha transparent bch n-choufou el gradient
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("LIVE MATCH", 
            style: TextStyle(fontFamily: 'Orbitron', fontSize: 18, color: Colors.white)),
          centerTitle: true,
          actions: [
            IconButton(icon: const Icon(Icons.share, color: Colors.cyan), onPressed: () {}),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  _buildScoreboardHeader(),
                  _buildMatchView(),
                  _buildLiveStats(),
                  _buildActionButtons(),
                  
                  const SizedBox(height: 120),
                ],
              ),
            ),

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

  // --- El Helper Widgets (Ma badalt fihom chay kima t-fahmenna) ---

  Widget _buildScoreboardHeader() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF111827).withOpacity(0.8), // Zedet opacity khfifa bch i-bani el gradient louta
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _teamInfo("TEAM A", "15", true),
          const Text("VS", style: TextStyle(color: Colors.cyan, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Orbitron')),
          _teamInfo("TEAM B", "30", false),
        ],
      ),
    );
  }

  Widget _teamInfo(String name, String points, bool isLeading) {
    return Column(
      children: [
        Text(name, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 8),
        Text(points, style: TextStyle(color: isLeading ? Colors.green : Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Orbitron')),
      ],
    );
  }

  Widget _buildMatchView() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/padel2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black.withOpacity(0.3),
        ),
        child: const Center(
          child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
        ),
      ),
    );
  }

  Widget _buildLiveStats() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("MATCH STATISTICS", style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Orbitron')),
          const SizedBox(height: 20),
          _statRow("Ball Possession", 0.6, 0.4),
          _statRow("Winners", 0.7, 0.3),
          _statRow("Unforced Errors", 0.2, 0.8),
        ],
      ),
    );
  }

  Widget _statRow(String label, double valA, double valB) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${(valA * 100).toInt()}%", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text("${(valB * 100).toInt()}%", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(flex: (valA * 100).toInt(), child: Container(height: 6, color: Colors.green)),
              const SizedBox(width: 4),
              Expanded(flex: (valB * 100).toInt(), child: Container(height: 6, color: Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.analytics, size: 18),
              label: const Text("FULL STATS"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.05),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.videocam, size: 18),
              label: const Text("REPLAY"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}