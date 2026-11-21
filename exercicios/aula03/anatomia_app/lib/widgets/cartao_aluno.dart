import 'package:flutter/material.dart';

/// Cartão com os dados de um aluno: avatar com a inicial, nome em destaque e
/// "curso — Nº período".
class CartaoAluno extends StatelessWidget {
  const CartaoAluno({
    super.key,
    required this.nome,
    required this.curso,
    this.periodo = 5,
  });

  final String nome;
  final String curso;
  final int periodo;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(nome.isNotEmpty ? nome[0].toUpperCase() : '?'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nome, style: tema.textTheme.titleMedium),
                  Text(
                    '$curso — $periodoº período',
                    style: tema.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
