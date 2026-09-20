# Aula 02 - Desenvolvimento Mobile (offline)

## Parte A

### A1 - Saída do `flutter doctor -v`

Saída resumida do `flutter doctor -v` executado em 19/09/2026 neste ambiente:

```text
[√] Flutter (Channel stable, 3.47.1, on Microsoft Windows [Version 10.0.26200.9457], locale en-GB)
[√] Windows Version (Windows 11 or higher, 25H2, 2009)
[!] Android toolchain - develop for Android devices (Android SDK version 37.0.0)
    X Android license status unknown.
[X] Chrome - develop for the web (Cannot find Chrome executable at .\Google\Chrome\Application\chrome.exe)
[√] Visual Studio - develop Windows apps (Visual Studio Community 2026 18.9.1)
[√] Connected device (2 available)
[√] Network resources
! Doctor found issues in 2 categories.
```

Dos quatro itens obrigatórios nesta disciplina (Flutter, Android toolchain, Network
resources e Connected device), três estão verdes. O **Android toolchain** aparece como
`[!]` por causa da verificação de licenças (ver Problema 2) e o `[X]` do Chrome **não**
bloqueia o trabalho, porque o alvo não é publicar em Flutter Web e sim rodar o app
(o Edge aparece em `flutter devices`).

### A2 - Registro dos problemas enfrentados

Resumo dos problemas reais encontrados nesta aula (detalhados na Parte D, Problemas 1
a 7): Chrome ausente; licenças do Android não reconhecidas pelo `flutter doctor`;
instalação do NDK por linha de comando; ausência de celular/emulador no momento dos
experimentos; exceção transitória do engine no hot restart; formato do protocolo
`flutter run --machine`; e id de isolate mudando após o restart.

## Parte C - Experimentos com Hot Reload e Hot Restart

**Plataforma observada:** Edge (web), via `flutter run -d edge`. Não havia emulador
Android nem dispositivo físico disponível no ambiente, então os experimentos foram
feitos na versão web do app. O app estava com o tema teal e o contador incrementando
de 3 em 3.

Aplicação dos comandos via protocolo `flutter run --machine` (appId
`281d32a6-ffd8-46d7-a9e6-02623a57f93e`). Estado do app verificado por dump do widget tree
(extensão `ext.flutter.debugDumpApp`) e cores renderizadas lidas direto dos pixels do
canvas (via Chrome DevTools Protocol).

### C1 - Hot Reload preserva o estado (r)

1. Com o app rodando e contador em **15** (5 toques), alterei temporariamente o texto
   fixo em `lib/main.dart` de `You have pushed the button this many times:` para
   `Experimento C1: texto alterado`.
2. Trigger: comando `app.restart` com `fullRestart: false` (equivale a `r`).
   Resposta da ferramenta: `Reloaded application in 580ms.` (`result.code: 0`).
3. Dump do widget tree após o reload: o texto exibido passou a ser
   **"Experimento C1: texto alterado"** e o contador permaneceu em **15**.
   Ou seja, o hot reload aplicou a mudança de código **sem perder o estado** da tela.
4. Depois, alterei o inicializador `int _counter = 0;` para `int _counter = 50;`
   (mudança temporária) e apliquei hot reload (441 ms): o contador **continuou em 50**
   os inicializadores de campo **não são reexecutados** no hot reload; o estado
   existente é preservado.
5. Alteração temporária revertida ao final.

### C2 - Mudança visual (tema) via Hot Reload

1. Alterei temporariamente o tema em `lib/main.dart`:
   `ColorScheme.fromSeed(seedColor: Colors.teal)` → `Colors.amber`.
2. Hot reload (`fullRestart: false`), `Reloaded application in 455ms.` (`code: 0`).
3. Cores reais renderizadas (pixels do canvas):

   | Elemento | Antes (teal) | Depois (amber) |
   |---|---|---|
   | Fundo do FAB Incrementar | `#005048` | `#5b4300` |
   | Fundo da AppBar (inversePrimary) | `#82d5c8` | `#e9c16c` |

   A mudança de tema foi aplicada imediatamente, sem fechar/reabrir o app, e o contador
   permaneceu no valor anterior — estado preservado de novo.
4. Reverti para `Colors.teal` + hot reload (496 ms) e as cores voltaram ao original.

### C3 - Hot Restart reinicia o estado (Shift+R)

1. Com o app mostrando contador **15** (estado vivo), alterei temporariamente o
   inicializador para `int _counter = 50;` em `lib/main.dart`.
2. Trigger: comando `app.restart` com `fullRestart: true` (equivale a `Shift+R`).
   Resposta: `Restarted application in 1,515ms.` (`code: 0`). O isolate do Dart mudou
   de id após o restart (verificado no VM service).
3. Dump do widget tree: o contador passou a mostrar **50** (o novo valor inicial do
   código). O valor anterior (15) foi **perdido**: o hot restart reexecuta o `main()`
   e recria o estado a partir do código.
4. Reverti para `int _counter = 0;` e apliquei **hot restart** (`Restarted application
   in 479ms.`): o app exibiu contador **0** e "Nenhum toque ainda" e estado zerado.

### C4 - Código novo com efeito colateral (print) via Hot Reload

1. Adicionei temporariamente `print('oi')` no início do `_incrementCounter()` (callback
   do FAB Incrementar) em `lib/main.dart`.
2. Hot reload (`fullRestart: false`), `Reloaded application in 471ms.` (`code: 0`).
3. Cliquei no FAB Incrementar: a janela/console da ferramenta `flutter run` exibiu a
   linha **`oi`** no stdout. O hot reload carregou a nova versão do método (com o print)
   e ele passou a executar no clique, sem reiniciar o app.
4. Removi o `print('oi')` ao final.

### C5 - Adicionar dependência com o app rodando

1. Com o `flutter run` ainda ativo, executei `flutter pub add intl` no diretório do
   projeto.
   Saída: `+ intl 0.20.3` / `Changed 1 dependency!`.
2. `pubspec.yaml` passou a conter `intl: ^0.20.3` (em `dependencies`).
3. Apliquei hot reload (480 ms, `code: 0`) e o app continuou funcionando normalmente:
   dump mostrou contador **3** e mensagem "Poucos toques" (estado do clique do C4
   permaneceu), confirmando que o app seguiu com a nova dependência resolvida.
4. Manter a dependência `intl` (alteração permanente pretendida pelo exercício).

### C6 - Síntese do observado

- **Hot reload (`r`)** aplica mudanças de código (textos, temas, métodos) em
  ~0,4–0,6 s e **preserva o estado** da tela (contador continuou igual), inclusive sem
  reexecutar inicializadores de campo.
- **Hot restart (`Shift+R`)** reexecuta o `main()`: recria o app, **zera/perde o estado**
  e aplica os valores iniciais do código; no Edge demorou ~0,5-1,5 s e gerou novo isolate.
- Ambos acontecem **sem fechar a janela** do app; textos e cores mudam na tela em tempo
  real e prints novos aparecem no console da ferramenta após o reload.
- Adicionar/mudar dependências (`flutter pub add`) com o app aberto é refletido pelo
  hot reload sem precisar reiniciar em volume completo.
- O app web experimentado mantém o comportamento esperado de desenvolvimento rápido
  típico dos emuladores Android/iOS.

## Parte D - Diário de bordo do ambiente

### D1 - Problemas encontrados

Fontes consultadas (registros reais):

* histórico do terminal (arquivo `ConsoleHost_history.txt` do PowerShell);
* saída atual do `flutter doctor -v` e do `flutter devices`;
* arquivos de log da sessão de execução (`run_stdout.log` do `flutter run --machine`);
* dumps do VMService usados na Parte C (`dump_stale_isolate.json`, etc.).

> Observação: onde não havia registro do tempo gasto, o campo informa a limitação em
> vez de estimar um valor que não foi medido na época.

### Problema 1

**Sistema operacional:** Microsoft Windows 11 Home (25H2, build 10.0.26200.9457) — 64-bit

**Momento:** verificação do ambiente (`flutter doctor -v`)

**Mensagem de erro (copiada, não digitada):**

```text
[X] Chrome - develop for the web (Cannot find Chrome executable at .\Google\Chrome\Application\chrome.exe)
    ! Cannot find Chrome. Try setting CHROME_EXECUTABLE to a Chrome executable.
```

**O que eu tentei que NÃO funcionou:**

* a variável `CHROME_EXECUTABLE` **não está definida** em nenhum escopo (User, Machine
  ou Process) — verificado com `[Environment]::GetEnvironmentVariable('CHROME_EXECUTABLE', ...)`.
* o histórico do terminal registra uma tentativa de `flutter run -d chrome` (linha 270),
  que não teria como abrir janela alguma, já que não há Chrome instalado.

**O que resolveu:**

* usar o **Edge** como navegador web (`flutter run -d edge`), que aparece em
  `flutter devices`; o `flutter doctor` continua acusando a Chrome ausente.

**Tempo gasto:** não cronometrado na época (o doctor foi rodado junto com as demais verificações).

**Como eu descobri:** saída do `flutter doctor -v` executado durante a análise da Parte D.

### Problema 2

**Sistema operacional:** Microsoft Windows 11 Home (25H2, build 10.0.26200.9457) 64-bit

**Momento:** verificação do ambiente (`flutter doctor -v`, estado atual)

**Mensagem de erro (copiada, não digitada):**

```text
X Android license status unknown.
  Run `flutter doctor --android-licenses` to accept the SDK licenses.
  See https://flutter.dev/to/windows-android-setup for more details.
```

**O que eu tentei que NÃO funcionou:**

* o histórico do terminal registra que `flutter doctor --android-licenses` já foi
  executado, mas o `flutter doctor` atual continua marcando "Android license status
  unknown.", mas os arquivos de licença **existem** e têm os hashes corretos em
  `...\Android\sdk\licenses\android-sdk-license` e `android-sdk-preview-license`).

**O que resolveu:**

* **nada ainda, na data de hoje.** Ao rodar `flutter doctor --android-licenses`, a
  ferramenta respondeu que a opção não é mais necessária, porque o CLI novo do Android
  substituiu o `sdkmanager`:

  ```text
  WARNING: The SDK Manager CLI tool (sdkmanager) is deprecated. Android CLI will be used instead.
  Warning: The --licenses option is no longer needed.
  ```

  Ou seja: as licenças estão aceitas nos arquivos, mas o `flutter doctor` 3.47.1 ainda
  não consegue verificá-las com o novo Android SDK 37.0.0 e o item continua `[!]`.

**Tempo gasto:** não cronometrado na época.

**Como eu descobri:** saída atual do `flutter doctor -v` + comando registrado no
histórico do terminal.

### Problema 3

**Sistema operacional:** Microsoft Windows 11 Home (25H2, build 10.0.26200.9457) 64-bit

**Momento:** instalação/configuração do Android SDK (instalação do NDK)

**Mensagem de erro (copiada, não digitada):**

```text
[o texto exato do erro não está nos registros disponíveis e só os comandos foram salvos]
```

**O que eu tentei que NÃO funcionou** (tentativas reais do histórico do terminal):

* `sdkmanager --install "ndk;28.2.13676358"`
* `cd C:\Users\nb\AppData\Local\Android\sdk\cmdline-tools\latest\bin` seguido de
  `.\sdkmanager.bat "ndk;28.2.13676358"`
* `android sdk install ndk`
* `C:\Users\nb\AppData\Local\Android\sdk\cmdline-tools\latest\bin\android.bat sdk list ndk`

**O que resolveu:**

* no fim o NDK foi instalado: a pasta
  `C:\Users\nb\AppData\Local\Android\sdk\ndk` contém hoje `28.2.13676358` e
  `30.0.15729638`, mas os registros não permitem identificar qual tentativa concluiu.

**Tempo gasto:** não cronometrado na época.

**Como eu descobri:** sequência cronológica real do histórico do terminal
`sdkmanager --install "ndk;28.2.13676358"` (sem caminho), depois
`cd ...cmdline-tools\latest\bin` + `.\sdkmanager.bat "ndk;28.2.13676358"`, depois
`android sdk install ndk` e `android.bat sdk list ndk`, intercaladas com `flutter
doctor --android-licenses` e verificações `dir` em **dois caminhos de SDK distintos**
(`C:\nb.code\Android` e `C:\Users\nb\AppData\Local\Android\sdk`) + estado atual da
pasta `...\sdk\ndk` (contém `28.2.13676358` exatamente a versão alvo das tentativas
e `30.0.15729638`).

### Problema 4

**Sistema operacional:** Microsoft Windows 11 Home (25H2, build 10.0.26200.9457) 64-bit

**Momento:** conexão do dispositivo durante a execução (Parte C experimentos)

**Mensagem de erro (copiada, não digitada):** não houve mensagem de erro e o
dispositivo Android simplesmente não estava disponível. Saída real do `flutter devices`
no momento:

```text
Found 2 connected devices:
  Windows (desktop) • windows • windows-x64    • Microsoft Windows [Version 10.0.26200.9457]
  Edge (web)        • edge    • web-javascript • Microsoft Edge 153.0.4234.32
```

**O que eu tentei que NÃO funcionou:**

* o histórico mostra que um **celular físico** já foi usado em sessão anterior
  (`flutter run -d R9XN70CESWD`); no momento da Parte C ele não estava conectado e
  não havia emulador listado.

**O que resolveu:**

* executar o app na **web (Edge)**: `flutter run -d edge`.
* **não** foi criado emulador: o pacote Emulator `37.1.11.0` está instalado no SDK, mas
  `flutter emulators` responde **"No emulators available."** (nenhum AVD criado).

**Tempo gasto:** não cronometrado na época.

**Como eu descobri:** saída do `flutter devices` + histórico do terminal
(`flutter run -d R9XN70CESWD`, `flutter run -d chrome`).

### Problema 5

**Sistema operacional:** Microsoft Windows 11 Home (25H2, build 10.0.26200.9457) — 64-bit

**Momento:** execução do aplicativo e hot restart (`fullRestart: true`) no Edge (Parte C – C3)

**Mensagem de erro (copiada, não digitada) ocorreu 2 vezes durante os restarts:**

```text
"Trying to render a disposed EngineFlutterView."
Assertion failed: org-dartlang-sdk:///lib/_engine/engine/window.dart:99:12
The following assertion was thrown during a scheduler callback:
!isDisposed
```

**O que eu tentei que NÃO funcionou:**

* nada, a exceção foi transitória e não impediu o restart.

**O que resolveu:**

* o próprio hot restart continuou e concluiu normalmente
  (`Restarted application in 1,515ms.` / `479ms.`, `result.code: 0`), e o app seguiu
  funcionando.

**Tempo gasto:** 1,515 ms e 479 ms (tempos reais do log)

**Como eu descobri:** arquivo de log da sessão `run_stdout.log` do
`flutter run --machine` (linhas do restart do C3).

### Problema 6

**Sistema operacional:** Microsoft Windows 11 Home (25H2, build 10.0.26200.9457) — 64-bit

**Momento:** execução do aplicativo e automação do `flutter run --machine` (Parte C)

**Mensagem de erro (copiada, não digitada):**

```text
[não existe mensagem de erro, o daemon simplesmente não respondia aos comandos;
nenhuma linha de resposta era emitida no stdout]
```

**O que eu tentei que NÃO funcionou:**

* enviar comandos JSON-RPC no formato `{"method":"app.restart","params":{...}}`
  (sem os colchetes); o daemon ignorava silenciosamente, inclusive comandos inválidos.

**O que resolveu:**

* seguir o formato real do protocolo: cada mensagem de entrada precisa ser uma linha
  começando com `[{` e terminando com `}]`, com **um único objeto dentro dos colchetes**
  (classe `DaemonInputStreamConverter` em `packages\flutter_tools\lib\src\daemon.dart`).
  Depois disso as respostas passaram a aparecer no log, ex.:
  `[{"id":7,"result":{"code":0,"message":""}}]`

**Tempo gasto:** não cronometrado na época.

**Como eu descobri:** comparação entre os comandos enviados (`sent.txt`) e a ausência de
resposta no `run_stdout.log`, junto com a leitura do código-fonte do Flutter SDK.

### Problema 7

**Sistema operacional:** Microsoft Windows 11 Home (25H2, build 10.0.26200.9457) — 64-bit

**Momento:** execução do aplicativo e coleta de estado via Dart VM Service após um
hot restart (Parte C)

**Mensagem de erro (copiada, não digitada) resposta real do VM service:**

```text
{"jsonrpc":"2.0","result":{"type":"Sentinel","kind":"Collected","valueAsString":"Unrecognized isolateId: 1"},"id":90758}
```

**O que eu tentei que NÃO funcionou:**

* usar o id do isolate antigo (`1`) para chamar `ext.flutter.debugDumpApp` depois do
  hot restart, o restart recria o isolate com outro id.

**O que resolveu:**

* reler a lista de isolates com `getVM` e usar o id atual (na sessão: `775` e,
  após novo restart, `1549`).

**Tempo gasto:** não cronometrado na época.

**Como eu descobri:** resposta real do VM service salva em `dump_stale_isolate.json`.

### Configuração da máquina

- **Sistema operacional:** Microsoft Windows 11 Home (25H2) detectado automaticamente
- **Versão:** 10.0.26200.9457 (64-bit) detectada automaticamente
- **RAM:** 7,3 GB total (0,2 GB livres no momento da verificação) detectada automaticamente
- **Dispositivo utilizado:** celular físico (Android, serial `R9XN70CESWD`) em sessão
  anterior (`flutter run -d R9XN70CESWD`); na Parte C foi usado **Edge (web)**
  sem emulador configurado.

Recursos do ambiente detectados automaticamente:

- Flutter `3.47.1` (stable), Dart `3.13.1`
- Android SDK `37.0.0` em `C:\Users\nb\AppData\Local\Android\sdk`
  (NDK `28.2.13676358` e `30.0.15729638`; Emulator `37.1.11.0`)
- Java: OpenJDK `25.0.2` (bundled do Android Studio em `C:\nb.code\Android Studios\jbr`)
- Visual Studio Community 2026 `18.9.1` (Windows 10 SDK `10.0.26100.0`)
- Navegador: Microsoft Edge `153.0.4234.32`

### D2 - Reflexão

**(a) Qual foi o passo mais confuso da instalação, e o que teria deixado ele mais claro?**

O passo mais confuso, pelo histórico do terminal, foi a **instalação do NDK do Android
SDK pela linha de comando**: várias tentativas diferentes foram registradas em
sequência (`sdkmanager --install "ndk;28.2.13676358"` sem caminho; depois
`sdkmanager.bat` a partir de `cmdline-tools\latest\bin`; depois
`android sdk install ndk`; depois `android.bat sdk list ndk`), intercaladas com
verificações `dir` em **dois caminhos de SDK diferentes** (`C:\nb.code\Android` e
`C:\Users\nb\AppData\Local\Android\sdk`) — indício real de incerteza sobre qual
executável usar e de qual pasta rodar. Teria deixado mais claro uma documentação
apontando o caminho exato do gerenciador
(`C:\Users\nb\AppData\Local\Android\sdk\cmdline-tools\latest\bin\sdkmanager.bat`) e a
impressão das mensagens de erro da ferramenta, que hoje não estão preservadas em
nenhum registro.

**(b) Você usou celular físico ou emulador? Por quê? Se usou emulador, quanto tempo ele levou para abrir?**

Pelo histórico do terminal, foi usado **celular físico** (Android, serial
`R9XN70CESWD`) com `flutter run -d R9XN70CESWD`. Emulador **não** foi usado: ele não
aparecia na lista de dispositivos (`flutter devices`), então a conexão do celular e,
depois, a execução em **web (Edge)** foram os caminhos reais. Como não usei emulador,
não há tempo de abertura para informar.

**(c) Quanto tempo levou o primeiro `flutter run` e quanto levou o segundo?**

O histórico original **não registrou** a duração dos `flutter run` feitos na aula. Para
não deixar em branco, medi de novo, no mesmo projeto e ambiente, **dois `flutter run -d
edge` consecutivos em 19/09/2026** (cronometrando do disparo até a linha
`Flutter run key commands` / `R Hot restart`):

```text
Primeiro flutter run: 35,3 s
Segundo flutter run:  31,3 s
```

O segundo foi um pouco mais rápido porque reaproveita o que já está em cache e o mesmo
padrão descrito na apostila ("a primeira vez demora; as seguintes, segundos"), só que
aqui, por ser web (Edge), não existe o download do Gradle que aparece no Android.