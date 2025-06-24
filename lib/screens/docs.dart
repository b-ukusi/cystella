import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDocs extends StatefulWidget {
  const MyDocs({super.key});

  @override
  State<MyDocs> createState() => _MyDocsState();
}

class _MyDocsState extends State<MyDocs> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            
            children: [
              ClipRRect(
                child: Image.asset("images/image.png", width: 24, height: 24),
              ),
              SizedBox(width: 20),
              Icon(Icons.notifications_active)
            ],
          ),
          Text(
            "Documents from Doctor",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              ClipRRect(
                child: Image.asset(
                  "images/image.png",
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Doctor Celine",
                      style: GoogleFonts.poppins(fontSize: 12)),
                  Text("Hey Boyani, find your medical report attached below.",
                      style: GoogleFonts.poppins(fontSize: 11))
                ],
              )
            ],
          ),
          Divider(
            color: Colors.grey[400],
            height: 4,
          ),
          Row(
            children: [
              ClipRRect(
                child: Image.asset(
                  "images/image.png",
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Doctor Celine",
                      style: GoogleFonts.poppins(fontSize: 12)),
                  Text("Hey Boyani, find your medical report attached below.",
                      style: GoogleFonts.poppins(fontSize: 11))
                ],
              )
            ],
          ),
          Divider(
            color: Colors.grey[400],
            height: 4,
          ),
          SizedBox(
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Alerts & Notifications",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
                  SizedBox(height:50),
              Center(child: Text("No notifications yet"))
            ],
          )
        ],
      ),
    );
  }
}
