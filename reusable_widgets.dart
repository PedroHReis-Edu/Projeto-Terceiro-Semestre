// lib/reusable_widgets.dart
import 'package:flutter/material.dart';

// Exemplo: InfoCard (usado na InfoTab, por exemplo)
/// Um widget de card reutilizável para exibir informações de forma concisa,
/// com a possibilidade de expandir para mostrar conteúdo adicional.
///
/// Utilizado principalmente para apresentar itens de informação com um ícone,
/// título, subtítulo e, opcionalmente, um conteúdo detalhado que pode ser
/// revelado ao tocar no card.
class InfoCard extends StatefulWidget {
  /// O ícone a ser exibido no lado esquerdo do card.
  final IconData icon;
  /// O título principal do card.
  final String title;
  /// O subtítulo ou breve descrição exibida abaixo do título.
  final String subtitle;
  /// Um widget opcional que é exibido quando o card está expandido.
  /// Se nulo, o card não será expansível por padrão (a menos que [onTap] seja fornecido).
  final Widget? expandedContent;
  /// Uma função de callback opcional a ser executada quando o card é tocado.
  /// Se fornecido, substitui o comportamento padrão de expansão/contração
  /// quando [expandedContent] também está presente.
  final VoidCallback? onTap;

  /// Cria uma instância de [InfoCard].
  ///
  /// [icon], [title] e [subtitle] são obrigatórios.
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.expandedContent,
    this.onTap,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

/// O estado para o widget [InfoCard].
///
/// Gerencia o estado de expansão (`_isExpanded`) do card.
class _InfoCardState extends State<InfoCard> {
  /// Controla se o conteúdo expansível do card está visível ou não.
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Acessa o tema atual

    return Card( // O CardTheme já define shape, elevation, margin, color
      // clipBehavior: Clip.antiAlias, // Comentário original mantido: Já definido no CardTheme
      // shape: RoundedRectangleBorder( // Comentário original mantido: Já definido no CardTheme
      //   borderRadius: BorderRadius.circular(12.0),
      // ),
      child: InkWell(
        // Define a ação de toque: usa o onTap fornecido ou alterna a expansão.
        onTap: widget.onTap ?? (widget.expandedContent != null
            ? () => setState(() => _isExpanded = !_isExpanded)
            : null),
        borderRadius: BorderRadius.circular(12.0), // Para o efeito do InkWell corresponder ao Card.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ocupa o mínimo de espaço vertical.
            children: [
              Row(
                children: [
                  Icon(
                    widget.icon,
                    color: theme.colorScheme.primary, // Usa a cor primária do tema para o ícone.
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda.
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            // color: theme.colorScheme.onSurface, // Comentário original mantido: O textTheme já deve ter a cor correta
                          ),
                        ),
                        // Exibe o subtítulo apenas se não estiver vazio.
                        if (widget.subtitle.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.7), // Cor para texto secundário.
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Exibe o ícone de seta para expansão se houver conteúdo expansível.
                  if (widget.expandedContent != null)
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up // Ícone de seta para cima quando expandido.
                          : Icons.keyboard_arrow_down, // Ícone de seta para baixo quando contraído.
                      color: theme.colorScheme.outline, // Cor para ícones de controle/secundários.
                    ),
                ],
              ),
              // Exibe o conteúdo expansível se _isExpanded for verdadeiro e o conteúdo existir.
              if (_isExpanded && widget.expandedContent != null) ...[
                const Divider(height: 24), // Usa o DividerTheme para estilização.
                widget.expandedContent!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}


// Exemplo: HealthMetricCard (usado na SaudeScreen)
/// Um widget de card reutilizável projetado para exibir métricas de saúde
/// ou status, com indicadores visuais como barras de progresso e alertas.
///
/// Ideal para apresentar informações como nível de combustível, vida útil do óleo, etc.,
/// com a capacidade de expandir para mostrar detalhes adicionais.
class HealthMetricCard extends StatefulWidget {
  /// O ícone principal que representa a métrica.
  final IconData icon;
  /// A cor do ícone. O padrão é `Colors.blue`, mas é sobrescrito
  /// pela cor de erro do tema se [isAlert] for `true`, ou pela cor primária
  /// do tema caso contrário.
  final Color iconColor;
  /// O título da métrica.
  final String title;
  /// O valor principal da métrica (ex: "100", "OK").
  final String value;
  /// A unidade associada ao valor (ex: "Km", "PSI").
  final String unit;
  /// Uma descrição textual do status atual da métrica (ex: "Nível Bom", "Substituir em Breve!").
  final String status;
  /// O valor de progresso para a barra [LinearProgressIndicator], variando de 0.0 a 1.0.
  /// Se nulo, a barra de progresso não é exibida.
  final double? progress;
  /// A cor da barra de progresso. Se nula, usa a [effectiveIconColor].
  final Color? progressColor;
  /// Indica se a métrica está em estado de alerta.
  /// Afeta as cores do ícone, texto de status e, potencialmente, a borda do card.
  final bool isAlert;
  /// Um widget opcional que é exibido quando o card está expandido.
  final Widget? expandedContent;

  /// Cria uma instância de [HealthMetricCard].
  const HealthMetricCard({
    super.key,
    required this.icon,
    this.iconColor = Colors.blue, // Comentário original mantido: Será sobrescrito pelo tema se não for alerta
    required this.title,
    required this.value,
    required this.unit,
    required this.status,
    this.progress,
    this.progressColor,
    this.isAlert = false,
    this.expandedContent,
  });

  @override
  State<HealthMetricCard> createState() => _HealthMetricCardState();
}

/// O estado para o widget [HealthMetricCard].
///
/// Gerencia o estado de expansão (`_isExpanded`) do card.
class _HealthMetricCardState extends State<HealthMetricCard> {
  /// Controla se o conteúdo expansível do card está visível ou não.
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Define a cor efetiva do ícone baseada no estado de alerta.
    final Color effectiveIconColor =
    widget.isAlert ? theme.colorScheme.error : theme.colorScheme.primary; // Cor de erro ou primária.
    // Define a cor efetiva da barra de progresso.
    final Color effectiveProgressColor =
        widget.progressColor ?? effectiveIconColor;
    // Define a cor do texto de status baseada no estado de alerta.
    final Color statusTextColor =
    widget.isAlert ? theme.colorScheme.error : theme.colorScheme.onSurface.withOpacity(0.7);

    return Card(
      // elevation: widget.isAlert ? 4 : 2, // Comentário original mantido: O CardTheme já define a elevação
      // shape: RoundedRectangleBorder( // Comentário original mantido: O CardTheme já define o shape
      //   borderRadius: BorderRadius.circular(12.0),
      //   side: widget.isAlert
      //       ? BorderSide(color: theme.colorScheme.errorContainer, width: 1.5)
      //       : BorderSide.none,
      // ),
      // color: widget.isAlert ? theme.colorScheme.errorContainer.withOpacity(0.5) : theme.colorScheme.surface, // Comentário original mantido: Cor de fundo do card
      child: InkWell(
        // Permite expansão apenas se houver conteúdo expansível.
        onTap: widget.expandedContent != null
            ? () => setState(() => _isExpanded = !_isExpanded)
            : null,
        borderRadius: BorderRadius.circular(12.0), // Para o efeito do InkWell.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ocupa o mínimo de espaço vertical.
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinha os itens no topo.
                children: [
                  Icon(widget.icon, color: effectiveIconColor, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda.
                      children: [
                        Text(
                          widget.title,
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.status,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: statusTextColor,
                            fontWeight: widget.isAlert ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // Alinha valor e unidade à direita.
                    children: [
                      Text(
                        widget.value,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: effectiveIconColor, // Valor com a cor de destaque.
                        ),
                      ),
                      Text(
                        widget.unit,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline, // Cor sutil para a unidade.
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Exibe a barra de progresso se widget.progress não for nulo.
              if (widget.progress != null) ...[
                const SizedBox(height: 12),
                ClipRRect( // Para arredondar as bordas do LinearProgressIndicator.
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: widget.progress,
                    backgroundColor: theme.colorScheme.outline.withOpacity(0.3), // Cor de fundo da barra.
                    color: effectiveProgressColor, // Cor principal da barra.
                    minHeight: 8, // Altura mínima da barra.
                  ),
                ),
              ],
              // Exibe o conteúdo expansível se _isExpanded for verdadeiro e o conteúdo existir.
              if (_isExpanded && widget.expandedContent != null) ...[
                const Divider(height: 24), // Usa o DividerTheme.
                widget.expandedContent!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}


// Exemplo: SimpleDetailTextWidget (usado na InfoTab)
/// Um widget reutilizável para exibir um par de label e valor em uma linha,
/// opcionalmente precedido por um ícone.
///
/// Útil para listas de detalhes onde cada item consiste em uma descrição (label)
/// e seu respectivo dado (value).
class SimpleDetailTextWidget extends StatelessWidget {
  /// O texto do rótulo/descrição.
  final String label;
  /// O texto do valor/dado.
  final String value;
  /// Um ícone opcional a ser exibido antes do label.
  final IconData? icon;

  /// Cria uma instância de [SimpleDetailTextWidget].
  ///
  /// [label] e [value] são obrigatórios.
  const SimpleDetailTextWidget({
    super.key,
    required this.label,
    required this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // O textTheme já deve fornecer cores adequadas, mas podemos ser explícitos se necessário (Comentário original mantido)
    // Estilo para o label.
    final labelStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface.withOpacity(0.7), // Cor para o label (um pouco mais clara).
      fontWeight: FontWeight.w500,
    );
    // Estilo para o valor.
    final valueStyle = theme.textTheme.bodyLarge?.copyWith(
      // color: theme.colorScheme.onSurface, // Comentário original mantido: Cor para o valor
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo no topo.
        children: [
          // Exibe o ícone se fornecido.
          if (icon != null) ...[
            Icon(icon, size: 20, color: theme.colorScheme.primary.withOpacity(0.8)),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 2, // Dá mais espaço para o label se necessário.
            child: Text(label, style: labelStyle),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3, // Dá mais espaço para o valor.
            child: Text(value, style: valueStyle),
          ),
        ],
      ),
    );
  }
}

/// Um widget reutilizável que exibe um label e um valor em uma linha,
/// com um botão de ação (IconButton) à direita.
///
/// Comumente usado para exibir um pedaço de informação que pode ser copiado
/// ou ter alguma outra ação associada.
class ActionDetailRowWidget extends StatelessWidget {
  /// O texto do rótulo/descrição.
  final String label;
  /// O texto do valor/dado.
  final String value;
  /// O ícone para o botão de ação.
  final IconData actionIcon;
  /// O texto de tooltip para o botão de ação.
  final String tooltip;
  /// A função de callback a ser executada quando o botão de ação é pressionado.
  final VoidCallback onAction;

  /// Cria uma instância de [ActionDetailRowWidget].
  ///
  /// Todos os parâmetros são obrigatórios.
  const ActionDetailRowWidget({
    super.key,
    required this.label,
    required this.value,
    required this.actionIcon,
    required this.tooltip,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça o conteúdo e o botão.
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda.
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7), // Cor sutil para o label.
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface, // Cor padrão para o valor.
                  ),
                  overflow: TextOverflow.ellipsis, // Evita quebra de texto com valores longos.
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(actionIcon, color: theme.colorScheme.primary), // Ícone com a cor primária.
            tooltip: tooltip,
            onPressed: onAction,
            splashRadius: 24, // Raio do efeito de toque.
            constraints: const BoxConstraints(), // Para remover padding extra do IconButton.
            padding: const EdgeInsets.all(8), // Padding customizado para o IconButton.
          ),
        ],
      ),
    );
  }
}



// Se você tiver outros widgets reutilizáveis, aplique a mesma lógica: (Comentário original mantido)
// 1. Obtenha o tema: `final theme = Theme.of(context);` (Comentário original mantido)
// 2. Use as cores do `theme.colorScheme` (ex: `theme.colorScheme.primary`, `theme.colorScheme.onSurface`) (Comentário original mantido)
// 3. Use os estilos de texto do `theme.textTheme` (ex: `theme.textTheme.titleMedium`) (Comentário original mantido)