// lib/info_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar para Clipboard (Área de Transferência)
import 'car_model.dart'; // Modelo de dados para informações do veículo.
import 'reusable_widgets.dart'; // Importa os widgets reutilizáveis (incluindo InfoCard, ActionDetailRowWidget, SimpleDetailTextWidget).

/// Uma aba (tab) que exibe informações detalhadas sobre um veículo específico.
///
/// Mostra dados como o nome do carro, marca, modelo, ano, imagem, placa,
/// chassi (VIN), cor e outras informações simuladas como localização e manutenção.
/// Inclui funcionalidade para copiar certas informações e visualizar a imagem do carro em tela cheia.
class InfoTab extends StatelessWidget {
  /// Os dados do veículo a serem exibidos nesta aba.
  final CarInfoData carInfo;

  /// Cria uma instância de [InfoTab].
  ///
  /// Requer [carInfo] para popular os campos de informação.
  const InfoTab({super.key, required this.carInfo});

  /// Exibe um diálogo para visualização ampliada da imagem do carro.
  ///
  /// Utiliza [InteractiveViewer] para permitir zoom na imagem.
  /// O diálogo é fechado ao tocar fora da imagem.
  void _showCarImageDialog(BuildContext context, String imageUrl) {
    final theme = Theme.of(context); // Obtém o tema atual.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Fundo transparente para o Dialog.
          insetPadding: const EdgeInsets.all(10), // Espaçamento interno do Dialog.
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(), // Fecha o diálogo ao tocar.
            child: InteractiveViewer(
              panEnabled: false, // Desabilita o movimento lateral (pan).
              boundaryMargin: const EdgeInsets.all(20), // Margem de limite para o zoom.
              minScale: 0.5, // Escala mínima de zoom.
              maxScale: 4, // Escala máxima de zoom.
              child: AspectRatio(
                aspectRatio: 16 / 9, // Proporção da imagem.
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas para a imagem.
                  child: Image.asset(
                    imageUrl, // Caminho da imagem do asset.
                    fit: BoxFit.contain, // Ajusta a imagem para caber dentro dos limites.
                    errorBuilder: (context, error, stackTrace) {
                      // Widget a ser exibido se a imagem não puder ser carregada.
                      return Center(
                          child: Icon(Icons.broken_image, // Ícone de imagem quebrada.
                              size: 60, color: theme.colorScheme.outline));
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Copia o [text] fornecido para a área de transferência e exibe uma [SnackBar] de confirmação.
  ///
  /// O [fieldName] é usado na mensagem de confirmação.
  void _copyToClipboard(BuildContext context, String text, String fieldName) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      // Exibe uma mensagem de feedback para o usuário.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$fieldName "$text" copiado para a área de transferência')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtém o tema atual para estilização.

    // Utiliza ListView para permitir rolagem caso o conteúdo exceda a tela.
    return ListView(
      padding: const EdgeInsets.all(16), // Espaçamento geral da aba.
      children: [
        // Card principal com informações básicas do veículo.
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo à esquerda.
              children: [
                Row(
                  children: [
                    Icon(Icons.directions_car_filled, // Ícone representativo do carro.
                        color: theme.colorScheme.primary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        carInfo.name, // Nome do carro (Ex: "Argo de Usuário").
                        style: theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, // Evita quebra de texto com nomes longos.
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${carInfo.brand} / ${carInfo.model}", // Marca e Modelo do carro.
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight, // Alinha o ano à direita.
                  child: Text(
                    "Ano: ${carInfo.year.toString()}", // Ano do veículo.
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Imagem do veículo com interatividade.
        GestureDetector(
          onTap: () => _showCarImageDialog(context, carInfo.imageUrl), // Mostra diálogo ao tocar.
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20), // Margem vertical.
            height: 200, // Altura fixa para a imagem.
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), // Bordas arredondadas.
              color: theme.colorScheme.surfaceVariant, // Cor de fundo sutil.
              boxShadow: [ // Sombra para dar profundidade.
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Hero( // Widget para animação de transição da imagem.
              tag: 'carImage_${carInfo.vin}', // Tag única para o Hero.
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // Bordas arredondadas para a imagem.
                child: Image.asset(
                  carInfo.imageUrl, // Caminho da imagem.
                  fit: BoxFit.cover, // Cobre a área do container com a imagem.
                  errorBuilder: (context, error, stackTrace) {
                    // Widget de fallback se a imagem não carregar.
                    return Center(
                        child: Icon(Icons.image_not_supported, // Ícone de imagem não suportada.
                            size: 60, color: theme.colorScheme.outline));
                  },
                ),
              ),
            ),
          ),
        ),
        const Divider(), // Linha divisória.

        // Seção de informações detalhadas usando InfoCard.
        InfoCard(
          icon: Icons.pin_outlined,
          title: "Placa",
          subtitle: carInfo.plate,
          expandedContent: ActionDetailRowWidget( // Widget para exibir detalhes com ação.
            label: "Placa do veículo:",
            value: carInfo.plate,
            actionIcon: Icons.copy_outlined, // Ícone para a ação de copiar.
            tooltip: "Copiar Placa",
            onAction: () {
              _copyToClipboard(context, carInfo.plate, "Placa");
            },
          ),
        ),
        InfoCard(
          icon: Icons.article_outlined,
          title: "Chassi (VIN)",
          subtitle: carInfo.vin,
          expandedContent: ActionDetailRowWidget( // Widget para exibir detalhes com ação.
            label: "Número do Chassi (VIN):",
            value: carInfo.vin,
            actionIcon: Icons.copy_outlined, // Ícone para a ação de copiar.
            tooltip: "Copiar VIN",
            onAction: () {
              _copyToClipboard(context, carInfo.vin, "VIN");
            },
          ),
        ),
        InfoCard(
          icon: Icons.color_lens_outlined,
          title: "Cor",
          subtitle: carInfo.color,
          // Este InfoCard não possui conteúdo expansível, mostrando apenas título e subtítulo.
        ),
        // InfoCard para Localização (simulada).
        InfoCard(
          icon: Icons.location_on_outlined,
          title: "Localização",
          subtitle: "Ativa - Rua Exemplo, 123", // Valor simulado.
          expandedContent: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SimpleDetailTextWidget( // Widget para texto simples de detalhe.
                    label: "Coordenadas:",
                    value: "XX.XXXX, YY.YYYY" // Valor simulado.
                ),
                const SizedBox(height: 8),
                const SimpleDetailTextWidget( // Widget para texto simples de detalhe.
                    label: "Última atualização:",
                    value: "2 min atrás" // Valor simulado.
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon( // Botão para simular abertura no mapa.
                  icon: const Icon(Icons.map_outlined, size: 18),
                  label: const Text("Abrir no Mapa"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Abrindo mapa (simulado)...")),
                    );
                  },
                  style: ElevatedButton.styleFrom( // Estilo customizado para o botão.
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    foregroundColor: theme.colorScheme.onSecondaryContainer,
                    elevation: 0, // Sem elevação para um visual mais integrado.
                    side: BorderSide(color: theme.colorScheme.secondary), // Borda sutil.
                  ),
                )
              ],
            ),
          ),
        ),
        // InfoCard para Hodômetro (simulado).
        InfoCard(
          icon: Icons.av_timer_outlined,
          title: "Hodômetro",
          subtitle: "100.000 Kms", // Valor simulado.
          expandedContent: const SimpleDetailTextWidget( // Conteúdo expansível com detalhes.
            label: "Detalhes:",
            value: "Próxima troca de óleo em: 105.000 Kms\nRevisão recomendada: 110.000 Kms",
          ),
        ),
        // InfoCard para Última Manutenção (simulada).
        InfoCard(
          icon: Icons.build_outlined,
          title: "Última Manutenção",
          subtitle: "Há 20.000 Kms (01/05/2024)", // Valor simulado.
          expandedContent: const SimpleDetailTextWidget( // Conteúdo expansível com detalhes.
            label: "Serviços:",
            value: "Troca de óleo e filtros\nAlinhamento e balanceamento\nVerificação de freios (OK)",
          ),
        ),
      ],
    );
  }
}
