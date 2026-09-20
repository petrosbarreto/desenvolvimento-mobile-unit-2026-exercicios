// Testes de widget básicos para o aplicativo anatomia_app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:anatomia_app/main.dart';
import 'package:anatomia_app/widgets/contador_de_cliques.dart';

void main() {
  testWidgets('ContadorDeCliques incrementa, decrementa e zera', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ContadorDeCliques())),
    );

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('-1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    await tester.tap(find.text('Zerar'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Botão flutuante incrementa o contador da tela inicial', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsWidgets);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('1'), findsWidgets);
  });
}
