import 'package:flutter/material.dart';
import 'package:bussola_app/core/theme/app_theme.dart';
import 'package:bussola_app/features/auth/login_page.dart';
import 'package:bussola_app/features/auth/register_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo1.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Text('Bússola do Bolso', style: TextStyle(color: Colors.white)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: const Text(
              'Acesse o sistema',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegisterPage()));
            },
            child: const Text(
              'Cadastre‑se',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Algo novo vem aí.',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Prepare-se para transformar sua relação com o dinheiro.\n\nNa Bússola do Bolso, oferecemos dicas práticas de orçamento, estratégias de poupança e insights de investimento para que você alcance seus objetivos financeiros com confiança.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
