import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cystella_patients/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';


class MyDocs extends StatefulWidget {
  const MyDocs({super.key});

  @override
  State<MyDocs> createState() => _MyDocsState();
}

class _MyDocsState extends State<MyDocs> {
  List<Map<String, dynamic>> messages = [];
  bool isLoading = true;
  String? patientEmail;

  @override
  void initState() {
    super.initState();
    loadEmailAndMessages(); // ✅ Load email then messages
  }

  Future<void> loadEmailAndMessages() async {
  final prefs = await SharedPreferences.getInstance();
  final storedEmail = prefs.getString('patient_email');

  print("🟡 Retrieved from SharedPreferences: $storedEmail");

  if (storedEmail != null) {
    patientEmail = storedEmail.trim();
    print("📨 Using patient email: $patientEmail");
    await fetchDoctorMessages();
  } else {
    print('⚠️ No email found in shared_preferences.');
    setState(() => isLoading = false);
  }
}


  Future<void> fetchDoctorMessages() async {
  print("📡 Fetching messages for: $patientEmail");
  if (patientEmail == null) return;

  final fetchedMessages = await AuthService().getDoctorMessages(patientEmail!);
  print("📥 Received messages: $fetchedMessages");

  setState(() {
    messages = fetchedMessages;
    isLoading = false;
  });
}
String formatTimestamp(String? raw) {
  if (raw == null) return '';
  final dt = DateTime.tryParse(raw);
  if (dt == null) return '';
  return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
}


  Future<void> launchDocument(BuildContext context, String relativeUrl) async {
  const String baseUrl = 'http://10.2.8.51:8000';
  final String fullUrl = '$baseUrl$relativeUrl';

  print('🌐 Launching via flutter_web_browser: $fullUrl');

  try {
    await FlutterWebBrowser.openWebPage(
      url: fullUrl.trim(),
      customTabsOptions: const CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        showTitle: true,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: Colors.black,
        preferredControlTintColor: Colors.white,
      ),
    );
  } catch (e) {
    print("❌ Failed to launch: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open document')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE1F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/images/profile.png", width: 24, height: 24),
                    const SizedBox(width: 20),
                    const Icon(Icons.notifications_active),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Documents from Doctor",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
            
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (messages.isEmpty)
                  Center(
                      child: Text("No messages yet.",
                          style: GoogleFonts.poppins()))
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: messages.length,
                      separatorBuilder: (_, __) =>
                          Divider(color: Colors.grey[400]),
                      itemBuilder: (context, index) {
                      final msg = messages[index];

                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Profile circle avatar or icon
                              CircleAvatar(
                                backgroundColor: Colors.pink[200],
                                radius: 20,
                                child: Icon(Icons.local_hospital, color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 12),
                              // Message content
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Doctor name
                                    Text(
                                      msg['doctor_name'] ?? '',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    // Message text
                                    Text(
                                      msg['message'] ?? '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    // Document link (if exists)
                                    if (msg['document'] != null &&
                                        msg['document'].toString().isNotEmpty)
                                      TextButton.icon(
                                        onPressed: (){
                                          print('📎 Document path: ${msg['document']}'); // <-- Add this line
                                          launchDocument(context, msg['document']);
                                        },
                                        icon: Icon(Icons.picture_as_pdf, color: Colors.pink[300]),
                                        label: Text(
                                          "View Document",
                                          style: GoogleFonts.poppins(
                                            color: Colors.pink[300],
                                            decoration: TextDecoration.underline,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    // Timestamp
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        formatTimestamp(msg['timestamp']),
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },

                    ),
                  ),
            
                const SizedBox(height: 16),
            
                // Tip section
                Text("Alerts & Notifications",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                const SizedBox(height: 10),
                Card(
                  color: Colors.pink[100],
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Hey there👋, need some guidance with the upload doc button? Worry not! Go to the period tracker app that you use and export your summary in settings. Click on Upload doc in the home screen and select that same document and that's it! Leave the rest to us.",
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
