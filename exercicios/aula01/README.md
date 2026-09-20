# Exercício - Aula 01: O Ecossistema Mobile e o Lugar do Flutter

**Disciplina:** Desenvolvimento Mobile (`F105880`) - UNIT 2026
**Professor:** Petros Barreto
**Entrega:** até a véspera da Aula 02 — PR `[Aula 02] Adriely Natasha Martins Andrade`

> Esta primeira lista **não tem código**. Ela é de análise e preparação de
> ambiente — e a Parte D é o que vai fazer a Aula 02 render.

---

## Parte A — Análise de apps reais (30 pontos)

Escolha **três apps** que você usa no celular. Pelo menos um deve ser brasileiro
e pelo menos um internacional.

Para cada app, preencha a ficha:

```markdown
### App: <nome>

| Item | Resposta |
|---|---|
| Categoria | banco / delivery / rede social / ... |
| A rolagem é fluida ou engasga? | |
| A aparência é igual à de outros apps do Android? | |
| Funciona em modo avião? O que ainda dá para fazer? | |
| Abordagem que eu **chuto** | nativo / WebView / React Native / Flutter |
| Evidência do meu chute | (ver abaixo) |
```

**A1 (18 pts).** As três fichas preenchidas — 6 pontos cada.

**A2 (7 pts).** Para cada app, apresente **uma evidência concreta** do seu
palpite sobre a abordagem. Vale:

- print das **Opções do desenvolvedor → Mostrar limites de layout** (apps
  Flutter têm um padrão de retângulos característico);
- consulta ao <https://appbrain.com/stats/libraries/tag/framework>;
- notícia ou post de engenharia da própria empresa;
- inspeção do APK (avançado): presença de `libflutter.so` ou `libhermes.so`.

**A3 (5 pts).** **O teste do modo avião.** Ative o modo avião e use os três apps
por 2 minutos cada. Responda: qual deles se comporta melhor sem rede, e **o que
exatamente** ele faz de diferente? (Isto é *offline-first*, e é o coração do
projeto Checkpoint.)

---

## Parte B — Escolhendo a abordagem (30 pontos)

Para cada cenário, escolha **uma** abordagem e **justifique em 2 a 4 frases**.
Não existe resposta única — existe justificativa boa e ruim.

| # | Cenário | Pts |
|---|---|---|
| B1 | Startup com 2 devs, 3 meses de prazo, precisa lançar em Android e iOS | 5 |
| B2 | App de edição de vídeo com filtros aplicados em tempo real | 5 |
| B3 | Portal de notícias de um jornal que já tem site responsivo | 5 |
| B4 | App bancário com biometria e certificado armazenado no aparelho | 5 |
| B5 | App interno de uma empresa, só Android, 200 funcionários em campo sem internet | 5 |
| B6 | Jogo 2D casual com física e placar online | 5 |

**Sua justificativa precisa considerar pelo menos três destes fatores:**
prazo · tamanho e experiência da equipe · exigência de desempenho · acesso a
hardware · quanto o visual precisa ser "da plataforma" · custo de manutenção
a longo prazo · disponibilidade de contratação no mercado local.

⚠️ **Atenção:** responder "Flutter" nos seis zera metade da parte. Em **B2** e
**B4** há argumentos fortes para nativo — se você escolher Flutter neles, a
justificativa precisa **enfrentar** esses argumentos, não ignorá-los.

---

## Parte C — Pesquisa: migrações reais (20 pontos)

**C1 (12 pts).** Encontre **dois casos** documentados de empresas que migraram
para Flutter. Para cada um, em ~8 linhas:

- que stack usavam antes e por que migraram;
- que ganho **mensurável** relataram (tempo de build, tamanho da equipe,
  tempo de entrega, desempenho, ...);
- que dificuldade relataram na migração;
- **a fonte** (link para post de engenharia, palestra ou estudo de caso).

*Sugestões de onde procurar: blogs de engenharia da Nubank, iFood, Banco Inter,
BMW, eBay, Alibaba, Google Pay; canal Flutter no YouTube; Flutter Case Studies.*

**C2 (8 pts).** Encontre **um caso** de empresa que **abandonou** uma stack
cross-platform e voltou para nativo (Airbnb com React Native é o mais
documentado). Responda:

- quais foram as razões alegadas?
- essas razões se aplicariam também ao Flutter? Por quê?
- o que esse caso ensina sobre **quando não** usar cross-platform?

⚠️ **Sem fonte, o item vale zero.** Cite o link.

---

## Parte D — Preparação do ambiente (20 pontos)

Esta parte é o que faz a Aula 02 render. Faça **antes** da aula.

**D1 (10 pts).** Baixe (não precisa instalar ainda, instalamos juntos):

- [ ] Flutter SDK **3.35 stable** — <https://docs.flutter.dev/get-started/install>
- [ ] Android Studio — <https://developer.android.com/studio>
- [ ] VS Code + extensão **Flutter** — <https://code.visualstudio.com>

Entregue: um print da pasta de downloads mostrando os arquivos baixados **ou**
o print do instalador já concluído.

**D2 (5 pts).** Confirme que tem **20 GB livres** em disco e entregue o print:

```bash
df -h            # macOS / Linux
# Windows: Explorer → clique direito no C: → Propriedades
```

**D3 (5 pts).** Se você tem um celular Android, ative as opções de
desenvolvedor e entregue o print da tela com a **Depuração USB** ligada:

```
Configurações → Sobre o telefone
→ toque 7 vezes em "Número da versão"
→ Configurações → Sistema → Opções do desenvolvedor
→ ative "Depuração USB"
```

Se **não** tem celular Android, escreva isso no `RESPOSTAS.md` — você usará
emulador, e eu vou te ajudar com a configuração na Aula 02.

### 🎁 Bônus (+10 pontos)

Se você conseguir instalar o Flutter sozinho antes da aula, rode e cole a saída:

```bash
flutter doctor -v
```

Não se preocupe se houver ✗ vermelhos — **cole assim mesmo** e escreva o que
você acha que cada um significa. Vamos resolvê-los juntos na Aula 02, e ter o
diagnóstico pronto acelera a turma inteira.

---

## Entrega

```
exercicios/aula01/
├── RESPOSTAS.md        # Partes A, B, C e D
└── prints/
    ├── app1-layout-bounds.png
    ├── espaco-disco.png
    ├── depuracao-usb.png
    └── flutter-doctor.png     (se fez o bônus)
```

Abra o PR com o título: `[Aula 01] Seu Nome Completo`

## Rubrica

| Critério | Pontos |
|---|---|
| Faz o que foi pedido | 40 |
| Qualidade da análise | 25 |
| Apresentação e evidências (prints, fontes) | 20 |
| Cuidado com detalhes | 15 |
| **Bônus `flutter doctor`** | +10 |

---

## 📚 Para a Aula 02

Traga: **notebook carregado**, **celular Android** (se tiver) e **cabo USB**.
A Aula 02 é 100% prática — saímos dela com um app rodando no aparelho.
