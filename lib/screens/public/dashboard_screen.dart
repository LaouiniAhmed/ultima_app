import 'package:flutter/material.dart';
import 'package:ultima_application/screens/public/mymatches_screen.dart';
import 'package:ultima_application/screens/public/mystats_screen.dart';
import 'package:ultima_application/screens/public/hydration_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // On met le fond du Scaffold en transparent pour voir le dégradé du Container
      backgroundColor: Colors.transparent, 
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // Couleurs extraites de la page Ultima
            colors: [Color(0xFF142B2B), Color(0xFF0D141C)], 
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF00FFCC), size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text("CLUB DASHBOARD", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- TABBAR WITH ICONS ---
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start, 
              indicatorColor: const Color(0xFF00FFCC),
              labelColor: const Color(0xFF00FFCC),
              unselectedLabelColor: Colors.white38,
              indicatorWeight: 3,
              labelPadding: const EdgeInsets.symmetric(horizontal: 15),
              tabs: const [
                Tab(icon: Icon(Icons.dashboard_rounded, size: 20), text: "Overview"),
                Tab(icon: Icon(Icons.sports_tennis_rounded, size: 20), text: "My Matches"),
                Tab(icon: Icon(Icons.analytics_outlined, size: 20), text: "My Stats"),
                Tab(icon: Icon(Icons.water_drop_rounded, size: 20), text: "Hydration"),
              ],
            ),

            // TabBarView: CONTENT AREA
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [ 
                  const OverviewContent(), 
                  MyMatchesScreen(), 
                  MyStatsScreen(),   
                  HydrationScreen(), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- OVERVIEW CONTENT (TABLEAUX & STATUS CARDS) ---
class OverviewContent extends StatelessWidget {
  const OverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Club Overview", 
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Real-time club performance and activity.", 
            style: TextStyle(color: Colors.white54, fontSize: 12)),
          
          const SizedBox(height: 25),

          // 1. Grid mta3 el Status Cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 1.4,
            children: [
              _buildStatCard("Active Matches", "0", Icons.access_time_filled, Colors.greenAccent),
              _buildStatCard("Available Courts", "0/0", Icons.grid_view_rounded, Colors.blueAccent),
              _buildStatCard("Today's Matches", "0", Icons.calendar_today, Colors.orangeAccent),
              _buildStatCard("Hydration Usage", "0L", Icons.water_drop, Colors.cyanAccent),
            ],
          ),

          const SizedBox(height: 25),

          // 2. Section Live Feed
          _buildSectionBox(
            title: "Live Feed",
            icon: Icons.flash_on,
            iconColor: Colors.greenAccent,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Text("No live matches in progress.", 
                  style: TextStyle(color: Colors.white24, fontSize: 13)),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // 3. Peak Hours Analysis
          _buildSectionBox(
            title: "Peak Hours Analysis",
            icon: Icons.bar_chart_rounded,
            iconColor: Colors.purpleAccent,
            child: Container(
              height: 150,
              alignment: Alignment.center,
              child: const Text("WAITING FOR USAGE DATA...", 
                style: TextStyle(color: Colors.white24, fontSize: 11, letterSpacing: 2)),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget lel Stat Cards
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A222C).withOpacity(0.7), // Harmonisé avec Ultima
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.white38, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  // Helper Widget lel Sections el kbar
  Widget _buildSectionBox({required String title, required IconData icon, required Color iconColor, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A222C).withOpacity(0.7), // Harmonisé avec Ultima
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 18),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}