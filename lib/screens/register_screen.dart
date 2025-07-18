import 'package:cystella_patients/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _register() async {
    print('🟡 Register function triggered');
    if (_formKey.currentState!.validate()) {
      print('✅ Form validated');
      setState(() => _isLoading = true);

      final result = await AuthService().register(
      email: _emailController.text.trim(),
      first_name: firstnameController.text.trim(),
      last_name: lastnameController.text.trim(),
      contactno: _phoneController.text.trim(),
      date_of_birth: _dobController.text.trim(),
      password: _passwordController.text.trim(),
    );

      setState(() => _isLoading = false);

      if (result['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful")),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration failed")),
        );
      }
    }
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
                    "images/logo.png",
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
              Text("CYSTELLA")
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text("Welcome!",
                    style: GoogleFonts.shantellSans(fontSize: 20)),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your email" : null,
              ),
              TextFormField(
                controller: firstnameController,
                decoration: const InputDecoration(
                  labelText: "First Name",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your first name" : null,
              ),
              TextFormField(
                controller: lastnameController,
                decoration: const InputDecoration(
                  labelText: "Last Name",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your last name" : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your phone number" : null,
              ),
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: "Date of Birth (YYYY-MM-DD)",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter your date of birth" : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? "Minimum 6 characters" : null,
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
                      onPressed: _register,
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                },
                child: Text("Already have an account? Login",
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
