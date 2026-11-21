import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meu_primeiro_app/main.dart';

void main() {
  testWidgets('contador anda de 3 em 3, muda o texto e zera', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);
    expect(find.text('Nenhum toque ainda'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
    expect(find.text('Poucos toques'), findsOneWidget);

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
    }
    expect(find.text('12'), findsOneWidget);
    expect(find.text('Muitos toques!'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.refresh));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
    expect(find.text('Nenhum toque ainda'), findsOneWidget);
  });
}
