# Exercício — Aula 01: O Ecossistema Mobile e o Lugar do Flutter

**Disciplina:** Desenvolvimento Mobile (F105880) — UNIT 2026
**Professor:** Petros Barreto
**Aluno:** Lucas Winicios de Oliveira Cruz

---

## Parte A — Análise de apps reais

### App: WhatsApp

| Item | Resposta |
|---|---|
| Categoria | Mensageria |
| A rolagem é fluida ou engasga? | Extremamente fluida, sem engasgos mesmo em listas imensas de conversas. |
| A aparência é igual à de outros apps do Android? | Segue fielmente os botões e diálogos padrão do sistema (Material Design ou Cupertino). |
| Funciona em modo avião? O que ainda dá para fazer? | Permite ler mensagens antigas e digitar novas, que ficam na "fila" com o ícone de relógio. |
| Abordagem que eu **chuto** | Nativo |
| Evidência do meu chute | (ver A2) |

### App: Nubank

| Item | Resposta |
|---|---|
| Categoria | Banco |
| A rolagem é fluida ou engasga? | Muito fluida, mesmo nas animações de transição e ocultação de saldo. |
| A aparência é igual à de outros apps do Android? | Identidade visual totalmente customizada e única; não usa botões genéricos do sistema. |
| Funciona em modo avião? O que ainda dá para fazer? | O aplicativo abre, mas bloqueia operações financeiras e avisa que está sem conexão. |
| Abordagem que eu **chuto** | Flutter |
| Evidência do meu chute | (ver A2) |

### App: Instagram

| Item | Resposta |
|---|---|
| Categoria | Rede Social |
| A rolagem é fluida ou engasga? | Geralmente fluida, mas pode ter leves engasgos ao carregar Reels ou mídias pesadas. |
| A aparência é igual à de outros apps do Android? | Design unificado (o app é idêntico no iOS e Android), ignorando componentes padrão do sistema. |
| Funciona em modo avião? O que ainda dá para fazer? | Exibe o cache do feed anterior e permite curtir posts (sincroniza depois). |
| Abordagem que eu **chuto** | React Native |
| Evidência do meu chute | (ver A2) |

### A2. Evidências dos palpites

* **WhatsApp (Nativo):** A inspeção através do AppBrain revela a ausência de bibliotecas ou motores cross-platform estruturais. Além disso, a ativação da opção "Mostrar limites de layout" nas Opções do Desenvolvedor do Android exibe a hierarquia padrão de Views nativas do sistema, e não o padrão unificado de tela cheia desenhado por frameworks como o Flutter.
* **Nubank (Flutter):** A evidência baseia-se em postagens de engenharia da própria empresa no portal Nubank Engineering. Lá, os desenvolvedores detalham extensivamente a arquitetura do aplicativo e o processo estrutural de migração e escalonamento da plataforma utilizando o framework Flutter para iOS e Android.
* **Instagram (React Native):** O framework React Native foi criado e é mantido pela própria Meta, empresa controladora do Instagram, e seu uso é fartamente documentado pela engenharia da companhia. Adicionalmente, a inspeção do APK do aplicativo aponta a presença do motor JavaScript responsável por intermediar a execução multiplataforma.

### A3. Teste do modo avião (Offline-first)

O WhatsApp é o que apresenta o melhor comportamento sem rede. Ele aplica uma arquitetura offline-first sólida, mantendo um banco de dados local robusto que permite ao usuário navegar, pesquisar mensagens antigas e acessar mídias baixadas livremente. O principal diferencial é a manutenção da interatividade: o usuário pode redigir e enviar novas mensagens, que ficam armazenadas em uma fila local sinalizada por um ícone de relógio, e o próprio sistema se encarrega de sincronizá-las em background assim que a conexão é restabelecida.

---

## Parte B — Escolhendo a abordagem

**B1. Startup com 2 devs, 3 meses de prazo, precisa lançar em Android e iOS**
**Abordagem:** Flutter.
**Justificativa:** O prazo restrito de três meses e o tamanho reduzido da equipe tornam obrigatória a utilização de uma base de código única para viabilizar as entregas. O custo de manutenção a longo prazo também é barateado pela centralização em Dart, superando a necessidade de ter um visual idêntico aos componentes estritos de cada plataforma.

**B2. App de edição de vídeo com filtros aplicados em tempo real**
**Abordagem:** Nativo.
**Justificativa:** A alta exigência de desempenho e a necessidade de acesso profundo ao hardware (GPU e câmera) para manipulação de pixels em tempo real tornam inviável o uso de middlewares. Ferramentas cross-platform introduziriam engasgos de processamento inaceitáveis para esse domínio, justificando equipes especializadas em Swift e Kotlin/C++.

**B3. Portal de notícias de um jornal que já tem site responsivo**
**Abordagem:** WebView.
**Justificativa:** Considerando que o visual do conteúdo independe dos componentes da plataforma e já existe uma infraestrutura web otimizada, empacotar a solução reduz o prazo de entrega a quase zero. O custo de manutenção é mínimo, pois atualizações na web refletem instantaneamente no app, não requerendo novos desenvolvimentos de interface.

**B4. App bancário com biometria e certificado armazenado no aparelho**
**Abordagem:** Nativo.
**Justificativa:** Aplicações financeiras dessa natureza exigem acesso a hardware sensível, como chaves de criptografia no Secure Enclave e APIs complexas de biometria nativa. O uso de cross-platform adicionaria vulnerabilidades e dependeria de bibliotecas de terceiros para essas integrações, elevando o custo de manutenção de segurança a um patamar de alto risco.

**B5. App interno de uma empresa, só Android, 200 funcionários em campo sem internet**
**Abordagem:** Nativo.
**Justificativa:** Sendo um projeto de plataforma única, o uso de multiplataforma perde seu principal benefício de custo. A extrema exigência de desempenho e a complexidade de gerenciar grandes volumes de dados offline em background requerem ferramentas e controle de ciclo de vida que apenas a abordagem nativa Android fornece com segurança.

**B6. Jogo 2D casual com física e placar online**
**Abordagem:** Flutter (com framework Flame).
**Justificativa:** O visual não precisa ser o da plataforma, e uma base de código única reduz drasticamente o custo de manutenção a longo prazo e o prazo de lançamento. O Flutter desenha seus próprios componentes e atende bem à exigência de desempenho para renderização 2D de jogos casuais, existindo farta disponibilidade de ferramentas para essa finalidade.

---

## Parte C — Pesquisa: migrações reais

### C1. Casos documentados de migração para Flutter

**1. Nubank**
Antes da migração, a empresa mantinha bases de código em Swift para iOS e Kotlin/Java para Android. A migração ocorreu pela necessidade de escalar as equipes, visando que qualquer desenvolvedor pudesse entregar features para ambos os sistemas simultaneamente, dada a expansão rápida dos produtos ofertados. O ganho mensurável mais citado foi o tempo de integração: os pull requests caíram de 70 minutos no nativo para 9,9 minutos no Flutter, e novas features complexas foram entregues na metade do prazo tradicional. A maior dificuldade relatada foi o esforço logístico para reescrever centenas de fluxos de telas que já funcionavam no nativo, precisando criar pontes temporárias de comunicação entre o ecossistema legado e o novo.
**Fonte:** https://building.nubank.com/scaling-with-flutter/

**2. BMW**
A montadora contava com aplicativos nativos separados (iOS e Android) que apresentavam disparidade de funcionalidades, custos altos e atrasos entre as plataformas. A decisão de migrar para Flutter objetivava garantir total paridade visual e de recursos para os usuários, independentemente do dispositivo. Eles relataram um ganho de escala brutal, conseguindo lançar o novo app My BMW em 47 países simultaneamente em menos de um ano com uma única equipe. A dificuldade relatada esbarrava na complexidade de arquitetar integrações robustas via Bluetooth e IoT com o hardware veicular, precisando assegurar alto nível de segurança e conectividade de baixo nível no cross-platform.
**Fonte:** https://flutter.dev/showcase/bmw

### C2. Abandono de stack cross-platform (O caso Airbnb e React Native)

O Airbnb adotou e posteriormente abandonou o React Native para retornar ao desenvolvimento 100% nativo.
* **Quais foram as razões alegadas?** A principal razão técnica foi o overhead gerado pela "bridge" (ponte de comunicação) do React Native, que causava perdas de desempenho inaceitáveis ao lidar com inicialização, animações e gestão de estados complexos. Ademais, alegaram a dificuldade organizacional de suportar três plataformas de código (iOS, Android e React), precisando frequentemente de engenheiros nativos para debugar erros obscuros no framework.
* **Essas razões se aplicariam também ao Flutter? Por quê?** Parcialmente. A questão da "bridge" lenta não se aplica ao Flutter, pois ele compila o código Dart diretamente para ARM nativo e cuida da própria renderização via Skia/Impeller, resolvendo os problemas de performance do React Native. Contudo, a dificuldade de integrar código num aplicativo já vastamente maduro e nativo, além de ter equipes mistas, é um problema comum a qualquer transição multiplataforma.
* **O que esse caso ensina sobre quando não usar cross-platform?** Ensina que, em organizações com altíssimo padrão de exigência de desempenho e forte cultura de animações ou integrações profundas no nível do sistema, os frameworks cross-platform perdem sua principal promessa de reduzir o custo. Em sistemas gigantes, a abstração vaza, e a manutenção do ecossistema paralelo se torna mais custosa do que gerir duas equipes nativas especializadas.
  **Fonte:** https://medium.com/airbnb-engineering/sunsetting-react-native-1868ba28e30a