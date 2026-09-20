import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// ContadorDeCliques: um widget COM estado (StatefulWidget).
// O número de cliques muda a cada toque nos botões, então precisamos
// guardar esse valor em um State e redesenhar a tela com `setState`.
// ---------------------------------------------------------------------
class ContadorDeCliques extends StatefulWidget {
  const ContadorDeCliques({super.key});

  @override
  State<ContadorDeCliques> createState() => _ContadorDeCliquesState();
}

class _ContadorDeCliquesState extends State<ContadorDeCliques> {
  // Estado do widget: a quantidade atual de cliques.
  int _contador = 0;

  void _incrementar() {
    setState(() {
      _contador++;
    });
  }

  void _decrementar() {
    // Nunca deixa o número ficar negativo: só diminui se ainda for > 0.
    if (_contador > 0) {
      setState(() {
        _contador--;
      });
    }
  }

  void _zerar() {
    setState(() {
      _contador = 0;
    });
  }

  // Cor do número conforme a quantidade de cliques.
  Color _corDoNumero() {
    if (_contador == 0) {
      return Colors.grey;
    } else if (_contador >= 1 && _contador <= 9) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Número grande e centralizado.
        Text(
          '$_contador',
          style: Theme.of(context).textTheme.displayLarge
              ?.copyWith(color: _corDoNumero(), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botão - (diminui).
            IconButton.filled(
              onPressed: _decrementar,
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(width: 24),
            // Botão + (aumenta).
            IconButton.filled(
              onPressed: _incrementar,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Botão de texto para voltar ao zero.
        TextButton(onPressed: _zerar, child: const Text('Zerar')),
      ],
    );
  }
}
