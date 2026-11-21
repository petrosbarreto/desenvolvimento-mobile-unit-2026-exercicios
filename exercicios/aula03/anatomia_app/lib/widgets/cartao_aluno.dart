import 'package:flutter/material.dart';

/// Cartão com os dados de um aluno: avatar com a inicial, nome em destaque e
/// "curso — Nº período".
///
/// Bônus: o cartão é tocável (mostra uma SnackBar) e favoritável (estrela que
/// alterna). Por isso deixou de ser Stateless: ele precisa lembrar se está
/// favoritado.
class CartaoAluno extends StatefulWidget {
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
  State<CartaoAluno> createState() => _CartaoAlunoState();
}

class _CartaoAlunoState extends State<CartaoAluno> {
  bool _favorito = false;

  void _alternarFavorito() {
    setState(() {
      _favorito = !_favorito;
    });
  }

  void _mostrarAluno() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${widget.nome} — ${widget.curso}')));
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return InkWell(
      onTap: _mostrarAluno,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                child: Text(
                  widget.nome.isNotEmpty ? widget.nome[0].toUpperCase() : '?',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.nome, style: tema.textTheme.titleMedium),
                    Text(
                      '${widget.curso} — ${widget.periodo}º período',
                      style: tema.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _alternarFavorito,
                tooltip: _favorito
                    ? 'Remover dos favoritos'
                    : 'Adicionar aos favoritos',
                icon: Icon(
                  _favorito ? Icons.star : Icons.star_border,
                  color: _favorito ? tema.colorScheme.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
