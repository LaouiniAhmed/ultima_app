import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020406), // Dark background
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Center(
                child: Text(
                  "ULTIMA",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 8),
                ),
              ),
              const SizedBox(height: 30),
              const Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("Track your performance and stay hydrated", style: TextStyle(color: Colors.grey, fontSize: 14)),
              
              const SizedBox(height: 25),

              // Current Match Card (Neon Green Style)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D141C),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Current Match", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            children: [
                              CircleAvatar(radius: 3, backgroundColor: Colors.green),
                              SizedBox(width: 5),
                              Text("LIVE", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildScoreTeam("You", "2", Colors.green),
                        _buildScoreTeam("Salma Ayari", "1", Colors.white),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _MatchDetail(label: "COURT", value: "Court 3"),
                        _MatchDetail(label: "TIME", value: "43:15"),
                        _MatchDetail(label: "TYPE", value: "Best of 3"),
                      ],
                    ),
                    const SizedBox(height: 25),
                    
                    // View Full Match Button
                    SizedBox(
                      width: 200,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/full-match'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF39FF14), // Neon Green
                          shape: const StadiumBorder(),
                          elevation: 10,
                          shadowColor: const Color(0xFF39FF14).withOpacity(0.4),
                        ),
                        child: const Text("View Full Match", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Stats Grid (Using a helper widget)
              Row(
                children: [
                  _buildStatCard("Matches", "12", "This month", Icons.calendar_today, Colors.green),
                  const SizedBox(width: 15),
                  _buildStatCard("Wins", "8", "+15 vs last month", Icons.emoji_events_outlined, Colors.cyan),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildStatCard("Active Matches", "8", "+2 from yesterday", Icons.bolt, Colors.greenAccent),
                  const SizedBox(width: 15),
                  _buildStatCard("Average Time", "45m", "Per match", Icons.timer_outlined, Colors.orangeAccent),
                ],
              ),

              const SizedBox(height: 30),
              const Text("Upcoming Matches", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),

              // Upcoming Matches List
              _buildUpcomingMatch("Today - 9:00 PM", "Court 2 - vs Ahmed Ayari"),
              _buildUpcomingMatch("Tomorrow - 3:30 PM", "Court 4 - vs Sara Ben-ali"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreTeam(String name, String score, Color color) {
    return Column(
      children: [
        Text(name, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 5),
        Text(score, style: TextStyle(color: color, fontSize: 48, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0D141C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 15),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingMatch(String time, String detail) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF0D141C),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              Text(detail, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.green),
              shape: const StadiumBorder(),
            ),
            child: const Text("Details", style: TextStyle(color: Colors.green, fontSize: 11)),
          )
        ],
      ),
    );
  }
}

class _MatchDetail extends StatelessWidget {
  final String label, value;
  const _MatchDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}