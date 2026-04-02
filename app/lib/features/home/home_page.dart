import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/services/local_storage_service.dart';
import '../auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  Future<void> _logout() async {
    await LocalStorageService.removeToken();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bússola Bolso', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Sair da conta e apagar Sessão',
            onPressed: _logout,
          )
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Lançamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 0) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                 decoration: BoxDecoration(
                   color: AppTheme.primaryLightColor.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(16),
                   border: Border.all(color: AppTheme.primaryColor.withOpacity(0.5))
                 ),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     const Icon(Icons.verified_user, color: AppTheme.primaryColor),
                     const SizedBox(width: 8),
                     const Text('Sessão Ativa com Segurança', 
                         style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                   ],
                 ),
              ),
              const SizedBox(height: 48),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/em_breve.jpg',
                  width: 320,
                  fit: BoxFit.cover,
                  errorBuilder: (context, e, s) => Container(
                    height: 100,
                    color: Colors.grey[200],
                    child: const Center(child: Text("Imagem em_breve não encontrada")),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Text(
          'Aba $_currentIndex: Em desenvolvimento...',
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
  }
}
