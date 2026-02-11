import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const VeteranApp());
}

class VeteranApp extends StatelessWidget {
  const VeteranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veteran App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
