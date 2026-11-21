// Aula 05 - A2: lib/ui/widgets/visita_card.dart (Row da data, linha 105)
// O Expanded foi REMOVIDO e o endereço passou a aparecer na mesma linha da
// data (o cartão original não exibe o endereço, então sem isso nada transborda).
Row(
  children: [
    Icon(Icons.schedule, size: 16, color: cores.outline),
    const SizedBox(width: 6),
    Text(
      '${_formatar(visita.agendadaPara)} · ${visita.endereco}',
      style: texto.bodySmall?.copyWith(
        color: atrasada ? cores.error : cores.outline,
        fontWeight: atrasada ? FontWeight.bold : null,
      ),
    ),
    if (atrasada)
      Text('ATRASADA', style: texto.labelSmall?.copyWith(color: cores.error)),
  ],
),

// lib/data/repositories/visitas_mock.dart - endereço da 2ª visita trocado por ~120 caracteres:
endereco: 'Av. Beira Mar, 1180, Bloco B, sala 1402, Edifício Empresarial Oceanic Tower — Treze de Julho, Aracaju/SE, CEP 49025-040',
