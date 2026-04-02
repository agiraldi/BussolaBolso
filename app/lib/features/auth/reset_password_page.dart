import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'services/auth_service_api.dart';

class ResetPasswordPage extends StatefulWidget {
  final String identifier;
  const ResetPasswordPage({super.key, required this.identifier});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _pinController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      await AuthServiceApi.resetPassword(
        identifier: widget.identifier,
        pin: _pinController.text.trim(),
        newPassword: _newPasswordController.text,
      );
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senha redefinida com sucesso! Você já pode fazer login.'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Voltar até a primeira tela (Login)
      Navigator.of(context).popUntil((route) => route.isFirst);
      
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll('Exception: ', 'Erro: ')),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Senha', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.lock_reset, size: 60, color: AppTheme.primaryColor),
                  const SizedBox(height: 16),
                  Text(
                    'Quase lá!',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Digite o código numérico de 6 dígitos que acabou de chegar no seu e-mail e escolha sua Nova Senha.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _pinController,
                            decoration: const InputDecoration(
                              labelText: 'Código de Recuperação (PIN)',
                              hintText: 'Ex: 123456',
                              prefixIcon: Icon(Icons.pin_outlined),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            validator: (val) {
                              if (val == null || val.length != 6) {
                                return 'O código deve conter 6 dígitos exatos.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _newPasswordController,
                            decoration: InputDecoration(
                              labelText: 'Nova Senha',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                              ),
                            ),
                            obscureText: _obscurePassword,
                            validator: (val) {
                              if (val == null || val.length < 8) return 'A senha deve ter no mínimo 8 caracteres';
                              if (!RegExp(r'[A-Z]').hasMatch(val)) return 'Deve conter pelo menos uma letra maiúscula';
                              if (!RegExp(r'[0-9]').hasMatch(val)) return 'Deve conter pelo menos um número';
                              if (!RegExp(r'[^A-Za-z0-9]').hasMatch(val)) return 'Deve conter um caractere especial';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              labelText: 'Confirmar Nova Senha',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                              ),
                            ),
                            obscureText: _obscureConfirmPassword,
                            validator: (val) {
                              if (val != _newPasswordController.text) return 'As senhas não coincidem';
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _handleReset,
                            child: _isLoading 
                                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Text('Salvar Nova Senha'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
