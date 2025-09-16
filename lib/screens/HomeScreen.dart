import 'package:flutter/material.dart';
// Dummy home page
class DummyHomeScreen extends StatelessWidget {
  const DummyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Welcome to Home 🎉")),
    );
  }
}