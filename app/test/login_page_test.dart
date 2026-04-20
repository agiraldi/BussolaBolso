import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bussola_app/features/auth/login_page.dart';

void main() {
  group('LoginPage Validation Tests', () {
    testWidgets('Deve exibir erro ao tentar entrar com campos vazios', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      // Tenta fazer login
      final button = find.text('Entrar');
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pump();

      // Verifica mensagens de erro
      expect(find.text('Campo obrigatório'), findsOneWidget);
      // "Digite sua senha" aparece como label e como erro
      expect(find.text('Digite sua senha'), findsAtLeastNWidgets(1));
    });

    testWidgets('Deve alternar visibilidade da senha ao clicar no ícone', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1200, 1800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      // Encontra o campo de senha (é o segundo TextField)
      final passwordFieldFinder = find.byType(TextField).last;
      final TextField textField = tester.widget(passwordFieldFinder);
      expect(textField.obscureText, isTrue);

      // Clica no ícone de olho
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pump();

      final TextField textFieldUpdated = tester.widget(passwordFieldFinder);
      expect(textFieldUpdated.obscureText, isFalse);
    });
  });
}
