// ---------------------------------------------------------------------
// Arquivo principal do aplicativo. Aqui fica a "raiz" do app: o widget
// que o Flutter recebe para começar a desenhar tudo na tela.
//
// O import abaixo carrega o "Material Design": a coleção de componentes
// visuais prontos do Flutter (Scaffold, AppBar, Card, botões, etc.).
// ---------------------------------------------------------------------
import 'package:flutter/material.dart';

// Importa os widgets que criamos separados na pasta lib/widgets/.
import 'widgets/cartao_aluno.dart';
import 'widgets/contador_de_cliques.dart';
import 'widgets/cronometro.dart';

// ---------------------------------------------------------------------
// `void main()`:
// É a função de partida (ponto de entrada) do programa.
// Em Dart, todo programa começa a rodar por aqui. O Flutter procura essa
// função primeiro: sem `main`, o aplicativo não executa.
// O `void` informa que essa função não devolve nenhum valor para quem a
// chamou.
// ---------------------------------------------------------------------
void main() {
  // ---------------------------------------------------------------------
  // `runApp(const MyApp())`:
  // Entrega o widget raiz para o Flutter e coloca o aplicativo no ar.
  // O runApp pega o widget que passamos (MyApp) e o torna a primeira
  // coisa da árvore de widgets, disparando o primeiro `build`.
  // O `const` diz que esse MyApp é constante (imutável): ele nunca muda
  // depois de criado, então o Flutter pode reutilizá-lo economizando
  // memória.
  // ---------------------------------------------------------------------
  runApp(const MyApp());
}

// ---------------------------------------------------------------------
// `class MyApp extends StatelessWidget`:
// MyApp é o widget raiz do aplicativo e é "Stateless" — sem estado.
// Ele não guarda nenhuma informação que muda com o tempo: a única coisa
// que faz é "configurar" o app (título, tema e tela inicial). Como a
// configuração não muda, ele não precisa de uma classe State.
// ---------------------------------------------------------------------
class MyApp extends StatelessWidget {
  // Construtor. O `super.key` é a chave usada pelo Flutter para
  // identificar o widget na árvore; é uma boa prática sempre enviá-la.
  const MyApp({super.key});

  // ---------------------------------------------------------------------
  // `Widget build(BuildContext context)`:
  // Todo widget define um `build`, que devolve o que deve ser desenhado.
  // O `context` é o "endereço" do widget dentro da árvore: com ele
  // conseguimos ler o tema, a navegação e outros dados do ambiente.
  // ---------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // ---------------------------------------------------------------------
    // `return MaterialApp(...)`:
    // Retorna o MaterialApp, o widget que dá ao app o visual Material
    // Design — é ele quem organiza o tema, a navegação entre telas e a
    // tela inicial.
    // ---------------------------------------------------------------------
    return MaterialApp(
      title: 'Anatomia do Flutter',
      theme: ThemeData(
        // Cor principal do app. A partir dessa semente o Flutter monta
        // todas as outras cores do tema (botões, AppBar, textos...).
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // ---------------------------------------------------------------------
      // `home: const MyHomePage(...)`:
      // Define qual widget aparece quando o app abre. O `home` diz:
      // "assim que iniciar, mostre o MyHomePage". Também é `const`,
      // pois a configuração da tela inicial não muda.
      // ---------------------------------------------------------------------
      home: const MyHomePage(title: 'Anatomia do Flutter'),
    );
  }
}

// ---------------------------------------------------------------------
// `class MyHomePage extends StatefulWidget`:
// MyHomePage é um widget COM estado. Repare que ele tem DUAS classes:
//
//  1. A classe do widget (esta) guarda apenas a CONFIGURAÇÃO — os dados
//     que o pai passa, como o `title`. Esses dados não mudam.
//  2. A classe State (logo abaixo) guarda o ESTADO — os dados que mudam
//     durante o uso do app, como o `_counter`.
//
// Separar as duas coisas permite que o Flutter reconstrua o widget sem
// perder o estado atual.
// ---------------------------------------------------------------------
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // ---------------------------------------------------------------------
  // `final String title`:
  // Um campo imutável do widget. Ele chega pelo construtor, passado
  // pelo pai (em `home: ...`) e nunca mais muda — por isso é `final`.
  // Em Dart, todo campo de uma classe Widget deve ser `final`.
  // ---------------------------------------------------------------------
  final String title;

  // ---------------------------------------------------------------------
  // `State<MyHomePage> createState()`:
  // Método que o Flutter chama para criar a classe State da tela.
  // Note que o tipo de retorno é `State<MyHomePage>`, e a implementação
  // devolve o `_MyHomePageState` (que é um State<MyHomePage>).
  // ---------------------------------------------------------------------
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// ---------------------------------------------------------------------
// `class _MyHomePageState extends State<MyHomePage>`:
// É a segunda classe do StatefulWidget. O `_` no início a torna privada
// (só existe dentro deste arquivo). É ela que guarda o estado mutável
// (`_counter`) e o método `build`. Quando o estado muda, o Flutter
// chama o `build` de novo para redesenhar a tela com os novos valores.
// ---------------------------------------------------------------------
class _MyHomePageState extends State<MyHomePage> {
  // ---------------------------------------------------------------------
  // `int _counter = 0`:
  // O contador do exemplo padrão do Flutter. Ele é um campo de ESTADO e,
  // por isso, mora na classe State: muda durante a execução do app.
  // O `_` no início diz que a variável é privada (visível apenas
  // dentro deste arquivo).
  // ---------------------------------------------------------------------
  int _counter = 0;

  void _incrementCounter() {
    // ---------------------------------------------------------------------
    // `setState(() { _counter++; })`:
    // Avisa o Flutter que o estado mudou. Ele marca o widget como
    // "precisa ser reconstruído" e chama o `build` novamente, mostrando
    // na tela o novo valor. Sem o `setState`, o `_counter` mudaria na
    // memória, mas a interface continuaria mostrando o valor antigo.
    // ---------------------------------------------------------------------
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ---------------------------------------------------------------------
    // O Scaffold é a "estrutura" de uma tela no Material Design: ele
    // organiza a AppBar, o corpo (body) e o botão flutuante. Pense nele
    // como o esqueleto de uma página.
    // ---------------------------------------------------------------------
    return Scaffold(
      // ---------------------------------------------------------------------
      // `appBar: AppBar(title: Text(widget.title))`:
      // A AppBar é a barrinha de cima da tela. O seu `title` recebe um
      // Text. Repare em `widget.title`: dentro da classe State, a
      // palavra `widget` é a referência para a classe Widget que deu
      // origem a este State — assim conseguimos ler o `title` que o pai
      // passou lá em cima.
      // ---------------------------------------------------------------------
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // O corpo da tela. Como o conteúdo é maior do que a tela, o
      // SingleChildScrollView deixa o usuário rolar a coluna para baixo.
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------------------------------------------------------------
            // Exemplo padrão do Flutter, mantido funcional: mostra quantas
            // vezes o botão flutuante (FloatingActionButton) foi apertado.
            // ---------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'Você pressionou o botão flutuante este número '
                    'de vezes:',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            const Divider(),
            const _SectionTitle('1. ContadorDeCliques'),
            const ContadorDeCliques(),
            const SizedBox(height: 8),
            const Divider(),
            const _SectionTitle('2. Cronometro'),
            const Cronometro(segundos: 0),
            const Cronometro(segundos: 42),
            const Cronometro(segundos: 125),
            const SizedBox(height: 8),
            const Divider(),
            const _SectionTitle('3. CartaoAluno'),
            // Período não informado: usa o padrão 5.
            const CartaoAluno(
              nome: 'Adriely Martins',
              curso: 'Sistemas de Informação',
            ),
            const CartaoAluno(
              nome: 'Natasha Andrade',
              curso: 'Engenharia de Software',
              periodo: 3,
            ),
            const CartaoAluno(
              nome: 'Ana Beatriz',
              curso: 'Ciência da Computação',
              periodo: 7,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      // ---------------------------------------------------------------------
      // O FloatingActionButton é aquele botão circular flutuante típico
      // do Material Design, posicionado no canto da tela.
      // ---------------------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        // ---------------------------------------------------------------------
        // `onPressed: _incrementCounter`:
        // Recebe a FUNÇÃO que será executada quando o botão for
        // pressionado. Repare que passamos apenas o nome da função
        // (_incrementCounter) sem chamá-la: se escrevêssemos
        // `_incrementCounter()` (com parênteses), a função seria
        // executada na hora da construção — e o `void` que ela devolve
        // não serve como "ação ao pressionar" (veja o erro B1).
        // ---------------------------------------------------------------------
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// Widget auxiliar (privado) usado no corpo da tela: apenas mostra um
// título de seção, deixando a interface mais organizada.
// ---------------------------------------------------------------------
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        texto,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
