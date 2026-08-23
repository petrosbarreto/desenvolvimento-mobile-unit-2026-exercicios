# Exercício - Aula 01: O Ecossistema Mobile e o Lugar do Flutter

## Identificação

- Disciplina: Desenvolvimento Mobile - F105880
- Professor: Petros Barreto
- Aluna: Adriely Natasha Martins Andrade
- Data: 23/08/2026

## Parte A - Análise de apps reais

### App: Nubank

| Item | Resposta |
|---|---|
| Categoria | Banco digital brasileiro |
| A rolagem é fluida ou engasga? | Achei a rolagem fluida. Passei pelas telas da conta e não percebi travamentos. |
| A aparência é igual à de outros apps do Android? | Não totalmente. Ele usa alguns padrões comuns do Android, mas as cores, os cartões e a organização das informações são próprios do Nubank. |
| Funciona em modo avião? O que ainda dá para fazer? | Consegui abrir algumas telas que já estavam carregadas, mas não consegui atualizar o saldo, fazer Pix ou consultar informações novas. |
| Abordagem que eu chuto | Flutter, pelo menos em parte do aplicativo. |
| Evidência do meu chute | Encontrei o Nubank no Flutter Showcase oficial. Mesmo assim, entendi que isso não prova que todas as partes do aplicativo tenham sido feitas em Flutter. |

**Fonte:** [Flutter Showcase - Nubank](https://flutter.dev/showcase/nubank)

A fonte oficial informa que o Nubank adotou Flutter para ajudar a lançar recursos para Android e iOS mais rapidamente. O caso também menciona o lançamento do seguro de vida em três meses e uma taxa de sucesso de merge 30% melhor que a do iOS.

---

### App: iFood

| Item | Resposta |
|---|---|
| Categoria | Aplicativo brasileiro de delivery |
| A rolagem é fluida ou engasga? | A rolagem foi geralmente fluida. Algumas imagens demoraram um pouco para carregar, mas não percebi travamentos importantes. |
| A aparência é igual à de outros apps do Android? | Parcialmente. O aplicativo utiliza alguns padrões do Android, mas tem uma aparência própria para restaurantes, cardápios, filtros e pedidos. |
| Funciona em modo avião? O que ainda dá para fazer? | Algumas telas que já estavam abertas continuaram aparecendo, mas não consegui pesquisar restaurantes, atualizar cardápios, fazer um pedido ou acompanhar uma entrega. |
| Abordagem que eu chuto | Nativo ou híbrido, com partes específicas para Android e iOS. |
| Evidência do meu chute | Não encontrei uma fonte oficial que confirmasse a tecnologia usada pelo iFood. Também não consegui confirmar pelo teste visual. Por isso, considero esse palpite provisório. |

Não encontrei uma evidência concreta suficiente para afirmar que o iFood usa Flutter, React Native ou outra tecnologia específica. Para não inventar uma informação, registrei a limitação da pesquisa.

---

### App: Instagram

| Item | Resposta |
|---|---|
| Categoria | Rede social internacional |
| A rolagem é fluida ou engasga? | A rolagem foi fluida na maior parte do tempo. Alguns vídeos demoraram para carregar, mas isso parecia estar relacionado à conexão. |
| A aparência é igual à de outros apps do Android? | Parcialmente. O aplicativo usa alguns gestos e comportamentos comuns do Android, mas a interface é bastante personalizada. |
| Funciona em modo avião? O que ainda dá para fazer? | Consegui visualizar algumas imagens que já tinham sido carregadas. Não consegui atualizar o feed, enviar mensagens, publicar ou carregar novas publicações. |
| Abordagem que eu chuto | Nativo, com componentes específicos para Android e iOS. |
| Evidência do meu chute | Acredito que o aplicativo use bastante código nativo por causa dos recursos de câmera, vídeo, notificações e gestos. Porém, não encontrei uma fonte oficial que confirme toda a stack usada pelo Instagram, então esse é apenas um palpite. |

A observação da interface não é suficiente para provar que um aplicativo é nativo. Seria necessário analisar o APK ou encontrar uma publicação técnica da empresa.

## A3 - Teste do modo avião

Depois de ativar o modo avião, usei cada aplicativo por aproximadamente dois minutos.

O Instagram foi o aplicativo que pareceu funcionar melhor sem internet, porque conseguiu mostrar parte das imagens que já estavam carregadas em cache. Mesmo assim, não foi possível atualizar o feed, enviar mensagens ou publicar conteúdo.

O Nubank permitiu acessar algumas telas que já tinham sido carregadas, mas bloqueou as operações que precisavam de informações atualizadas, como consultar o saldo e fazer Pix.

O iFood foi o que funcionou pior sem rede. Não consegui pesquisar restaurantes, atualizar preços, fazer pedidos ou acompanhar uma entrega.

Esse teste mostrou que guardar algumas informações em cache não é exatamente o mesmo que ser offline-first. Um aplicativo offline-first deve permitir que as funções principais continuem funcionando sem internet e sincronizar os dados quando a conexão voltar. Esse conceito será importante no projeto Checkpoint.

## Parte B - Escolhendo a abordagem

### B1 - Startup com dois desenvolvedores, três meses de prazo, Android e iOS

**Escolha: Flutter.**

Eu escolheria Flutter porque a equipe é pequena e o prazo é curto. Com uma base de código compartilhada, os dois desenvolvedores conseguem criar a interface e boa parte da lógica para Android e iOS ao mesmo tempo. Ainda seria necessário testar as diferenças entre as plataformas, mas a manutenção seria mais simples do que manter dois aplicativos totalmente separados.

### B2 - App de edição de vídeo com filtros em tempo real

**Escolha: desenvolvimento nativo.**

Eu escolheria desenvolvimento nativo porque filtros em tempo real exigem bastante desempenho e acesso à câmera, à GPU e aos codecs de vídeo. As APIs nativas permitem fazer otimizações específicas para Android e iOS e controlar melhor memória, bateria e taxa de quadros. Flutter poderia ser usado na interface, mas eu não o escolheria para a parte principal do processamento de vídeo.

### B3 - Portal de notícias que já possui um site responsivo

**Escolha: PWA ou WebView.**

Como o jornal já tem um site responsivo, eu tentaria reaproveitar esse trabalho em vez de criar todo o aplicativo novamente. Uma PWA poderia oferecer instalação, cache e algum funcionamento offline. Se fosse necessário publicar rapidamente nas lojas, também seria possível criar um aplicativo usando WebView, embora a experiência pudesse não ser tão boa quanto a de um aplicativo nativo.

### B4 - App bancário com biometria e certificado no aparelho

**Escolha: desenvolvimento nativo.**

Eu escolheria desenvolvimento nativo porque biometria, certificados, criptografia e armazenamento seguro são recursos muito sensíveis. As APIs nativas do Android e do iOS permitem acessar diretamente os mecanismos de segurança de cada sistema. Flutter consegue chamar código nativo por meio de plugins, mas eu evitaria colocar uma camada extra nas partes mais importantes do aplicativo bancário.

### B5 - App interno, somente Android, para funcionários sem internet

**Escolha: Android nativo.**

Como o aplicativo funcionará somente em Android, não há necessidade de compartilhar código com o iOS. O requisito mais importante é trabalhar bem sem internet, usando banco de dados local, fila de sincronização e armazenamento seguro. Eu escolheria Android nativo porque isso facilita o uso das ferramentas da própria plataforma e o suporte aos aparelhos da empresa.

### B6 - Jogo 2D casual com física e placar online

**Escolha: Unity ou Godot.**

Eu escolheria uma engine de jogos, como Unity ou Godot, porque ela já possui recursos para física, colisões, sprites, áudio e animações. Isso permitiria que a equipe gastasse menos tempo criando a estrutura básica do jogo. O placar online poderia ser integrado por uma API ou serviço de backend.

## Parte C - Pesquisa: migrações reais

### C1 - Google Pay

Antes da migração, o Google Pay mantinha implementações separadas para Android e iOS. Isso fazia com que muitas funcionalidades precisassem ser desenvolvidas mais de uma vez.

A equipe escolheu Flutter para compartilhar mais código e facilitar a expansão do aplicativo para diferentes regiões. A migração exigiu treinamento dos desenvolvedores em Dart e Flutter.

O trabalho também precisou acontecer enquanto o aplicativo continuava recebendo atualizações. Por isso, a empresa começou com uma prova de conceito antes de ampliar a migração.

Segundo o caso divulgado pelo Flutter, aproximadamente 50 engenheiros foram treinados para participar do trabalho. O código teve uma redução de 35% na quantidade de linhas, mesmo com novas funcionalidades.

A empresa também informou uma redução de aproximadamente 60% a 70% no esforço de engenharia. A principal dificuldade foi migrar um aplicativo grande sem interromper seu funcionamento e sem prejudicar os requisitos de segurança.

**Fonte:** [Google Pay - Flutter Showcase](https://flutter.dev/showcase/google-pay)

### C1 - Nubank

Antes do Flutter, o Nubank possuía equipes nativas separadas para iOS e Android. Isso dificultava o lançamento simultâneo de recursos e aumentava a necessidade de profissionais especializados em cada plataforma.

A empresa pesquisou diferentes tecnologias multiplataforma e escolheu Flutter para novos recursos e para uma migração gradual do aplicativo.

Um dos resultados divulgados foi o lançamento do seguro de vida em três meses. O Nubank informou que, anteriormente, um produto poderia levar de vários meses a um ano para ser lançado.

A empresa também relatou uma taxa de sucesso de merge 30% melhor que a do iOS. Além disso, os merges de pull requests Flutter eram mais rápidos.

A dificuldade foi migrar gradualmente um aplicativo bancário já existente, mantendo segurança, qualidade e integração com o código antigo.

Esse caso mostra que Flutter pode ajudar a acelerar o desenvolvimento, mas a migração exige planejamento e não elimina os desafios de um sistema grande.

**Fontes:**  
- [Nubank - Flutter Showcase](https://flutter.dev/showcase/nubank)
- [Blog de Engenharia do Nubank](https://building.nubank.com/pt-br/expandindo-o-desenvolvimento-movel-do-nubank-com-o-flutter/)

### C2 - Airbnb e React Native

A Airbnb decidiu abandonar gradualmente o React Native e voltar a concentrar seus esforços no desenvolvimento nativo. A empresa explicou que encontrou problemas técnicos e organizacionais durante a utilização da tecnologia.

Um dos problemas foi a complexidade de integrar o React Native com um aplicativo nativo grande e que continuava evoluindo. A equipe precisava manter pontes entre JavaScript e as APIs nativas.

O compartilhamento de código também foi menor do que o esperado. Vários recursos ainda exigiam implementações diferentes para Android e iOS.

A depuração, a inicialização e a manutenção da infraestrutura também aumentavam a complexidade do projeto. Com o crescimento do aplicativo, essas dificuldades passaram a pesar mais.

Alguns desses problemas poderiam aparecer no Flutter, embora Flutter tenha uma arquitetura diferente. O Flutter também depende de plugins e de código nativo quando o aplicativo precisa acessar recursos específicos do aparelho.

Esse caso ensina que não se deve escolher uma tecnologia multiplataforma apenas pela promessa de reutilizar código. É preciso considerar desempenho, acesso a hardware, bibliotecas disponíveis, código legado e experiência da equipe.

Eu evitaria cross-platform quando o aplicativo dependesse muito de recursos específicos de cada sistema ou exigisse desempenho extremamente alto.

**Fonte:** [Airbnb Engineering - Sunsetting React Native](https://medium.com/airbnb-engineering/sunsetting-react-native-1868ba28e30a)

## Parte D - Preparação do ambiente

### D1 - Downloads

Tenho um computador desktop, mas não tenho notebook. Fiz a preparação do ambiente
no meu PC para acompanhar a aula e, durante a prática, vou trabalhar em dupla
com a Mariana.

Baixei:

- Flutter SDK 3.35 stable.
- Android Studio.
- VS Code.
- Extensão Flutter para VS Code.

Os comprovantes estão na pasta `prints/`.

### D2 - Espaço livre em disco

Verifiquei o espaço disponível no disco do meu PC.

Resultado:

![print do espaço em disco](print-gb.png)

Tenho aproximadamente `237 GB` livres no disco.

### D3 - Depuração USB

Ativei as Opções do desenvolvedor no meu celular Android e liguei a opção
**Depuração USB**.

Durante a aula, vou trabalhar em dupla com a Mariana e poderemos testar o
aplicativo no computador e, se necessário, no celular.

Print:

![print do depuração de usb](print-depuracao.jpg)

### Bônus - flutter doctor

Executei o comando:

```bash
flutter doctor -v
```

Resultado:
![alt text](image.png)
Os avisos encontrados.