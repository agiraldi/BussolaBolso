import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bussola_app/main.dart';

void main() {
  testWidgets('Renders Landing Page correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BussolaApp());

    // Verify that the landing page title is present.
    expect(find.text('Algo novo vem aí.'), findsOneWidget);
  });
}
