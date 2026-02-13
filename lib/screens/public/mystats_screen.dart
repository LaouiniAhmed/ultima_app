import 'package:flutter/material.dart';

class MyStatsScreen extends StatelessWidget {
  const MyStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Title mel Website ---
          const Text(
            "Analytics & Reports",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif',
            ),
          ),
          const Text(
            "Deep dive into club performance and usage patterns.",
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          
          const SizedBox(height: 30),

          // --- Action Buttons (Style Export CSV) ---
          Row(
            children: [
              _buildSmallButton(Icons.filter_list, "Filter Period"),
              const SizedBox(width: 10),
              _buildSmallButton(Icons.download, "Export CSV", isGreen: true),
            ],
          ),

          const SizedBox(height: 25),

          // --- Monthly Activity Card ---
          _buildAnalyticsCard(
            title: "Monthly Activity",
            icon: Icons.trending_up,
            iconColor: Colors.greenAccent,
            child: const Center(
              child: Text(
                "No activity recorded for this period.",
                style: TextStyle(color: Colors.white24, fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- Court Usage % Card ---
          _buildAnalyticsCard(
            title: "Court Usage %",
            icon: Icons.bar_chart,
            iconColor: Colors.blueAccent,
            child: const Center(
              child: Text(
                "Waiting for booking data to analyze usage.",
                style: TextStyle(color: Colors.white24, fontSize: 12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- Member Segment Distribution ---
          _buildAnalyticsCard(
            title: "Member Segment Distribution",
            icon: Icons.pie_chart_outline,
            iconColor: Colors.purpleAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, color: Colors.white.withOpacity(0.05), size: 50),
                const SizedBox(height: 10),
                const Text(
                  "Analyze your member database growth here.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white38, fontSize: 11),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Generate Member Report", 
                    style: TextStyle(color: Color(0xFF39FF14), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper lel Cards mta3 el Website
  Widget _buildAnalyticsCard({required String title, required IconData icon, required Color iconColor, required Widget child}) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1219), // Dark style mel website
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  // Helper lel Buttons (Filter / Export)
  Widget _buildSmallButton(IconData icon, String label, {bool isGreen = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isGreen ? const Color(0xFF39FF14) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: isGreen ? Colors.black : Colors.white),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: isGreen ? Colors.black : Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}