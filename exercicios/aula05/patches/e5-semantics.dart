// Aula 05 - E (bônus) - PROPOSTA, ainda NÃO testada no app (sem print de antes/depois).
// lib/ui/widgets/visita_card.dart: os ícones de foto e de localização são
// puramente visuais; sem rótulo, o leitor de tela não anuncia nada para eles.
if (visita.temFoto)
  Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Icon(
      Icons.photo_outlined,
      size: 18,
      color: cores.outline,
      semanticLabel: 'Tem foto anexada',
    ),
  ),
if (visita.temLocalizacao)
  Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Icon(
      Icons.place_outlined,
      size: 18,
      color: cores.outline,
      semanticLabel: 'Tem localização registrada',
    ),
  ),

// E o cartão inteiro passa a ser anunciado como botão, com dica de ação:
Semantics(
  button: true,
  hint: 'Toque duas vezes para abrir os detalhes',
  child: Card(/* ... conteúdo atual ... */),
)
