# Exercício — Aula 02: Instalação e Configuração do Ambiente

**Disciplina:** Desenvolvimento Mobile (`F105880`) — UNIT 2026
**Entrega:** até a véspera da Aula 03 — PR `[Aula 02] Seu Nome Completo`

> ⚠️ **A Parte A é pré-requisito para a Aula 03 inteira.** Sem ambiente verde,
> você não consegue acompanhar. Se travar, abra uma Issue **antes** da aula —
> respondo no mesmo dia.

---

## Parte A — Ambiente verde (30 pontos)

**A1 (20 pts).** Cole no `RESPOSTAS.md` a saída **completa** de:

```bash
flutter doctor -v
```

Os **quatro itens obrigatórios** precisam estar em ✓:

- [ ] `[✓] Flutter`
- [ ] `[✓] Android toolchain`
- [ ] `[✓] Network resources`
- [ ] `[✓] Connected device` (com celular plugado ou emulador aberto)

Xcode, Visual Studio, Chrome e Linux toolchain **podem** estar em ✗ — não
descontam nota.

**A2 (10 pts).** Cole também:

```bash
flutter --version
flutter devices
```

E um **print** do celular ou emulador conectado, com o app rodando.

---

## Parte B — Seu primeiro app personalizado (30 pontos)

Crie o projeto:

```bash
flutter create --org br.edu.unit --platforms=android,ios meu_primeiro_app
```

Faça as **seis** alterações abaixo em `lib/main.dart` (e onde mais for
necessário). Para cada uma, **um print** mostrando o resultado no aparelho.

| # | Alteração | Pts |
|---|---|---|
| B1 | Título da `AppBar` = seu nome completo | 4 |
| B2 | Cor do tema alterada (`ColorScheme.fromSeed`), diferente do padrão | 4 |
| B3 | O contador anda de **3 em 3** | 4 |
| B4 | Um **segundo botão** que **zera** o contador | 6 |
| B5 | O texto abaixo do número muda conforme o valor: `"Nenhum toque ainda"` quando 0, `"Poucos toques"` até 9, `"Muitos toques!"` de 10 em diante | 6 |
| B6 | Nome do app na gaveta de aplicativos = `App do <seu primeiro nome>` (altere `android:label` no `AndroidManifest.xml`) | 6 |

**Dica para B4:** o `Scaffold` aceita só um `floatingActionButton`. Para ter
dois botões, envolva-os em uma `Column` com
`mainAxisAlignment: MainAxisAlignment.end` — e use `heroTag` diferente em cada
`FloatingActionButton`, senão você verá este erro:

```
There are multiple heroes that share the same tag within a subtree.
```

**Dica para B5:** use um `if/else` dentro do método `build`, guardando o texto
numa variável local antes do `return`.

⚠️ **Requisitos de qualidade** (valem na rubrica):
- `flutter analyze` sem erros
- código formatado com `dart format .`
- nenhum `print()` esquecido

---

## Parte C — Experimentos com Hot Reload (20 pontos)

Com o app rodando, faça cada experimento e **registre o resultado**.

| # | Experimento | O que responder |
|---|---|---|
| C1 | Aperte o botão 5×, mude um texto e salve | O contador zerou? Por quê? |
| C2 | Mude a cor do tema e salve | Funcionou com `r` ou precisou de `R`? |
| C3 | Mude o valor **inicial** do contador (`int _counter = 0` → `= 100`) e salve | Funcionou com `r`? Explique |
| C4 | Adicione um `print('oi')` dentro do `main()` e salve | Funcionou com `r`? Onde a mensagem aparece? |
| C5 | Rode `flutter pub add intl` com o app rodando | O que aconteceu? O que foi preciso fazer? |

**C6 (8 pts) — a síntese.** Com base nos cinco experimentos, escreva **sua
própria regra** (3 a 5 linhas) sobre **quando** o hot reload funciona e quando é
preciso hot restart. Não copie a tabela do slide — formule com suas palavras, a
partir do que você observou.

---

## Parte D — Diário de bordo do ambiente (20 pontos)

Esta parte alimenta um guia coletivo de solução de problemas.

**D1 (14 pts).** Para **cada** problema que você enfrentou na instalação
(mesmo os pequenos), registre no formato:

```markdown
### Problema N

**Sistema operacional:** Windows 11 / macOS 15 / Ubuntu 24.04
**Momento:** ao rodar `flutter doctor` / ao rodar o app / ao conectar o celular

**Mensagem de erro (copiada, não digitada):**
```
cmdline-tools component is missing
```

**O que eu tentei que NÃO funcionou:**
- reinstalei o Android Studio

**O que resolveu:**
- SDK Manager → aba SDK Tools → marquei "Android SDK Command-line Tools (latest)" → Apply

**Tempo gasto:** ~20 min
**Como eu descobri:** slide da Aula 02 / Stack Overflow (link) / colega
```

Se você **não** teve nenhum problema, escreva isso — e descreva em 5 linhas a
configuração da sua máquina (SO, versão, RAM, se usou celular ou emulador). Isso
também é dado útil.

**D2 (6 pts).** Responda:

(a) Qual foi o passo **mais confuso** da instalação, e o que teria deixado ele
mais claro?
(b) Você usou **celular físico ou emulador**? Por quê? Se usou emulador, quanto
tempo ele levou para abrir?
(c) Quanto tempo levou o **primeiro** `flutter run` e quanto levou o segundo?

---

## Entrega

```
exercicios/aula02/
├── RESPOSTAS.md            # Partes A, C e D
├── meu_primeiro_app/       # Parte B (projeto Flutter completo)
│   ├── lib/main.dart
│   ├── pubspec.yaml
│   └── android/app/src/main/AndroidManifest.xml
└── prints/
    ├── flutter-doctor.png
    ├── b1-appbar.png ... b6-gaveta.png
    └── app-rodando.png
```

⚠️ **Não commite** `build/`, `.dart_tool/` nem `android/.gradle/`. O
`.gitignore` gerado pelo `flutter create` já cuida disso — **não o apague**.

## Rubrica

| Critério | Pontos |
|---|---|
| Faz o que foi pedido | 40 |
| Qualidade do código (`analyze` limpo, formatado, organizado) | 25 |
| Interface e prints | 20 |
| Cuidado com detalhes e diário de bordo | 15 |

---

## 🆘 Travou?

1. Procure a mensagem de erro **exata** no slide "Os erros reais do
   `flutter doctor`" da Aula 02.
2. Rode `flutter doctor -v` (com `-v`!) e leia os **caminhos** que ele imprime.
3. Ainda travado: abra uma [Issue](../../../issues) com o título
   `[Ambiente] resumo do problema`, colando a saída de `flutter doctor -v` e o
   seu sistema operacional.

Respondo no mesmo dia. **Não fique travado até a véspera** — problema de
ambiente é o único tipo que não se resolve estudando mais.
