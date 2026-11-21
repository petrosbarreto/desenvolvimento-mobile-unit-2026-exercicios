import 'package:flutter/material.dart';

/// Mostra uma quantidade de segundos no formato MM:SS. Ex.: 125 → 02:05.
class Cronometro extends StatelessWidget {
  const Cronometro({super.key, required this.segundos});

  final int segundos;

  String get _formatado {
    final minutos = (segundos ~/ 60).toString().padLeft(2, '0');
    final resto = (segundos % 60).toString().padLeft(2, '0');
    return '$minutos:$resto';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          _formatado,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
