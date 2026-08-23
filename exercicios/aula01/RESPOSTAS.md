# Respostas — Aula 01: O Ecossistema Mobile e o Lugar do Flutter

---

## Parte A — Análise de apps reais

### A1 e A2. Fichas dos Apps e Evidências

#### App 1: <Spotify>

| Item | Resposta |
|---|---|
| Categoria | Música |
| A rolagem é fluida ou engasga? | Fluida |
| A aparência é igual à de outros apps do Android? | Não |
| Funciona em modo avião? O que ainda dá para fazer? | Sim. O app ainda funciona normalmente, não engasga nem nada, porém ao tentar pesquisar músicas ele informa para checar a conexão, mas é possível escutar músicas salvas anteriormente e criar novas playlists |
| Abordagem que eu **chuto** | Nativo |
| Evidência do meu chute | Post de engenharia da própria empresa |

**Evidência concreta:** No blog oficial Spotify Engineering, o artigo "Exploring the Animation Landscape of 2023 Wrapped" relata o desafio de criar recursos visuais onde a equipe precisou desenvolver "native builds for Android and iOS", o que prova que não utilizam framework cross-platform para a interface. 
Link: https://engineering.atspotify.com/2024/01/exploring-the-animation-landscape-of-2023-wrapped

#### App 2: <Conecta Recife>

| Item | Resposta |
|---|---|
| Categoria | Serviços Públicos |
| A rolagem é fluida ou engasga? | Fluida |
| A aparência é igual à de outros apps do Android? | Sim |
| Funciona em modo avião? O que ainda dá para fazer? | Não. O app perde todas as funcionalidades, ao ligar o modo avião e tentar abrir o app, ele só fica em uma tela totalmente branca, ele só exibe elementos gráficos se você ligar o modo avião enquanto estiver já dentro dele |
| Abordagem que eu **chuto** | cross-platform |
| Evidência do meu chute | Documentação pública de contratação da equipe |

**Evidência concreta:** O aplicativo é desenvolvido pela EMPREL (Empresa Municipal de Informática). Em publicações do Diário Oficial do Município especificamente na edição de 15/01/2022, referentes à seleção da equipe técnica para atuar no Conecta Recife, o edital exigiu a contratação de profissionais para as vagas de "Programadores de Software - Full Stack React Native". Essa documentação governamental comprova qual é a stack tecnológica que sustenta o aplicativo. 
Link da fonte: https://dome.recife.pe.gov.br/upload_dome/DO_006_15_01_2022-assinado.pdf

#### App 3: <Inter>

| Item | Resposta |
|---|---|
| Categoria | Banco |
| A rolagem é fluida ou engasga? | Fluida |
| A aparência é igual à de outros apps do Android? | Não |
| Funciona em modo avião? O que ainda dá para fazer? | Não. Ao ligar o modo avião dentro do app, ainda é possível acessar algumas funcionalidades, mas a maioria precisam de internet então ele informa que voccê não está conectado a internet e precisa se conectar |
| Abordagem que eu **chuto** | cross-platform |
| Evidência do meu chute | Vagas públicas de engenharia da empresa |

**Evidência concreta:** A empresa mantém um fluxo constante de contratação para cargos de "Desenvolvedor Mobile - React Native". A escolha dessa arquitetura faz sentido para um Super App: coordenar a execução de testes de regressão e garantir a qualidade visual em dezenas de módulos diferentes (como o Inter Shop) exigiria o dobro de esforço se mantido em bases nativas separadas para iOS e Android. Também tem um repositório no GitHub da Comunidade de React Brasil: https://github.com/react-brasil/empresas-que-usam-react-no-brasil/blob/master/MOBILE.md

### A3. O teste do modo avião

O Spotify foi o que se saiu melhor nesse teste. Mesmo fechando o app e abrindo novamente, ele mantem uma rolagem fluida e ainda é possível acessar diversas funcionalidades e ouvir músicas curtidas é uma delas, então o app não perde total funcionalidade, já que eu consigo ouvir músicas mesmo sem ter feito o download delas no meu celular.

---

## Parte B — Escolhendo a abordagem

**B1. Startup com 2 devs, 3 meses de prazo, precisa lançar em Android e iOS**
- **Abordagem:** Cross-Plataform
- **Justificativa:** Devido ao tempo para o lançamento do app e quantidade de desenvoldedores, utilizando Flutter eles teriam mais chances de exito porque ao final do desenvolvimento seria gerado dos arquivos nativos, tanto para Android quanto IOS.

**B2. App de edição de vídeo com filtros aplicados em tempo real**
- **Abordagem:** Nativa
- **Justificativa:** Edição de vídeo requer desempenho máximo, e de forma nativa seria ideal para atingir isso.

**B3. Portal de notícias de um jornal que já tem site responsivo**
- **Abordagem:** WebView
- **Justificativa:** Um site de notícias costumar ser majoritariamente textual, então o WebView seria o ideal, fora que da para reaproveitar quem já sabe web

**B4. App bancário com biometria e certificado armazenado no aparelho**
- **Abordagem:** Nativa
- **Justificativa:** A abordagem nativa garante acesso a hardware de forma direta e segura aos módulos de criptografia do aparelho, eliminando a dependência de plugins de terceiros para o manuseio de certificados, principalmente quando o assunto envolve lidar diretamente com o armazenamento seguro do sistema operacional (como o Keystore no Android ou o Secure Enclave no iOS).

**B5. App interno de uma empresa, só Android, 200 funcionários em campo sem internet**
- **Abordagem:** Nativa
- **Justificativa:** Como o aplicativo é exclusivo para Android, o **tamanho e experiência da equipe** podem ser otimizados focando apenas em desenvolvedores especialistas, sem a curva de aprendizado de um framework extra, e a operação totalmente offline demanda sincronização de dados robusta e bancos locais (como o Room), onde a exigência de desempenho e estabilidade da linguagem nativa se destacam.

**B6. Jogo 2D casual com física e placar online**
- **Abordagem:** Cross-Plataform
- **Justificativa:** em um jogo o visual não precisa ser "da plataforma", porque a interface é totalmente customizada. O uso de uma ferramenta cross-platform otimiza o **tamanho e experiência da equipe**, permitindo escrever a matemática da física 2D e a integração do placar online uma única vez para ambos os sistemas.

---

## Parte C — Pesquisa: migrações reais

### C1. Migrações para Flutter

**Caso 1: Nubank**
- **Stack anterior e motivo da migração:** Usavam desenvolvimento nativo (Swift e Kotlin). Migraram para unificar equipes e acelerar o lançamento de novas features simultaneamente nas duas plataformas.
- **Ganho mensurável relatado:** Redução significativa no tempo de entrega de novas funcionalidades, permitindo que a mesma equipe criasse recursos para iOS e Android de uma só vez.
- **Dificuldade relatada:** A integração inicial do Flutter em um aplicativo nativo já enorme e complexo (o chamado cenário brownfield).
- **Fonte:** https://flutter.dev/showcase/nubank

**Caso 2: BMW**
- **Stack anterior e motivo da migração:** Equipes nativas separadas (iOS e Android), o que gerava aplicativos com recursos diferentes dependendo do sistema do usuário.
- **Ganho mensurável relatado:** Escalaram a equipe de poucos desenvolvedores para milhares de contribuidores trabalhando no mesmo código, garantindo paridade de recursos em 100% dos apps globais.
- **Dificuldade relatada:** Gerenciar a arquitetura e a padronização do código em uma escala global gigantesca.
- **Fonte:** https://flutter.dev/showcase/bmw

### C2. Abandono de cross-platform

**Empresa: Airbnb**
- **Razões alegadas para voltar ao nativo:** A equipe acabou tendo que manter três códigos (iOS, Android e React Native) em vez de um. Relataram problemas de desempenho na ponte (bridge) de comunicação do React Native, dificuldade em debugar erros específicos e instabilidade de bibliotecas de terceiros.
- **Essas razões se aplicariam ao Flutter? Por quê?** Em parte, não. O Flutter resolve o problema de desempenho da "bridge" renderizando seus próprios componentes. Porém, o desafio de integrar uma tecnologia nova dentro de um app nativo gigante (manter três códigos) seria o mesmo.
- **O que esse caso ensina sobre quando não usar cross-platform?** Ensina que não vale a pena usar cross-platform se o seu aplicativo já for gigante, se depender muito de integrações profundas com o sistema operacional ou se a sua equipe já for altamente especializada em nativo e resistente à mudança.
- **Fonte:** https://medium.com/airbnb-engineering/sunsetting-react-native-1868ba28e30a

---

## Parte D — Preparação do ambiente

**D1. Instalações**
Verifique a imagem `prints/downloads.png`

**D2. Espaço em disco**
*Verifique a imagem `prints/espaco-disco.png`*

**D3. Depuração USB**
*Verifique a imagem `prints/depuracao-usb.png`*.

### Bônus

**Saída do `flutter doctor -v`:**
```bash
[√] Flutter (Channel stable, 3.47.1, on Microsoft Windows [versÆo 10.0.22631.6199], locale pt-BR) [883ms]
    • Flutter version 3.47.1 on channel stable at C:\src\flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 6655482ec0 (4 days ago), 2026-08-19 10:07:23 -0700
    • Engine revision 5d53178869
    • Dart version 3.13.1
    • DevTools version 2.60.0
    • Feature flags: enable-web, enable-linux-desktop, enable-macos-desktop, enable-windows-desktop, enable-android,
      enable-ios, cli-animations, enable-native-assets, enable-record-use, enable-swift-package-manager,
      omit-legacy-version-file, enable-lldb-debugging, enable-uiscene-migration

[√] Windows Version (11 Home Single Language 64-bit, 23H2, 2009) [8,8s]

[!] Android toolchain - develop for Android devices (Android SDK version 36.0.0) [7,9s]
    • Android SDK at C:\Users\Eduardo\AppData\Local\Android\sdk
    • Emulator version 37.1.11.0 (build_id 15917651) (CL:N/A)
    X cmdline-tools component is missing.
      Try installing or updating Android Studio.
      Alternatively, download the tools from https://developer.android.com/studio#command-line-tools-only and make sure
      to set the ANDROID_HOME environment variable.
      See https://developer.android.com/studio/command-line for more details.
    X Android license status unknown.
      Run `flutter doctor --android-licenses` to accept the SDK licenses.
      See https://flutter.dev/to/windows-android-setup for more details.

[√] Chrome - develop for the web [572ms]
    • Chrome at C:\Program Files\Google\Chrome\Application\chrome.exe

[!] Visual Studio - develop Windows apps (SQL Server Management Studio 21 21.3.6 (June 2025)) [571ms]
    • Visual Studio at C:\Program Files\Microsoft SQL Server Management Studio 21\Release
    • SQL Server Management Studio 21 version 21.3.36212.18
    X Visual Studio is missing necessary components. Please re-run the Visual Studio installer for the "Desktop
      development with C++" workload, and include these components:
        MSVC v142 - VS 2019 C++ x64/x86 build tools
         - If there are multiple build tool versions available, install the latest
        C++ CMake tools for Windows
        Windows 10 SDK

[√] Connected device (3 available) [7,2s]
    • Windows (desktop) • windows • windows-x64    • Microsoft Windows [versÆo 10.0.22631.6199]
    • Chrome (web)      • chrome  • web-javascript • Google Chrome 151.0.7922.138
    • Edge (web)        • edge    • web-javascript • Microsoft Edge 151.0.4129.101
    ! Device RXCY902EGGA is not authorized.
      You might need to check your device for an authorization dialog.

[√] Network resources [1.664ms]
    • All expected network resources are available.
```

## Diagnóstico
**cmdline-tools component is missing:** Faltam as ferramentas de linha de comando do Android. Isso será resolvido abrindo o SDK Manager dentro do Android Studio e marcando a caixa de instalação do "Android SDK Command-line Tools".

**Android license status unknown:** Como as ferramentas de linha de comando ainda não estão instaladas, o Flutter não conseguiu verificar se os termos de uso do Android foram aceitos.

**Visual Studio is missing necessary components:** O Flutter está avisando que faltam pacotes de C++ no Visual Studio para criar aplicativos de computador (Windows Desktop). Como a disciplina é focada em Mobile (Android/iOS), esse aviso pode ser ignorado sem problemas.

**Device is not authorized:** O celular Samsung está conectado e com a depuração ligada, mas é necessário desbloquear a tela do aparelho e apertar "Permitir" na janela que pede autorização para o computador acessá-lo.