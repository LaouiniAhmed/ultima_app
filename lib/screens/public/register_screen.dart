import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? selectedRole;
  bool _isLoading = false;

  void _handleSignUp() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || selectedRole == null) {
      _showError("Please fill all fields and select a role");
      return;
    }
    setState(() => _isLoading = true);
    try {
      await AuthService().signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _nameController.text.trim(),
        selectedRole!,
        _phoneController.text.trim(),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account created!")));
        Navigator.pushReplacementNamed(context, '/'); 
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A1A1A), // Dark Teal mel fou9
              Color(0xFF020406), // Black louta
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const Text(
                  "ULTIMA",
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 32, 
                    fontWeight: FontWeight.bold, 
                    letterSpacing: 10
                  ),
                ),
                const SizedBox(height: 40),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D141C).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    children: [
                      const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      
                      _buildInputLabel("Full Name"),
                      _buildInputField(_nameController, "Enter your name", Icons.person_outline),
                      const SizedBox(height: 16),

                      _buildInputLabel("Email Address"),
                      _buildInputField(_emailController, "Enter your email", Icons.mail_outline),
                      const SizedBox(height: 16),

                      _buildInputLabel("Password"),
                      _buildInputField(_passwordController, "Enter your password", Icons.lock_outline, isPass: true),
                      
                      const SizedBox(height: 25),
                      const Align(
                        alignment: Alignment.centerLeft, 
                        child: Text("SELECT ROLE", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5))
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _roleCard("PLAYER", Icons.sports_tennis, 'player'),
                          const SizedBox(width: 12),
                          _roleCard("COACH", Icons.shield_outlined, 'coach'),
                        ],
                      ),

                      const SizedBox(height: 35),

                      // Sign Up Button - Fixed Width 200
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00E5FF).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: 200, 
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleSignUp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00E5FF),
                              shape: const StadiumBorder(),
                              elevation: 0,
                            ),
                            child: _isLoading 
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2)) 
                              : const Text("SIGN UP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("ALREADY HAVE AN ACCOUNT? ", style: TextStyle(color: Colors.grey, fontSize: 11)),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(context, '/'), 
                            child: const Text("LOG IN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildInputField(TextEditingController ctrl, String hint, IconData icon, {bool isPass = false}) {
    return TextField(
      controller: ctrl,
      obscureText: isPass,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4), fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.grey.withOpacity(0.4), size: 20),
        filled: true,
        fillColor: const Color(0xFF080E14),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF00E5FF)),
        ),
      ),
    );
  }

  Widget _roleCard(String label, IconData icon, String value) {
    bool active = selectedRole == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedRole = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: active ? Colors.white : const Color(0xFF141B23),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: active ? Colors.white : const Color(0xFF1E2630)),
          ),
          child: Column(
            children: [
              Icon(icon, color: active ? Colors.black : Colors.white, size: 22),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: active ? Colors.black : Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}