# Respostas — Aula 02: Instalação e Configuração do Ambiente

**Nome:** Gabriel Vasconcelos Martins Paz

---

## Parte A — Ambiente verde

### A1 — flutter doctor -v

[√] Flutter (Channel stable, 3.44.9, on Microsoft Windows [versÆo 10.0.26200.9445], locale pt-BR) [271ms]
    • Flutter version 3.44.9 on channel stable at C:\flutter\src
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 6b182d2c75 (6 weeks ago), 2026-08-05 10:04:07 -0700
    • Engine revision 5a2a6a42cc
    • Dart version 3.12.2
    • DevTools version 2.57.0
    • Feature flags: enable-web, enable-linux-desktop, enable-macos-desktop, enable-windows-desktop, enable-android,
      enable-ios, cli-animations, enable-native-assets, enable-swift-package-manager, omit-legacy-version-file,
      enable-lldb-debugging, enable-uiscene-migration

[√] Windows Version (Windows 11 or higher, 25H2, 2009) [1.018ms]

[√] Android toolchain - develop for Android devices (Android SDK version 37.0.0) [5,1s]
    • Android SDK at C:\Users\Colaborador\AppData\Local\Android\sdk
    • Emulator version 37.1.11.0 (build_id 15917651) (CL:N/A)
    • Platform android-37.0, build-tools 37.0.0
    • Java binary at: C:\Program Files\Android\Android Studio\jbr\bin\java
    • Java version OpenJDK Runtime Environment (build 25.0.2+-15348964-b329.117)
    • All Android licenses accepted.

[√] Chrome - develop for the web [19ms]
    • Chrome at C:\Program Files\Google\Chrome\Application\chrome.exe

[X] Visual Studio - develop Windows apps [18ms]
    X Visual Studio not installed; this is necessary to develop Windows apps.
      Download at https://visualstudio.microsoft.com/downloads/.
      Please install the "Desktop development with C++" workload, including all of its default components

[√] Connected device (4 available) [499ms]
    • LM K200 (mobile)  • d2a6da3c • android-arm    • Android 10 (API 29)
    • Windows (desktop) • windows  • windows-x64    • Microsoft Windows [versÆo 10.0.26200.9445]
    • Chrome (web)      • chrome   • web-javascript • Google Chrome 152.0.7977.83
    • Edge (web)        • edge     • web-javascript • Microsoft Edge 153.0.4234.32

[√] Network resources [658ms]
    • All expected network resources are available.

! Doctor found issues in 1 category.

Visual Studio não está instalado, mas não é necessário — não vou desenvolver
apps de desktop Windows nesta disciplina. Os quatro itens obrigatórios
(Flutter, Android toolchain, Network resources, Connected device) estão
todos ✓.

### A2 — flutter --version e flutter devices

Flutter 3.44.9 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 6b182d2c75 (6 weeks ago) • 2026-08-05 10:04:07 -0700
Engine • hash b9499e4c25212536ba3a4eec4f5c1905fb3214fe (revision 5a2a6a42cc) (1 months ago) • 2026-07-31 18:31:59.000Z
Tools • Dart 3.12.2 • DevTools 2.57.0

Found 4 connected devices:
  LM K200 (mobile)  • d2a6da3c • android-arm    • Android 10 (API 29)
  Windows (desktop) • windows  • windows-x64    • Microsoft Windows [versÆo 10.0.26200.9445]
  Chrome (web)      • chrome   • web-javascript • Google Chrome 152.0.7977.83
  Edge (web)        • edge     • web-javascript • Microsoft Edge 153.0.4234.32

![print](./prints/app-rodando.png)

---

## Parte C — Experimentos com Hot Reload

### C1 — Aperte o botão 5×, mude um texto e salve

a numeração continuou igual com o reload, mas com o restart o contador zerou.

### C2 — Mude a cor do tema e salve

A cor só mudou quando fiz o reload manualmente (apertando `r` no terminal)

### C3 — Mude o valor inicial do contador (`= 0` → `= 100`)

nada mudou até com o reload.

### C4 — Adicione um `print('oi')` dentro do `main()`

a mensagem 'oi' apenas aparece com o hot restart. e fui avisado com ''Don't invoke 'print' in production code.''

### C5 — Rode `flutter pub add intl` com o app rodando

O terminal do `flutter pub add` mostrou o pacote sendo baixado e adicionado ao `pubspec.yaml` ("+ intl 0.20.3", "Changed 1 dependency!"). no terminal onde o `flutter run` estava ativo, nada aconteceu sozinho. foi preciso apertar `r` manualmente.

### C6 — Minha regra sobre hot reload vs hot restart

pelo que eu observei, o hot reload não reexecuta a inicialização das variáveis de estado. ele só
aplica mudanças de código sobre o estado que já existe em memória.

---

## Parte D — Diário de bordo do ambiente

### D1 — Problemas na instalação

não tive nenhum problema, tudo funcionou na primeira tentativa. só achei um pouco complexo as etapas (espelhamento do celular, as instalações e etc). usei um celular físico (LG K200/K22) conectado via cabo USB, com
Android 10 (API 29), em vez de emulador.

### D2 — Perguntas

**(a) Passo mais confuso:** nenhum foi confuso. a instalação e configuração
do ambiente foram diretas, sem travas.

**(b) Celular físico ou emulador:** usei celular físico (LG K200/K22),
conectado via cabo USB. preferi assim por evitar o consumo de recursos do emulador no PC.

**(c) Tempo do flutter run:** o primeiro `flutter run` foi bem mais lento
(compilando o projeto e instalando pela primeira vez no aparelho). Os
seguintes foram visivelmente mais rápidos.