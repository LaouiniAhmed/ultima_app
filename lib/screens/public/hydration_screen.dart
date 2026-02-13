import 'dart:math' as math;
import 'package:flutter/material.dart';

class HydrationScreen extends StatefulWidget {
  const HydrationScreen({super.key});

  @override
  State<HydrationScreen> createState() => _HydrationScreenState();
}

class _HydrationScreenState extends State<HydrationScreen> with SingleTickerProviderStateMixin {
  double waterLevel = 0.0; 
  int totalMl = 0;
  final int goalMl = 2500;
  late AnimationController _controller;

  // Data mta3 el jem3a (Static l'ayyam elli fetet, w dynamic lyoum)
  List<double> weeklyData = [0.4, 0.7, 0.5, 0.8, 0.0, 0.0, 0.0]; 
  int todayIndex = 4; // Nafbtardhou el youm houwa el Friday (Index 4)

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addWater(int ml, double percent) {
    setState(() {
      totalMl += ml;
      waterLevel = (totalMl / goalMl).clamp(0.0, 1.0);
      // 🔗 Marbouta b'edoura: El bar mta3 lyoum tetbadel m3a el waterLevel
      weeklyData[todayIndex] = waterLevel; 
    });
  }

  void resetWater() {
    setState(() {
      totalMl = 0;
      waterLevel = 0.0;
      weeklyData[todayIndex] = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Hydration Tracker", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.refresh, color: Colors.redAccent), onPressed: resetWater),
            ],
          ),
          const SizedBox(height: 30),

          // --- REALISTIC WATER CIRCLE ---
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF00FFCC).withOpacity(0.2), width: 4),
              ),
              child: ClipOval(
                child: Stack(
                  children: [
                    Container(color: const Color(0xFF0D1219)),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: WavePainter(animationValue: _controller.value, waterLevel: waterLevel),
                          child: Container(),
                        );
                      },
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${(waterLevel * 100).toInt()}%", 
                            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                          Text("$totalMl / $goalMl ML", style: const TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton("+250ml", () => addWater(250, 0.1)),
              _actionButton("+500ml", () => addWater(500, 0.2)),
              _actionButton("+750ml", () => addWater(750, 0.3)),
            ],
          ),

          const SizedBox(height: 40),

          // --- DYNAMIC WEEKLY CHART ---
          const Text("Weekly Intake Tracker", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildDynamicChart(),
        ],
      ),
    );
  }

  Widget _buildDynamicChart() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return Container(
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1219),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(days.length, (index) {
          bool isToday = index == todayIndex;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // El Bar elli tatla3 w tahbet
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 15,
                height: 100 * weeklyData[index], // Tetbadel m3a el me
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isToday 
                      ? [const Color(0xFF00FFCC), const Color(0xFF006655)]
                      : [Colors.white10, Colors.white10],
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: isToday ? [BoxShadow(color: const Color(0xFF00FFCC).withOpacity(0.3), blurRadius: 8)] : [],
                ),
              ),
              const SizedBox(height: 10),
              Text(days[index], style: TextStyle(color: isToday ? Colors.white : Colors.white38, fontSize: 10)),
            ],
          );
        }),
      ),
    );
  }

  Widget _actionButton(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1A222C),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF00FFCC).withOpacity(0.3)),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }
}

// Painter mta3 el Realistic Water (Sine Wave)
class WavePainter extends CustomPainter {
  final double animationValue;
  final double waterLevel;
  WavePainter({required this.animationValue, required this.waterLevel});

  @override
  void paint(Canvas canvas, Size size) {
    if (waterLevel <= 0.005) return; // 0% ma n-sawrou chay

    Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xFF00FFCC).withOpacity(0.7), const Color(0xFF004433)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path path = Path();
    double baseHeight = size.height * (1 - waterLevel);
    double amplitude = 8.0; 

    path.moveTo(0, baseHeight);
    for (double i = 0; i <= size.width; i++) {
      path.lineTo(i, baseHeight + math.sin((i / size.width * 2 * math.pi) + (animationValue * 2 * math.pi)) * amplitude);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}