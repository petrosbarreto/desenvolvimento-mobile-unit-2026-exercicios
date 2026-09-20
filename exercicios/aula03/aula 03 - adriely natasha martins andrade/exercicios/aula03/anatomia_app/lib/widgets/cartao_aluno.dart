import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// CartaoAluno: um widget SEM estado (StatelessWidget).
// Ele só recebe os dados do aluno e desenha um cartão: como esses dados
// não mudam durante o uso do app, não precisamos de uma classe State.
// ---------------------------------------------------------------------
class CartaoAluno extends StatelessWidget {
  // Construtor `const`: o cartão pode ser criado como constante.
  // Os campos obrigatórios usam `required`, e o período é opcional
  // (padrão 5).
  const CartaoAluno({
    super.key,
    required this.nome,
    required this.curso,
    this.periodo = 5,
  });

  // Campos `final`: são definidos uma única vez e nunca mudam.
  final String nome;
  final String curso;
  final int periodo;

  @override
  Widget build(BuildContext context) {
    // Usamos o tema do app em vez de fixar cores na mão. Assim o cartão
    // acompanha o visual do restante do aplicativo.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar circular com a primeira letra do nome.
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                nome.isEmpty ? '?' : nome[0].toUpperCase(),
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Expanded faz o texto ocupar o espaço que sobra no Row,
            // evitando que um nome/curso longo estoure a tela.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome em destaque (negrito e maior).
                  Text(
                    nome,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Formato: curso — Nº período.
                  Text(
                    '$curso — $periodoº período',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
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
