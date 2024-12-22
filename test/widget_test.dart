import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loto_sonore/main.dart'; // Assurez-vous que le chemin est correct

void main() {
  testWidgets('Vérification de l\'interface initiale', (WidgetTester tester) async {
    // Montez l'application principale
    await tester.pumpWidget(const LotoSonoreApp());

    // Vérifiez que le titre de l'application est affiché
    expect(find.text('Loto Sonore'), findsOneWidget);
  });

  test('Simple test pour éviter les warnings', () {
    const widget = Text('Test');
    expect(widget.data, 'Test');
  });
}