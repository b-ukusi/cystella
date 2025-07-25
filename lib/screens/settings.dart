import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? firstName;
  String? lastName;
  String? email;
  String? gender = 'Female';
  String? location = 'Nairobi, Kenya';
  String? about = 'HER';
  String? age = '20';

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('user_first_name') ?? 'First';
      lastName = prefs.getString('user_last_name') ?? 'Last';
      email = prefs.getString('user_email') ?? 'email@example.com';
      // You can expand with real data below if you have it
      gender = prefs.getString('user_gender') ?? 'Female';
      location = prefs.getString('user_location') ?? 'Nairobi, Kenya';
      about = prefs.getString('user_about') ?? 'HER';
      age = prefs.getString('user_age') ?? '20';
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Navigate back or to login screen
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/login'); // adjust route
    }
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
              )),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.end,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        // leading: const Icon(Icons.cancel, color: Colors.black),
        title: Text("Profile",
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      buildInfoRow("Name", "$firstName $lastName"),
                      buildInfoRow("Gender", gender ?? ''),
                      buildInfoRow("Location", location ?? ''),
                      buildInfoRow("Email", email ?? ''),
                      buildInfoRow("About", about ?? ''),
                      buildInfoRow("Age", age ?? ''),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Logout",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
