import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Cronometro: um widget SEM estado (StatelessWidget).
// Ele recebe um número de segundos e apenas "desenha" o tempo formatado
// no padrão MM:SS. Como nada muda por aqui, não precisa de State.
// ---------------------------------------------------------------------
class Cronometro extends StatelessWidget {
  const Cronometro({super.key, required this.segundos});

  // Quantidade de segundos recebida do widget pai.
  final int segundos;

  @override
  Widget build(BuildContext context) {
    // Divisão inteira com `~/`: 125 ~/ 60 = 2 (minutos inteiros).
    final minutos = segundos ~/ 60;

    // Resto da divisão: 125 % 60 = 5 (segundos que sobraram).
    final segundosRestantes = segundos % 60;

    // padLeft(2, '0') garante duas casas: 2 vira "02" e 5 vira "05".
    final textoTempo =
        '${minutos.toString().padLeft(2, '0')}:'
        '${segundosRestantes.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.timer_outlined),
        title: Text(
          textoTempo,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$segundos segundos'),
      ),
    );
  }
}
