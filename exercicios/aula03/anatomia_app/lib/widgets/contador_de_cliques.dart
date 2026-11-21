import 'package:flutter/material.dart';

/// Contador com botões − e +, que nunca fica negativo, muda de cor conforme o
/// valor e tem um botão para zerar.
class ContadorDeCliques extends StatefulWidget {
  const ContadorDeCliques({super.key});

  @override
  State<ContadorDeCliques> createState() => _ContadorDeCliquesState();
}

class _ContadorDeCliquesState extends State<ContadorDeCliques> {
  int _valor = 0;

  void _incrementar() {
    setState(() {
      _valor++;
    });
  }

  void _decrementar() {
    // Em 0 o botão − não faz nada: o número nunca fica negativo.
    if (_valor == 0) return;
    setState(() {
      _valor--;
    });
  }

  void _zerar() {
    setState(() {
      _valor = 0;
    });
  }

  Color get _cor {
    if (_valor == 0) return Colors.grey;
    if (_valor <= 9) return Colors.blue;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '$_valor',
            style: Theme.of(context).textTheme.displayLarge
                ?.copyWith(color: _cor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filledTonal(
                onPressed: _decrementar,
                tooltip: 'Diminuir',
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 24),
              IconButton.filledTonal(
                onPressed: _incrementar,
                tooltip: 'Aumentar',
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          TextButton(onPressed: _zerar, child: const Text('Zerar')),
        ],
      ),
    );
  }
}
