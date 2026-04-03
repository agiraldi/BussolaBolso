import 'package:flutter/material.dart';
import 'package:bussola_app/core/theme/app_theme.dart';
import 'package:bussola_app/features/auth/login_page.dart';
import 'package:bussola_app/features/landing/landing_page.dart';

void main() {
  runApp(const BussolaApp());
}

class BussolaApp extends StatelessWidget {
  const BussolaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bússola do Bolso',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: LandingPage(),
    );
  }
}