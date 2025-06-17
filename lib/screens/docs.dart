import 'package:flutter/material.dart';

class MyDocs extends StatefulWidget {
  const MyDocs({super.key});

  @override
  State<MyDocs> createState() => _MyDocsState();
}

class _MyDocsState extends State<MyDocs> {
    int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Text("You are viewing docs");
  }
}