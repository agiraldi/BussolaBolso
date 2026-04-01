import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bussola_app/main.dart';

void main() {
  testWidgets('Renders Login Page correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BussolaApp());

    // Verify that our login page contains the welcome text.
    expect(find.text('Bem-vindo(a) de volta!'), findsOneWidget);
  });
}
