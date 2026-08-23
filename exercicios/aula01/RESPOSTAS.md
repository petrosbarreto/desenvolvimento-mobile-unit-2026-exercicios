# Exercício — Aula 01: O Ecossistema Mobile e o Lugar do Flutter

**Aluno:** Luis Fernando Ferreira dos Santos  
**Disciplina:** Desenvolvimento Mobile — F105880  
**Professor:** Petros Barreto  
**Instituição:** Universidade Tiradentes — UNIT  
**Período:** 2026.2  

---

## Parte A — Análise de aplicativos reais

### App: Mercado Pago

| Item | Resposta |
| --- | --- |
| Categoria | Finanças e pagamentos |
| A rolagem é fluida ou engasga? | A rolagem é fluida na tela inicial, no extrato e nas listas de transações. Durante o meu teste, percebi um pequeno atraso enquanto as informações financeiras eram carregadas. |
| A aparência é igual à de outros apps do Android? | Não completamente. Botões, cartões, ícones e menus seguem a identidade visual do Mercado Pago, embora alguns campos e diálogos utilizem padrões visuais do Android. |
| Funciona em modo avião? O que ainda dá para fazer? | Funciona de maneira bastante limitada. O aplicativo abre e pode exibir elementos da interface e algumas informações carregadas anteriormente, mas não atualiza o saldo nem permite realizar Pix, transferências, pagamentos ou outras operações que dependem da comunicação com os servidores. |
| Abordagem que eu **chuto** | Nativo, possivelmente com uma arquitetura modular. |
| Evidência do meu chute | Ativei a opção “Mostrar limites de layout” e percebi que as abas, os cartões, os botões e os itens do menu inferior aparecem separados. Por isso, acredito que o app seja principalmente nativo. [`prints/mercado-pago-layout-bounds.png`](prints/mercado-pago-layout-bounds.png). |

### App: Mercado Livre

| Item | Resposta |
| --- | --- |
| Categoria | Comércio eletrônico e marketplace |
| A rolagem é fluida ou engasga? | A rolagem geralmente é fluida na página inicial e nas listas de produtos. Pequenos atrasos podem ocorrer durante o carregamento de muitas imagens, anúncios e recomendações. |
| A aparência é igual à de outros apps do Android? | Não. O aplicativo utiliza identidade visual própria, com botões, cartões, cores e componentes característicos do Mercado Livre. |
| Funciona em modo avião? O que ainda dá para fazer? | Funciona parcialmente por causa do conteúdo armazenado em cache. Algumas telas, imagens e produtos acessados anteriormente podem continuar visíveis, mas a pesquisa, a atualização de preços e estoque, as perguntas aos vendedores e a finalização da compra dependem da internet. |
| Abordagem que eu **chuto** | Nativo, com uma arquitetura modular e possível utilização de diferentes tecnologias em módulos específicos. |
| Evidência do meu chute | No teste, o Android marcou separadamente o campo de busca, as categorias, os banners, os produtos e o menu inferior. Meu palpite é que o Mercado Livre use desenvolvimento nativo, possivelmente dividido em vários módulos. [`prints/mercado-livre-layout-bounds.png`](prints/mercado-livre-layout-bounds.png). |

### App: 99

| Item | Resposta |
| --- | --- |
| Categoria | Mobilidade urbana, entregas e pagamentos |
| A rolagem é fluida ou engasga? | A navegação e a movimentação do mapa geralmente são fluidas. Podem ocorrer atrasos quando o aplicativo recalcula a localização, atualiza o mapa ou procura motoristas. |
| A aparência é igual à de outros apps do Android? | Não completamente. O aplicativo possui componentes próprios, cartões e painéis sobre o mapa, enquanto permissões de GPS, câmera e notificações utilizam diálogos nativos do Android. |
| Funciona em modo avião? O que ainda dá para fazer? | Funciona de maneira muito limitada. O aplicativo pode abrir, identificar a localização pelo GPS e mostrar partes do mapa armazenadas anteriormente, mas não consegue consultar preços, localizar motoristas disponíveis, calcular a rota completa nem solicitar uma corrida. |
| Abordagem que eu **chuto** | Nativo, possivelmente com arquitetura modular e componentes compartilhados. |
| Evidência do meu chute | O mapa aparece como uma área maior, enquanto os campos de endereço, botões, banners e menus aparecem separados. Como o app também depende bastante de GPS e mapas, acredito que seja principalmente nativo. [`prints/99-layout-bounds.png`](prints/99-layout-bounds.png). |

### Comparação do funcionamento sem internet

**Aplicativo que apresentou o melhor comportamento sem rede:**  
Mercado Livre.

**Diferença observada:**  
O Mercado Livre apresentou o melhor comportamento sem conexão porque conseguiu reaproveitar parte do conteúdo armazenado em cache, como produtos, imagens e telas acessadas anteriormente. Mercado Pago e 99 também abriram partes da interface, mas suas funções principais dependem de dados atualizados em tempo real: operações financeiras no Mercado Pago e consulta de motoristas, preços e corridas na 99.

---

## Parte B — Escolhendo a abordagem

### B1 — Startup com dois desenvolvedores e três meses de prazo

**Abordagem escolhida:** Flutter.

**Justificativa:**  
Eu escolheria Flutter porque a equipe tem apenas dois desenvolvedores e precisa entregar para Android e iOS em três meses. Com uma base de código compartilhada, seria possível reduzir o trabalho duplicado e o custo de manutenção. A equipe teria que aprender Dart, mas acredito que ainda seria mais viável do que desenvolver dois aplicativos separados.

### B2 — Aplicativo de edição de vídeo com filtros em tempo real

**Abordagem escolhida:** Nativo.

**Justificativa:**  
Eu escolheria desenvolvimento nativo porque aplicar filtros em vídeos em tempo real exige muito desempenho e acesso direto à GPU e à câmera. Kotlin e Swift oferecem mais controle sobre os recursos de cada sistema. Mesmo sendo mais caro manter dois projetos, nesse caso o desempenho é mais importante.

### B3 — Portal de notícias com site responsivo

**Abordagem escolhida:** WebView.

**Justificativa:**  
Eu escolheria WebView porque o jornal já tem um site responsivo e poderia reaproveitar o conteúdo existente. Isso reduziria o tempo e o custo do projeto, já que o app seria principalmente para leitura de notícias. A experiência pode não ficar tão integrada ao celular, mas atende bem ao cenário apresentado.

### B4 — Aplicativo bancário com biometria e certificado no aparelho

**Abordagem escolhida:** Nativo.

**Justificativa:**  
Eu escolheria nativo porque um aplicativo bancário precisa acessar biometria, certificados e áreas seguras do aparelho. Essa abordagem permite usar diretamente os recursos de segurança do Android e do iOS. O desenvolvimento será mais caro, mas, para um banco, segurança e confiabilidade devem ter prioridade.

### B5 — Aplicativo interno, somente Android e usado sem internet

**Abordagem escolhida:** Nativo.

**Justificativa:**  
Eu escolheria nativo porque o aplicativo será usado somente em aparelhos Android. Assim, a equipe poderá trabalhar diretamente com o banco local, GPS, câmera e recursos necessários para funcionar sem internet. Como existe apenas uma plataforma, não vejo muita vantagem em utilizar uma solução multiplataforma.

### B6 — Jogo 2D casual com física e placar on-line

**Abordagem escolhida:** Flutter.

**Justificativa:**  
Eu escolheria Flutter porque se trata de um jogo 2D casual, que não exige o mesmo desempenho de um jogo 3D mais pesado. A biblioteca Flame pode ajudar com física, animações e colisões, enquanto o Flutter permite lançar para Android e iOS. Se o jogo ficasse mais complexo, seria necessário avaliar uma engine específica.

---

## Parte C — Pesquisa sobre migrações reais

### C1.1 — Empresa que migrou para Flutter: caso 1

**Empresa:** Nubank.  
**Tecnologia anterior:** O aplicativo utilizava uma combinação de Objective-C e Swift no iOS, Java e Kotlin no Android, além de partes em React Native.

**Motivação para a migração:** O Nubank precisava lançar novos produtos com mais rapidez sem depender de equipes separadas para Android e iOS. Depois de testar algumas alternativas, escolheu Flutter pelo compartilhamento de código, hot reload, suporte a testes e facilidade para novos desenvolvedores contribuírem no aplicativo.  

**Ganho mensurável:** Segundo o Nubank, a taxa de sucesso dos merges ficou 30% melhor com Flutter. Os pull requests levavam, em média, 9,9 minutos para serem integrados, enquanto a média geral das plataformas era de 70,45 minutos. Outro resultado foi o lançamento do seguro de vida em três meses, bem mais rápido que produtos anteriores.

**Dificuldades encontradas:** A principal dificuldade foi migrar um aplicativo grande que já usava várias tecnologias. Durante a transição, o Nubank precisou manter partes nativas, React Native e Flutter funcionando juntas. Também foi necessário adaptar as ferramentas de build e testes e criar uma equipe para ajudar os outros desenvolvedores.

**Fonte:** [Scaling Nubank’s mobile development with Flutter — Building Nubank](https://building.nubank.com/scaling-with-flutter/).

### C1.2 — Empresa que migrou para Flutter: caso 2

**Empresa:** BMW Group.

**Tecnologia anterior:** A BMW mantinha aplicativos nativos separados para iOS e Android, incluindo os aplicativos BMW Connected e MINI Connected. O desenvolvimento tinha maior foco no iOS, o que provocou diferenças de funcionalidades e design em relação ao Android.

**Motivação para a migração:** A BMW percebeu que seus aplicativos para Android e iOS estavam ficando diferentes, principalmente porque o desenvolvimento tinha mais foco no iOS. A empresa precisava manter as mesmas funções em várias marcas e mais de 45 países sem dobrar o tamanho das equipes. Por isso, decidiu reescrever os aplicativos com Flutter.  

**Ganho mensurável:** O novo aplicativo foi lançado em menos de um ano e chegou a 47 países. A plataforma criada pela BMW passou a gerar, testar e distribuir automaticamente 96 variações em cada build. Até outubro de 2021, mais de 10 mil versões de cada variante já tinham sido produzidas.

**Dificuldades encontradas:** No início, a BMW ainda tinha dúvidas se Flutter seria maduro o suficiente para um projeto desse tamanho. A empresa também precisou juntar equipes que antes trabalhavam separadas e criar uma estrutura própria para build, testes e distribuição das diferentes versões.  

**Fonte:** [Scaling customer-centric product development at BMW Group with Flutter](https://flutter.dev/showcase/bmw).

### C2 — Empresa que abandonou uma tecnologia cross-platform

**Empresa:** Airbnb.  
**Tecnologia abandonada:** React Native.

**Razões apresentadas:**  
O Airbnb adicionou React Native a um aplicativo que já tinha muito código nativo. Com isso, a equipe passou a enfrentar problemas de depuração, diferenças entre Android e iOS e dependência de módulos nativos. Na prática, a empresa precisava manter três ambientes: Android, iOS e React Native.

**Essas razões também se aplicariam ao Flutter?**  
Parte desses problemas também poderia acontecer com Flutter, principalmente se ele fosse colocado aos poucos dentro de um aplicativo nativo grande. Flutter não usa a antiga ponte JavaScript do React Native, mas ainda pode precisar de Kotlin ou Swift para algumas funções. A equipe também teria que manter tecnologias diferentes durante a migração.

**Aprendizado sobre quando não utilizar cross-platform:**  
O caso ensina que cross-platform não deve ser escolhido apenas pela promessa de compartilhar código. Ele pode não valer a pena quando o aplicativo depende muito de recursos nativos, exige desempenho extremo ou já possui uma base nativa grande e equipes organizadas por plataforma.

**Fontes:**

- [Sunsetting React Native — Airbnb Engineering](https://medium.com/airbnb-engineering/sunsetting-react-native-1868ba28e30a);
- [React Native at Airbnb — Airbnb Engineering](https://medium.com/airbnb-engineering/react-native-at-airbnb-f95aa460be1c).

---

## Parte D — Preparação do ambiente

### D1 — Ferramentas

- [x] Flutter SDK 3.35.7 Stable instalado.
- [x] Android Studio 2026.1.3 instalado.
- [x] Visual Studio Code 1.133.0 instalado.
- [x] Extensão Flutter instalada no VS Code.
- [x] Git 2.52.0 instalado.
- [x] Android SDK configurado em `C:\Android\Sdk`.
- [x] Android Debug Bridge — ADB configurado.

**Evidência:** [`prints/ferramentas-instaladas.png`](prints/ferramentas-instaladas.png).

### D2 — Espaço disponível

O computador possui **339 GB livres** no Disco Local C:, superando os 20 GB mínimos solicitados.

**Evidência:** [`prints/espaco-disco.png`](prints/espaco-disco.png).

### D3 — Depuração USB

**Situação:** As opções do desenvolvedor foram habilitadas no celular Android e a opção Depuração USB foi ativada.

**Evidência:** [`prints/depuracao-usb.png`](prints/depuracao-usb.png).

---

## Bônus — Diagnóstico do Flutter

Foi executado o seguinte comando:

```powershell
flutter doctor -v
```

**Evidência:** [`prints/flutter-doctor.png`](prints/flutter-doctor.png).

### Minha interpretação

O Flutter reconheceu o SDK, o Android Studio, o VS Code e as ferramentas Android. O aviso de licença acontece porque o Command-line Tools 23.0 usa um processo mais novo que o Flutter 3.35.7 ainda não consegue verificar corretamente.

O erro do Visual Studio está relacionado ao desenvolvimento de aplicativos desktop para Windows. Como a disciplina utilizará Android, esse componente não impede a realização das atividades.
