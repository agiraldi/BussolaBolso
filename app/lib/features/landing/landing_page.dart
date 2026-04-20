import 'package:flutter/material.dart';
import 'package:bussola_app/core/theme/app_theme.dart';
import 'package:bussola_app/features/auth/login_page.dart';
import 'package:bussola_app/features/auth/register_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/logo1.png',
                height: 32,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.compass_calibration, color: AppTheme.primaryColor),
              ),
            ),
            const SizedBox(width: 12),
            if (!isMobile)
              Text(
                'Bússola do Bolso',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage())),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterPage())),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.actionColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    elevation: 0,
                  ),
                  child: const Text('Começar Agora'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.primaryLightColor,
                  AppTheme.backgroundColor,
                ],
                stops: [0.0, 0.4, 0.8],
              ),
            ),
          ),
          
          // Decorative Elements (Optional)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 24.0 : size.width * 0.1,
                  vertical: isMobile ? 40.0 : 80.0,
                ),
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '✨ O controle financeiro que você merece',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Algo novo vem aí.',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontSize: isMobile ? 40 : 64,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: isMobile ? double.infinity : size.width * 0.5,
                      child: Text(
                        'Prepare-se para transformar sua relação com o dinheiro. Na Bússola do Bolso, oferecemos dicas práticas de orçamento, estratégias de poupança e insights de investimento para que você alcance seus objetivos financeiros com confiança.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 18,
                          height: 1.6,
                        ),
                        textAlign: isMobile ? TextAlign.center : TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                      children: [
                        SizedBox(
                          width: isMobile ? double.infinity : 220,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RegisterPage())),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.actionColor,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Criar Conta Gratuita', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(
                          width: isMobile ? double.infinity : 220,
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage())),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white, width: 2),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Conhecer Recursos', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                    // Features sneak peek
                    if (!isMobile)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFeatureItem(Icons.analytics_outlined, 'Análise Inteligente'),
                            const SizedBox(width: 40),
                            _buildFeatureItem(Icons.security_outlined, 'Segurança Total'),
                            const SizedBox(width: 40),
                            _buildFeatureItem(Icons.trending_up_outlined, 'Crescimento Real'),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
