import 'package:anatomia_app/main.dart';
import 'package:anatomia_app/widgets/cartao_aluno.dart';
import 'package:anatomia_app/widgets/contador_de_cliques.dart';
import 'package:anatomia_app/widgets/cronometro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _emTela(Widget filho) => MaterialApp(home: Scaffold(body: filho));

void main() {
  testWidgets('o app abre com o título da tela', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Anatomia de um projeto Flutter'), findsOneWidget);
  });

  testWidgets('Cronometro formata 125 segundos como 02:05', (tester) async {
    await tester.pumpWidget(_emTela(const Cronometro(segundos: 125)));
    expect(find.text('02:05'), findsOneWidget);
  });

  testWidgets('CartaoAluno mostra inicial, nome e período padrão', (
    tester,
  ) async {
    await tester.pumpWidget(
      _emTela(const CartaoAluno(nome: 'ana', curso: 'Sistemas')),
    );
    expect(find.text('A'), findsOneWidget);
    expect(find.text('ana'), findsOneWidget);
    expect(find.text('Sistemas — 5º período'), findsOneWidget);
  });

  testWidgets('Bônus: CartaoAluno favorita e mostra SnackBar ao tocar', (
    tester,
  ) async {
    await tester.pumpWidget(
      _emTela(const CartaoAluno(nome: 'Ana', curso: 'Sistemas')),
    );
    expect(find.byIcon(Icons.star_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.star_border));
    await tester.pump();
    expect(find.byIcon(Icons.star), findsOneWidget);

    await tester.tap(find.text('Ana'));
    await tester.pump();
    expect(find.text('Ana — Sistemas'), findsOneWidget);
  });

  testWidgets('ContadorDeCliques não fica negativo, soma e zera', (
    tester,
  ) async {
    await tester.pumpWidget(_emTela(const ContadorDeCliques()));
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.text('Zerar'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
