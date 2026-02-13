import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool emailAlerts = true;
  bool matchUpdates = true;
  bool waterAlerts = true;

  final String userName = Supabase.instance.client.auth.currentUser?.userMetadata?['full_name'] ?? "User";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF142B2B), Color(0xFF0D141C)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("SETTINGS", 
            style: TextStyle(color: Colors.white, letterSpacing: 4, fontSize: 16, fontWeight: FontWeight.w300)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person_outline, color: Color(0xFF00E5FF)),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome back!", 
                      style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16)),
                    const SizedBox(height: 5),
                    Text(userName, 
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              // 👤 User Account Section
              _buildSectionHeader(Icons.person, "User Account", const Color(0xFF00E5FF)),
              _buildSettingsCard(
                child: Column(
                  children: [
                    _buildProfileInput("Full Name", userName),
                    _buildProfileInput("Email Address", Supabase.instance.client.auth.currentUser?.email ?? ""),
                    _buildProfileInput("Account Role", "Player", isReadOnly: true),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔔 Notifications Section (Neon Green Theme)
              _buildSectionHeader(Icons.notifications, "Notifications", const Color(0xFF39FF14)),
              _buildSettingsCard(
                child: Column(
                  children: [
                    _buildSwitchTile("Email Alerts", emailAlerts, (val) => setState(() => emailAlerts = val)),
                    _buildSwitchTile("Match Updates", matchUpdates, (val) => setState(() => matchUpdates = val)),
                    _buildSwitchTile("Low Water Alerts", waterAlerts, (val) => setState(() => waterAlerts = val)),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 💾 Save Changes Button (Cyan ULTIMA)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E5FF), // ✅ Raja3neh Cyan
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 10,
                    shadowColor: const Color(0xFF00E5FF).withOpacity(0.4),
                  ),
                  child: const Text("SAVE CHANGES", 
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ),

              const SizedBox(height: 20),

              // 🚪 Logout Button (Modern Style)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await AuthService().signOut();
                    if (context.mounted) Navigator.pushReplacementNamed(context, '/');
                  },
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  label: const Text("LOGOUT ACCOUNT", 
                    style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.redAccent.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              
              const SizedBox(height: 100), 
            ],
          ),
        ),
      ),
    );
  }

  // Helper UI Components
  Widget _buildSectionHeader(IconData icon, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A222C).withOpacity(0.7),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: child,
    );
  }

  Widget _buildProfileInput(String label, String value, {bool isReadOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: value,
            readOnly: isReadOnly,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF0D141C),
              contentPadding: const EdgeInsets.all(15),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
      value: value,
      activeColor: const Color(0xFF39FF14), 
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}