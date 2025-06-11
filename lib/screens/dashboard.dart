
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome to Cystella", style: GoogleFonts.shantellSans(
          fontSize: 30,
          
        ),),
      ),
    );
  }
}