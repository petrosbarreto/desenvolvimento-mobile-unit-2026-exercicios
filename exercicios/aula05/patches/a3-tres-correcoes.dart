// Aula 05 - A3: as três correções testadas no lugar do Text da A2.

// 1) Expanded: ocupa todo o espaço que sobra na Row e quebra em várias linhas
Expanded(
  child: Text(
    '${_formatar(visita.agendadaPara)} · ${visita.endereco}',
    style: texto.bodySmall?.copyWith(
      color: atrasada ? cores.error : cores.outline,
      fontWeight: atrasada ? FontWeight.bold : null,
    ),
  ),
),

// 2) Flexible: pode ocupar MENOS que o espaço que sobra se o texto for curto
Flexible(
  child: Text(
    '${_formatar(visita.agendadaPara)} · ${visita.endereco}',
    style: texto.bodySmall?.copyWith(
      color: atrasada ? cores.error : cores.outline,
      fontWeight: atrasada ? FontWeight.bold : null,
    ),
  ),
),

// 3) Expanded + uma linha + reticências  <- escolhida
Expanded(
  child: Text(
    '${_formatar(visita.agendadaPara)} · ${visita.endereco}',
    style: texto.bodySmall?.copyWith(
      color: atrasada ? cores.error : cores.outline,
      fontWeight: atrasada ? FontWeight.bold : null,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  ),
),
