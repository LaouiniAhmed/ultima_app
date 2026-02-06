import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;

  void _handleResetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your email"), backgroundColor: Colors.redAccent),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Hna n3aytou l-el function mel AuthService mte3ek
      await AuthService().resetPassword(_emailController.text.trim());
      setState(() => _isSuccess = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.redAccent),
      );
    } finally {
      setState(() => _isLoading = false);
    }
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Text("ULTIMA", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 10)),
                const SizedBox(height: 40),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D141C).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: !_isSuccess ? _buildRequestForm() : _buildSuccessState(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequestForm() {
    return Column(
      children: [
        const Text("Reset Password", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text("Enter your email to receive a reset link", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 35),
        
        _buildInputLabel("Email Address"),
        _buildInputField(_emailController, "Enter your email", Icons.mail_outline),
        
        const SizedBox(height: 40),

        _buildButton(
          text: _isLoading ? "Sending..." : "Send Reset Link",
          onPressed: _isLoading ? null : _handleResetPassword,
        ),
        
        const SizedBox(height: 25),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Text("Back to login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      children: [
        const Icon(Icons.check_circle_outline, color: Color(0xFF00E5FF), size: 60),
        const SizedBox(height: 20),
        const Text("Check your email", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text("We've sent a link to ${_emailController.text}", textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 35),
        _buildButton(text: "Back to login", onPressed: () => Navigator.pop(context)),
      ],
    );
  }

  Widget _buildButton({required String text, VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: const Color(0xFF00E5FF).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: SizedBox(
        width: 200,
        height: 52,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF), shape: const StadiumBorder(), elevation: 0),
          child: Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.only(left: 4, bottom: 8), child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))));
  }

  Widget _buildInputField(TextEditingController ctrl, String hint, IconData icon) {
    return TextField(
      controller: ctrl,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4), fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.grey.withOpacity(0.4), size: 20),
        filled: true,
        fillColor: const Color(0xFF080E14),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: Colors.white.withOpacity(0.05))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Color(0xFF00E5FF))),
      ),
    );
  }
}