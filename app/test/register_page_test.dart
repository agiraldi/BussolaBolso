import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bussola_app/features/auth/register_page.dart';

void main() {
  group('RegisterPage Validation Tests', () {
    testWidgets('Deve exibir erro ao tentar salvar com campos vazios', (WidgetTester tester) async {
      // Aumenta o tamanho da tela para evitar erro de widget fora da tela
      tester.view.physicalSize = const Size(1200, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      // Clica no botão de cadastrar
      final button = find.text('Criar Conta');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();

      // Verifica se as mensagens de erro aparecem
      expect(find.text('Informe seu nome completo'), findsOneWidget);
      expect(find.text('Informe seu CPF'), findsOneWidget);
      expect(find.text('Informe seu e-mail'), findsOneWidget);
      expect(find.text('Informe uma senha'), findsOneWidget);
    });

    testWidgets('Deve validar e-mail incorreto', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      // Digita um e-mail inválido
      await tester.enterText(find.byType(TextFormField).at(3), 'email_invalido');
      
      final button = find.text('Criar Conta');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();

      expect(find.text('E-mail inválido'), findsOneWidget);
    });

    testWidgets('Deve validar senhas diferentes', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      // Digita senhas diferentes
      await tester.enterText(find.byType(TextFormField).at(4), 'Senha123!');
      await tester.enterText(find.byType(TextFormField).at(5), 'Senha123?');
      
      final button = find.text('Criar Conta');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();

      expect(find.text('As senhas não coincidem'), findsOneWidget);
    });
  });
}
