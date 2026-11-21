import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App da Sue',
      theme: ThemeData(
        // B2: cor do tema diferente do padrão
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      // B1: título da AppBar com o nome completo
      home: const MyHomePage(title: 'Sue Hellen Arruda da Silva'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // B3: o contador anda de 3 em 3
  void _incrementCounter() {
    setState(() {
      _counter += 3;
    });
  }

  // B4: segundo botão, que zera o contador
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // B5: o texto muda conforme o valor do contador
    final String mensagem;
    if (_counter == 0) {
      mensagem = 'Nenhum toque ainda';
    } else if (_counter <= 9) {
      mensagem = 'Poucos toques';
    } else {
      mensagem = 'Muitos toques!';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Valor do contador:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(mensagem, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zerar',
            onPressed: _resetCounter,
            tooltip: 'Zerar',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'somar',
            onPressed: _incrementCounter,
            tooltip: 'Somar 3',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
