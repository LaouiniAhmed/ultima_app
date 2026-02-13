import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomBottomNav extends StatefulWidget {
  final ScrollController scrollController;
  const CustomBottomNav({super.key, required this.scrollController});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisible) setState(() => _isVisible = false);
      } else {
        if (!_isVisible) setState(() => _isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // 📐 El height mte3ek kima hiya b'el SafeArea
      height: _isVisible ? (MediaQuery.of(context).padding.bottom + 70) : 0, 
      child: Wrap(
        children: [
          Container(
            width: double.infinity, 
            decoration: BoxDecoration(
              color: const Color(0xFF030708).withOpacity(0.98),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05), width: 0.5)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 15)
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 1. Home -> Ultima
                  _navItem(Icons.home_filled, "Home", '/ultima', const Color(0xFF39FF14), currentRoute),
                  
                  // 2. Live -> Live Match
                  _navItem(Icons.sports_tennis_outlined, "Live", '/live-match', const Color.fromARGB(255, 234, 246, 1), currentRoute),
                  
                  // 3. Dashboard -> Stats
                  _navItem(Icons.space_dashboard_rounded, "Dashboard", '/dashboard', const Color.fromARGB(255, 31, 205, 74), currentRoute),
                  
                  // 4. Booking -> New Page
                  _navItem(Icons.calendar_month, "Booking", '/booking', const Color.fromARGB(255, 0, 255, 229), currentRoute),
                  
                  // 5. Settings -> Profile (Route badal'ha /profile kima 9otli)
                  _navItem(Icons.settings_outlined, "Settings", '/profile', const Color(0xFF00E5FF), currentRoute),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, String route, Color activeColor, String? currentRoute) {
    bool isActive = currentRoute == route;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isActive) Navigator.pushNamed(context, route);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 12), 
          decoration: BoxDecoration(
            color: isActive ? activeColor.withOpacity(0.12) : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isActive ? activeColor : Colors.transparent, 
                width: 3
              )
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Icon(
                icon,
                color: isActive ? activeColor : Colors.white24,
                size: 26,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? activeColor : Colors.white24,
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}