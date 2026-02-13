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
  
  // 👁️ Show/Hide Password Toggle
  bool _obscurePassword = true;
  
  // 🛡️ Admin Email Detection
  bool _isAdminEmail = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_checkEmailRole);
  }

  @override
  void dispose() {
    _emailController.removeListener(_checkEmailRole);
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _checkEmailRole() {
    final email = _emailController.text.trim().toLowerCase();
    bool isDetected = email.endsWith(".uadmin@ultima.tn") && email.length > 18;
    
    if (isDetected != _isAdminEmail) {
      setState(() {
        _isAdminEmail = isDetected;
        if (!_isAdminEmail && selectedRole == 'admin') {
          selectedRole = null;
        }
      });
    }
  }

  void _handleSignUp() async {
    // 🧹 Clean inputs to avoid "Wrong Password" bugs
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || selectedRole == null) {
      _showError("Please fill all fields and select a role");
      return;
    }
    
    if (selectedRole == 'admin' && !_isAdminEmail) {
      _showError("Invalid admin email format");
      return;
    }

    setState(() => _isLoading = true);
    try {
      await AuthService().signUp(
        email,
        password,
        name,
        selectedRole!,
        phone,
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
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating)
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
            colors: [Color(0xFF0A1A1A), Color(0xFF020406)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const Text(
                  "ULTIMA",
                  style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 10),
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
                      // 👁️ Password field with Eye Toggle
                      _buildPasswordField(),
                      
                      const SizedBox(height: 25),
                      const Align(
                        alignment: Alignment.centerLeft, 
                        child: Text("SELECT ROLE", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5))
                      ),
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          _roleCard("PLAYER", Icons.sports_tennis, 'player'),
                          const SizedBox(width: 10),
                          _roleCard("COACH", Icons.shield_outlined, 'coach'),
                          if (_isAdminEmail) ...[
                            const SizedBox(width: 10),
                            _roleCard("ADMIN", Icons.admin_panel_settings, 'admin'),
                          ],
                        ],
                      ),

                      const SizedBox(height: 35),
                      _buildSignUpButton(),
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

  // 👁️ Custom Password Field with Toggle
  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration("Create a password", Icons.lock_outline).copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey.withOpacity(0.4),
            size: 20,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController ctrl, String hint, IconData icon) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(hint, icon),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4), fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.grey.withOpacity(0.4), size: 20),
      filled: true,
      fillColor: const Color(0xFF080E14),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.white.withOpacity(0.05))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Color(0xFF00E5FF))),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: (selectedRole == 'admin' ? Colors.amber : const Color(0xFF00E5FF)).withOpacity(0.3),
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
            backgroundColor: selectedRole == 'admin' ? Colors.amber : const Color(0xFF00E5FF),
            shape: const StadiumBorder(),
          ),
          child: _isLoading 
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2)) 
            : const Text("SIGN UP", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
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

  Widget _roleCard(String label, IconData icon, String value) {
    bool active = selectedRole == value;
    Color activeColor = (value == 'admin') ? Colors.amber : Colors.white;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedRole = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: active ? activeColor : const Color(0xFF141B23),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: active ? activeColor : const Color(0xFF1E2630)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: active ? Colors.black : Colors.white, size: 20),
              const SizedBox(height: 8),
              Text(label, style: TextStyle(color: active ? Colors.black : Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}