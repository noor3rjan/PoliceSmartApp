import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:police_smart/screens/login_screen.dart';

void main() {
  runApp(const PoliceSmartApp());
}

class PoliceSmartApp extends StatelessWidget {
  const PoliceSmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoliceSmart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.cairo().fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
