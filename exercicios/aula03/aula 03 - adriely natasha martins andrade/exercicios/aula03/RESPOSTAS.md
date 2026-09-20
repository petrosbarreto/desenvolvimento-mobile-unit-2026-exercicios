# RESPOSTAS - Aula 03: Anatomia de um Projeto Flutter

Exercício desenvolvido no projeto `anatomia_app`, criado com:

```bash
flutter create --org br.edu.unit --platforms=android anatomia_app
```

---

## Parte A - Anatomia comentada

As explicações de cada elemento (`void main()`, `runApp(...)`, as classes
`MyApp`/`MyHomePage`, o `build`, o `setState`, etc.) estão escritas como
comentários dentro do próprio arquivo `lib/main.dart`. Abaixo estão as
respostas às 4 perguntas.

### 1. Por que `StatefulWidget` precisa de duas classes?

Porque ele tem dois "tipos" de informação que precisam viver apartados:

- a classe do **Widget** guarda a **configuração** imutável (o que o pai
  passa, como o `title`);
- a classe **State** guarda o **estado** que muda durante a execução
  (como o `_counter`).

Separar essas coisas permite que o Flutter **reconstrua o widget** (por
exemplo, quando o pai muda uma configuração) **sem perder o estado atual**.
Se tudo ficasse em uma classe só, o valor do contador, a posição de um
scroll etc. seriam jogados fora a cada reconstrução.

### 2. Por que `_counter` fica na classe `State` e `title` fica na classe `Widget`?

Porque um é estado e o outro é configuração:

- `_counter` **muda com o tempo** (toda vez que o usuário toca no botão),
  então é um dado de **estado** → deve ficar na **State**.
- `title` é **recebido pronto do pai** e **nunca muda** depois de definido
  → é **configuração** → deve ficar na classe **Widget**, e por isso é
  `final`.

Regra prática da aula: *dados que mudam → State; dados recebidos e fixos
→ Widget (final).*

### 3. O que o `_` no começo de `_MyHomePageState` e `_counter` significa em Dart?

O `_` torna o elemento **privado**. Em Dart, qualquer identificador
(classe, variável, método) que começa com `_` só pode ser usado **dentro
do mesmo arquivo** (neste caso, `lib/main.dart`). É uma convenção do
próprio Dart para indicar privacidade, sem precisar de palavras-chave
como `private`.

### 4. Quantas vezes `build()` pode ser chamado? O que nunca deve ficar dentro dele e por quê?

O `build()` pode ser chamado **várias vezes** durante a vida do widget:
a cada `setState`, a cada mudança de tema/tamanho de tela, na entrada de
uma nova rota, com hot reload, etc.

Por isso, o `build()` deve ser um método **"puro"**: ele só deve
"descrever" a interface. **Nunca** deve conter trabalho pesado ou
efeitos colaterais, como:

- chamadas de rede, consultas a banco de dados ou leitura de arquivos;
- cálculos longos e demorados;
- criação de objetos com valores aleatórios (que mudariam a cada build);
- `print` em excesso (só para depuração rápida).

O motivo: como `build` roda sempre que algo muda, trabalho pesado ali
deixaria o app lento e travado, a cada toque, o Flutter executaria tudo
de novo. O ideal é a interface ser **derivada** do estado atual, de forma
rápida e previsível.

---

## Parte B - Catálogo de erros

Para cada erro abaixo estão registrados: **mensagem completa, onde
apareceu, significado com palavras próprias e como foi corrigido**.

### B1 - `onPressed: _incrementCounter()`

- **Mensagem completa:**
  ```text
  The argument type 'void' can't be assigned to the parameter type 'void Function()?'.
  ```
- **Onde apareceu:** na propriedade `onPressed` do `FloatingActionButton`
  (e valeria para qualquer `onPressed`/`onTap`) em `lib/main.dart`.
- **Significado:** o `onPressed` espera receber uma **função**
  (`void Function()?`), ou seja, um "comando" que será executado **quando
  o botão for pressionado**. Ao escrever `_incrementCounter()` **com
  parênteses**, a função é **executada imediatamente**, na hora em que o
  widget é construído, e o valor devolvido por ela é `void` (nada). Então
  o Flutter recebe `void` onde era esperada uma função e o tipo não
  combina e o analisador acusa o erro.
- **Como foi corrigido:** retirando os parênteses e passando apenas a
  **referência** da função:
  ```dart
  onPressed: _incrementCounter
  ```

### B2 - Remover o `setState`, deixando só `_counter++;`

- **Mensagem completa:** nenhuma, o código **compila sem erro**.
- **Onde apareceu:** no corpo do método `_incrementCounter`.
- **Significado:** o valor de `_counter` muda na memória (`0` vira `1`,
  `2`...), mas o Flutter **não é avisado** de que algo mudou. O framework
  só redesenha os widgets que foram "marcados" pelo `setState`. Sem ele,
  a interface continua exibindo o valor antigo e o app **parece** não
  funcionar, mesmo que a variável internamente esteja atualizada.
- **Como foi corrigido:** devolvendo o `setState`:
  ```dart
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  ```

### B3 - `Text(_counter)`

- **Mensagem completa:**
  ```text
  The argument type 'int' can't be assigned to the parameter type 'String?'.
  ```
  (em versões mais recentes a mensagem pode variar levemente, mas sempre
  fala do conflito `int` → `String`)
- **Onde apareceu:** ao criar um `Text`, no corpo da tela.
- **Significado:** o `Text` espera receber uma **String** (o texto a ser
  exibido). `_counter` é um **int** (número inteiro). O número precisa ser
  **convertido** em texto antes de ser mostrado.
- **Como corrigido:** convertendo com interpolação de string (ou
  `toString()`):
  ```dart
  Text('$_counter')
  // ou:
  Text(_counter.toString())
  ```

### B4 - Colocar `children: [...]` diretamente dentro de um `Center`

- **Mensagem completa:**
  ```text
  The named parameter 'children' isn't defined.
  ```
  (função invocada à parte: `Center` não possui `children`)
- **Onde apareceu:** no `body`, tentando colocar vários widgets em um
  `Center`.
- **Significado:** o `Center` é um widget de **um filho só** e ele só
  aceita `child:`. Quem agrupa **vários** filhos é o `Column`/`Row`
  (eles aceitam `children:` como lista). O `Center` não "sabe" agrupar
  vários widgets.
- **Como foi corrigido:** colocando um `Column` dentro do `Center`:
  ```dart
  Center(
    child: Column(
      children: [ ... ],
    ),
  )
  ```

### B5 - `Row` contendo um `Text` muito grande, sem `Expanded`

- **Mensagem completa** (em execução, exibida no console de debug):
  ```text
  RenderFlex overflowed by X pixels on the right.
  ```
  (o texto aparece com listras amarelas/preto na tela em modo debug)
- **Onde apareceu:** dentro da `Row` de um `CartaoAluno` (vale para
  qualquer `Row` com conteúdo maior do que a largura).
- **Significado:** a `Row` posiciona os filhos lado a lado usando o
  tamanho **natural** de cada um. Quando o texto é mais largo do que o
  espaço disponível na tela, ele **não cabe** e "estoura" (overflow)
  o Flutter passa a desenhar o texto para fora e acusa o erro.
- **Como foi corrigido:** envolvendo o texto com `Expanded`, que faz o
  filho ocupar **apenas o espaço que sobra** na `Row`, e o texto passa a
  caber (quebrando linha, se precisar):
  ```dart
  Row(
    children: [
      Expanded(
        child: Text(nome),
      ),
    ],
  )
  ```

### B6 - Substituir o `Scaffold` por um `Center` no `home:`

- **Mensagem completa:** nenhum erro de compilação; o erro é de
  estrutura/ausência de componentes.
- **Onde apareceu:** no `home:` do `MaterialApp`.
- **Significado:** o `Scaffold` é quem **organiza a tela inteira**: ele
  fornece a `AppBar`, o `body`, o botão flutuante, a cor de fundo e os
  ajustes de área segura (SafeArea). Um `Center` sozinho apenas
  **centraliza um filho** - ele não tem `AppBar`, não tem lugar adequado
  para um corpo com a estrutura da tela. Trocar o `Scaffold` remove a
  AppBar e toda a infraestrutura da página.
- **Como foi corrigido:** mantendo o `Scaffold` como "página" (o primeiro
  widget desenhado dentro do `MaterialApp`), com o `Center`/conteúdo
  dentro do seu `body`:
  ```dart
  MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: ...),
      body: Center(child: ...),
    ),
  )
  ```

---

## Parte C - Widgets

Os widgets `CartaoAluno`, `Cronometro` e `ContadorDeCliques` foram
criados em arquivos separados em `lib/widgets/`:

| Widget          | Arquivo                              | Tipo            |
| --------------- | ------------------------------------ | --------------- |
| `CartaoAluno`   | `lib/widgets/cartao_aluno.dart`      | StatelessWidget |
| `Cronometro`    | `lib/widgets/cronometro.dart`        | StatelessWidget |
| `ContadorDeCliques` | `lib/widgets/contador_de_cliques.dart` | StatefulWidget  |

### Por que `ContadorDeCliques` precisa ser um `StatefulWidget`?

Porque ele precisa **guardar e modificar informação ao longo do tempo**:
o número de cliques muda a cada toque em `+`, em `−` e em `Zerar`. Essa
informação é **estado** e, quando muda, a interface precisa ser
redesenhada (`setState`).

O critério da aula: widgets que **mudam durante o uso** do app precisam
de `StatefulWidget` (estado + `setState`); widgets que **só recebem
dados e os exibem sem mudar** são `StatelessWidget` e é exatamente o caso
de `CartaoAluno` e `Cronometro`.

---

## Parte D - Widget Tree

Árvore de widgets do aplicativo deste exercício (a mesma estrutura do
enunciado: `Scaffold` → `appBar`/`body`/`floatingActionButton`):

```text
Scaffold
├── appBar: AppBar
│   └── title: Text(widget.title)
├── body: SingleChildScrollView
│   └── child: Column
│       ├── children: [
│       │   ├── Padding (seção do contador padrão)
│       │   │   └── child: Column
│       │   │       ├── children: [
│       │   │       │   ├── Text (frase do contador)
│       │   │       │   ├── SizedBox (espaço)
│       │   │       │   └── Text ('$_counter')
│       │   ├── Divider
│       │   ├── _SectionTitle('1. ContadorDeCliques')
│       │   │   └── child: Padding
│       │   │       └── child: Text
│       │   ├── ContadorDeCliques
│       │   │   ├── Text (número dos cliques)
│       │   │   ├── Row
│       │   │   │   ├── children: [
│       │   │   │   │   ├── IconButton - (Icons.remove)
│       │   │   │   │   ├── SizedBox (espaço)
│       │   │   │   │   └── IconButton + (Icons.add)
│       │   │   │   └── ]
│       │   │   └── TextButton ('Zerar')
│       │   │       └── child: Text
│       │   ├── Divider
│       │   ├── _SectionTitle('2. Cronometro')
│       │   ├── Cronometro (segundos: 0)
│       │   │   └── Card
│       │   │       └── child: ListTile
│       │   │           ├── leading: Icon (Icons.timer_outlined)
│       │   │           ├── title: Text ('00:00')
│       │   │           └── subtitle: Text (segundos)
│       │   ├── Cronometro (segundos: 42)
│       │   ├── Cronometro (segundos: 125)
│       │   ├── Divider
│       │   ├── _SectionTitle('3. CartaoAluno')
│       │   ├── CartaoAluno
│       │   │   └── Card
│       │   │       └── child: Padding
│       │   │           └── child: Row
│       │   │               ├── children: [
│       │   │               │   ├── CircleAvatar
│       │   │               │   │   └── child: Text (primeira letra)
│       │   │               │   ├── SizedBox (espaço)
│       │   │               │   └── Expanded
│       │   │               │       └── child: Column
│       │   │               │           ├── children: [
│       │   │               │           │   ├── Text (nome)
│       │   │               │           │   └── Text (curso Nº período)
│       │   │               │           │   ]
│       │   │               │           └── ]
│       │   │               └── ]
│       │   ├── CartaoAluno
│       │   ├── CartaoAluno
│       │   └── SizedBox (espaço final)
│       │   ]
│       └── ]
└── floatingActionButton: FloatingActionButton
    └── child: Icon (Icons.add)
```

### 1. Quais widgets recebem `child:` e quais recebem `children:`?

Recebem **`child:`** (um único filho):

- `SingleChildScrollView` → `child: Column`
- `Expanded` → `child: Column`
- `Card` → `child: Padding`
- `Padding` → `child: Row` / `Text`
- `CircleAvatar` → `child: Text`
- `FloatingActionButton` → `child: Icon`
- `AppBar` → `title: Text` (e o `Scaffold` usa `appBar:`, `body:`,
  `floatingActionButton:` todos são "slots" de um único widget)

Recebem **`children:`** (uma lista de filhos):

- `Column` → `children: [...]`
- `Row` → `children: [...]`

Resumindo: widgets de layout em grupo (`Row`, `Column`) agrupam vários
filhos; widgets "embalagem" (`Card`, `Padding`, `Center`, `Expanded`)
recebem um único filho.

### 2. Qual a função do `Expanded` dentro do `Row`?

O `Expanded` faz o filho ocupar **todo o espaço que sobra** da `Row`
(espaço flexível), em vez de usar o tamanho natural do conteúdo. Quando há
mais de um `Expanded`, o espaço total é **distribuído entre eles**. No
`CartaoAluno`, é ele que garante que o texto do nome/curso use a largura
disponível sem invadir o avatar.

### 3. O que acontece sem `Expanded` quando o texto é muito grande?

A `Row` tenta desenhar o texto com o tamanho natural dele. Se ele for
maior do que a largura disponível, o texto **não cabe**: o Flutter dá o
erro `RenderFlex overflowed by X pixels on the right` e, em modo debug, a
área fica com listras amarelas/preto. Visualmente, o conteúdo fica
cortado/estourado.

### 4. Por que usar `SingleChildScrollView` envolvendo a `Column`?

Porque a `Column` contém muito conteúdo (o exemplo do contador, os 3
widgets e os 3 cartões) e, em telas pequenas, esse conteúdo **não cabe na
altura**. O `SingleChildScrollView` permite **rolar** a tela para baixo e
ver tudo.

### 5. Qual erro ele ajuda a evitar?

O erro de **overflow vertical**:

```text
RenderFlex overflowed by X pixels on the bottom.
```

Sem o scroll, a `Column` ficaria mais alta do que a tela e o conteúdo do
final seria cortado/estourado. Com o `SingleChildScrollView`, a altura
deixa de ser "limitada" pela tela e passa a ser rolável.

### 6. `Divider` é um widget. Quais outros elementos dessa árvore poderiam ser considerados propriedades em CSS/XML em vez de widgets?

Em CSS/XML, várias coisas desta árvore seriam apenas **propriedades de
estilo/layout**, não elementos. Por exemplo:

- **Espaçamentos**: o `SizedBox` (espaço entre itens) e os `padding`/
  `margin` do `EdgeInsets`;
- **Alinhamentos**: o `Center` e o `mainAxisAlignment`/`crossAxisAlignment`
  das `Row`/`Column`;
- **Espaço entre itens de lista**: o equivalente do `Divider` em HTML é a
  tag `<hr>`, mas em CSS seria uma `border-bottom`;
- **Cores e fundos**: `backgroundColor`, `color` dos textos, `radius` do
  avatar;
- **Espaçamento/flexibilidade**: o `Expanded` seria algo como `flex: 1`;
- **Largura/altura**: os `SizedBox` com dimensão e os `EdgeInsets`.

Ou seja: o Flutter "eleva" muitas propriedades de estilo a widgets
próprios, enquanto CSS/XML costuma tratar isso como atributos.

---

### Qualidade

O projeto foi validado com:

```bash
flutter analyze
dart format .
```

Sem erros do analisador e com o código formatado.