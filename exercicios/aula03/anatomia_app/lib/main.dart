import 'package:flutter/material.dart';

import 'widgets/cartao_aluno.dart';
import 'widgets/contador_de_cliques.dart';
import 'widgets/cronometro.dart';

// void main(): é a porta de entrada do programa. Quando o app abre, o Dart
// procura esta função e começa a executar por ela.
void main() {
  // runApp(const MyApp()): entrega o widget MyApp ao Flutter e diz "esta é a
  // raiz da tela". A partir daqui, o Flutter desenha tudo o que estiver dentro
  // dele.
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget: MyApp é o widget que configura o app
// inteiro. É Stateless porque ele não guarda nenhum dado que mude com o tempo.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Widget build(BuildContext context): é o método que o Flutter chama para
  // saber "o que desenhar". Ele devolve a árvore de widgets deste pedaço da
  // tela. O context indica onde este widget está dentro da árvore.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(...): o MaterialApp é a "moldura" do app. Ele aplica o
    // tema (cores e fontes no estilo Material) e define qual é a primeira tela.
    return MaterialApp(
      title: 'Anatomia App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(...): diz qual tela aparece primeiro quando o
      // app abre, e passa para ela o texto que vai no título.
      home: const MyHomePage(title: 'Anatomia de um projeto Flutter'),
    );
  }
}

// class MyHomePage extends StatefulWidget: é a tela principal. Ela é Stateful
// porque tem algo que muda enquanto o app está aberto (o contador do botão +).
// Esta classe guarda só a configuração que vem de fora; o que muda fica na
// classe de estado, mais abaixo.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // final String title: o título recebido de quem criou a tela. É final porque,
  // depois de criado, ele não muda; se precisar de outro título, o Flutter cria
  // um widget novo.
  final String title;

  // State<MyHomePage> createState(): o Flutter chama este método uma vez, ao
  // colocar a tela na árvore, para criar o objeto que vai guardar o estado
  // dela (_MyHomePageState).
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// class _MyHomePageState extends State<MyHomePage>: é a classe que guarda os
// dados que mudam e que desenha a tela. Ela continua viva mesmo quando o
// widget MyHomePage é recriado (por exemplo, num hot reload).
class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0: a variável que guarda quantas vezes o botão + foi
  // tocado. Começa em 0 e fica aqui, na classe de estado, porque muda.
  int _counter = 0;

  void _incrementCounter() {
    // setState(() { _counter++; }): soma 1 ao contador e avisa o Flutter que
    // o estado mudou. O Flutter então chama o build de novo e a tela mostra o
    // número novo. Sem o setState, o número muda na memória mas não na tela.
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(title: Text(widget.title)): a barra do topo da tela.
      // O texto vem de widget.title, que é o jeito de a classe de estado ler a
      // configuração guardada em MyHomePage.
      appBar: AppBar(
        backgroundColor: tema.colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Text(
            'Botão + do template tocado $_counter vez(es)',
            textAlign: TextAlign.center,
            style: tema.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'C3 — ContadorDeCliques',
            textAlign: TextAlign.center,
            style: tema.textTheme.titleMedium,
          ),
          const ContadorDeCliques(),
          const Divider(),
          Text(
            'C2 — Cronometro (125 segundos)',
            textAlign: TextAlign.center,
            style: tema.textTheme.titleMedium,
          ),
          const Cronometro(segundos: 125),
          const Divider(),
          Text(
            'C1 — CartaoAluno',
            textAlign: TextAlign.center,
            style: tema.textTheme.titleMedium,
          ),
          const CartaoAluno(
            nome: 'Sue Hellen Arruda da Silva',
            curso: 'Sistemas de Informação',
          ),
          const CartaoAluno(
            nome: 'Ana Souza',
            curso: 'Ciência da Computação',
            periodo: 3,
          ),
          const CartaoAluno(
            nome: 'Bruno Lima',
            curso: 'Engenharia de Software',
            periodo: 7,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _incrementCounter: diz qual função rodar quando o botão
        // for tocado. A função é passada SEM parênteses: estamos entregando a
        // função para ser chamada depois, no toque, e não chamando agora.
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
