import 'package:flutter/material.dart';
import 'package:cystella_patients/screens/dashboard.dart';
import 'package:cystella_patients/screens/login_screen.dart';
import 'package:cystella_patients/screens/register_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print('Flutter Error: ${details.exception}');
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cystella Patient App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      
      // 👇 Starting screen
      initialRoute: '/login',

      // 👇 All screen routes
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const MyDashboard(), // your original dashboard
      },
    );
  }
}
