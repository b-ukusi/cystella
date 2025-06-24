import 'package:cystella_patients/screens/appointment.dart';
import 'package:cystella_patients/screens/chat.dart';
import 'package:cystella_patients/screens/dashboard.dart';
import 'package:cystella_patients/screens/docs.dart';
import 'package:cystella_patients/screens/settings.dart';
import 'package:cystella_patients/themes/colors.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

final List<Widget> screens = [
  MyDashboard(),
  MyDocs(),
  BookAppointment(),
  ChatArea(),
  Settings()
];

class _MyHomeState extends State<MyHome> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[800],
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          onTap: (index) {
            
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          
          
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Docs'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: 'Book'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ]),
    );
  }
}
