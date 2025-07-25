import 'package:cystella_patients/screens/home.dart';
import 'package:cystella_patients/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;
  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedEmail();
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('patient_email', email);
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      bool success = await AuthService().login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      setState(() => _isLoading = false);

      if (success) {
        await saveEmail(_emailController.text);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHome()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed")),
        );
      }
    }
  }

  void _loadSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('user_email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE1F2),
      appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Color(0xFFFFE1F2),
          title: Column(
            children: [
              Center(
                child: Container(
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
              Text("CYSTELLA")
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text("Welcome back aboard!",
                    style: GoogleFonts.shantellSans(fontSize: 20)),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Email",
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your email" : null,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _toggleVisibility,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                // obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? "Enter your password" : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ButtonStyle(
                        // Removed iconColor as it's not a valid property for ElevatedButton
                        backgroundColor:
                            WidgetStateProperty.all(Color(0xFFFF2BA3)),
                      ),
                      onPressed: _login,
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text("Don't have an account? Register",
                    style: GoogleFonts.shantellSans(
                        decoration: TextDecoration.none, color: Colors.black)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
