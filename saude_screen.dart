// lib/saude_screen.dart
import 'package:flutter/material.dart';
import 'reusable_widgets.dart'; // Importa os widgets reutilizáveis (ex: HealthMetricCard, SimpleDetailTextWidget).
import 'dart:math'; // Para gerar números aleatórios para simulação de dados.

/// Uma tela (ou aba) que exibe informações sobre a "saúde" do veículo.
///
/// Apresenta diversas métricas simuladas, como nível de combustível,
/// vida útil do óleo, pressão dos pneus, status da bateria e temperatura do motor.
/// Os dados podem ser atualizados através de um botão flutuante.
class SaudeScreen extends StatefulWidget {
  /// Cria uma instância de [SaudeScreen].
  const SaudeScreen({super.key});

  @override
  State<SaudeScreen> createState() => _SaudeScreenState();
}

/// O estado para o widget [SaudeScreen].
///
/// Gerencia a lista de dados de saúde (`_healthData`) e a lógica para
/// gerar e atualizar esses dados simulados.
class _SaudeScreenState extends State<SaudeScreen> {
  /// Lista de mapas, onde cada mapa representa uma métrica de saúde do veículo.
  ///
  /// Cada item contém chaves como "icon", "title", "value", "unit", "status",
  /// "progress", "isAlert" e "expandedContent".
  late List<Map<String, dynamic>> _healthData;

  /// Instância de [Random] para gerar valores aleatórios para a simulação dos dados.
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _generateHealthData(); // Gera os dados de saúde iniciais quando o estado é criado.
  }

  /// Gera ou atualiza a lista `_healthData` com valores simulados para as métricas de saúde.
  ///
  /// Simula dados para:
  /// - Combustível (autonomia, nível, alerta de reserva).
  /// - Vida útil do óleo (Km restantes, alerta de substituição).
  /// - Pressão dos pneus (status geral, alerta).
  /// - Bateria (voltagem, status da carga, alerta).
  /// - Temperatura do motor.
  ///
  /// Após gerar os dados, chama `setState` para reconstruir a UI com os novos valores.
  void _generateHealthData() {
    // Simulação de dados de saúde que podem variar.

    // --- Combustível ---
    double maxAutonomy = 450.0; // Autonomia máxima em Km.
    // Gera autonomia atual entre 100Km e a autonomia máxima.
    double currentAutonomy =
        _random.nextDouble() * (maxAutonomy - 100) + 100;
    // Calcula o progresso do combustível (0.0 a 1.0).
    double fuelProgress =
    (maxAutonomy > 0) ? (currentAutonomy / maxAutonomy) : 0.0;

    // --- Vida Útil do Óleo ---
    double maxOilLifeKm = 10000.0; // Km máximos para a vida útil do óleo.
    // Gera Km restantes para a vida útil do óleo.
    double currentOilLifeRemainingKm =
        _random.nextDouble() * maxOilLifeKm;
    // Calcula o progresso da vida útil do óleo (0.0 a 1.0).
    double oilProgress = (maxOilLifeKm > 0)
        ? (currentOilLifeRemainingKm / maxOilLifeKm)
        : 0.0;
    bool oilAlert = oilProgress <= 0.15; // Define alerta se a vida útil for <= 15%.

    // --- Pressão dos Pneus ---
    // Lista de possíveis status para os pneus.
    List<String> tireStatusOptions = [
      "Todos OK",
      "Dianteiro Esq. Baixo",
      "Traseiro Dir. Baixo",
      "Verificar Todos"
    ];
    // Seleciona um status aleatório para os pneus.
    String randomTireStatus =
    tireStatusOptions[_random.nextInt(tireStatusOptions.length)];
    bool tireAlert = randomTireStatus != "Todos OK"; // Define alerta se não estiver "Todos OK".
    String tireValue = tireAlert ? "Atenção" : "OK"; // Valor exibido.
    String tireUnit = tireAlert ? "" : "32 PSI"; // Unidade exibida.

    // --- Bateria ---
    // Gera voltagem da bateria entre 11.8V e 14.4V.
    double batteryVoltage = 11.8 + _random.nextDouble() * (14.4 - 11.8);
    // Normaliza o progresso da bateria (0.0 a 1.0), considerando 11.5V como baixo e 12.8V como bom.
    double batteryProgress = (batteryVoltage - 11.5) / (12.8 - 11.5);
    batteryProgress = batteryProgress.clamp(0.0, 1.0); // Garante que o progresso esteja entre 0 e 1.
    bool batteryAlert = batteryVoltage < 12.0; // Define alerta se a voltagem for < 12.0V.

    // Atualiza o estado com os novos dados de saúde gerados.
    setState(() {
      _healthData = [
        {
          "icon": Icons.local_gas_station_outlined,
          "title": "Combustível",
          "value": currentAutonomy.toStringAsFixed(0),
          "unit": "Km Autonomia",
          "status": fuelProgress > 0.2 // Define o status baseado no progresso.
              ? "Nível Bom"
              : (fuelProgress > 0.1 ? "Nível Baixo" : "Reserva"),
          "progress": fuelProgress,
          "isAlert": fuelProgress <= 0.1, // Alerta se o progresso for <= 10%.
          "expandedContent": SimpleDetailTextWidget( // Conteúdo para expandir.
            label: "Detalhes:",
            value:
            "Consumo médio: ${_random.nextInt(5) + 8} Km/L\nÚltimo abastecimento: ${_random.nextInt(28) + 1}/${_random.nextInt(12) + 1}/2024\nTipo: Gasolina",
          ),
        },
        {
          "icon": Icons.oil_barrel_outlined,
          "title": "Vida Útil do Óleo",
          "value": currentOilLifeRemainingKm.toStringAsFixed(0),
          "unit": "Km restantes",
          "status": oilAlert
              ? "Substituir em Breve!"
              : "Nível Normal (${(oilProgress * 100).toStringAsFixed(0)}%)",
          "progress": oilProgress,
          "isAlert": oilAlert,
          "expandedContent": SimpleDetailTextWidget(
            label: "Recomendações:",
            value:
            "Tipo de óleo: 5W-30 Sintético\nPróxima troca em: ${maxOilLifeKm.toStringAsFixed(0)} Kms ou 1 ano",
          ),
        },
        {
          "icon": Icons.tire_repair_outlined,
          "title": "Pressão dos Pneus",
          "value": tireValue,
          "unit": tireUnit,
          "status": randomTireStatus,
          "isAlert": tireAlert,
          // "progress": tireAlert ? 0.1 : 0.9, // Comentário original: Opcional: progresso visual para alerta
          "expandedContent": SimpleDetailTextWidget(
              label: "Detalhes:",
              value: tireAlert
                  ? "Verifique a pressão individual dos pneus no painel do veículo ou em um posto."
                  : "Pressão ideal: 32 PSI (frio). Verifique o manual para especificações exatas."),
        },
        {
          "icon": Icons.battery_charging_full_outlined,
          "title": "Bateria (12V)",
          "value": batteryVoltage.toStringAsFixed(1),
          "unit": "V",
          "status": batteryAlert
              ? "Carga Baixa"
              : (batteryVoltage < 12.4 ? "Carga OK" : "Carga Boa"),
          "progress": batteryProgress,
          "isAlert": batteryAlert,
          "expandedContent": const SimpleDetailTextWidget(
            label: "Info:",
            value:
            "Data de fabricação: 01/2023\nVida útil estimada: 2-4 anos\nVerifique os terminais.",
          ),
        },
        {
          "icon": Icons.thermostat_outlined,
          "title": "Temperatura Motor",
          "value": "${_random.nextInt(15) + 85}", // Gera temperatura entre 85°C e 100°C.
          "unit": "°C",
          "status": "Normal",
          // Normaliza o progresso da temperatura (considerando 70°C como mínimo e 110°C como máximo para a barra).
          "progress": ((_random.nextInt(15) + 85) - 70) / (110 - 70),
          "isAlert": false, // Assume que a temperatura gerada está sempre normal para esta simulação.
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Comentário original: Já usado dentro dos widgets reutilizáveis

    return Scaffold(
      // Comentário original: AppBar pode ser adicionado aqui se a SaudeScreen for uma tela independente
      // appBar: AppBar(title: const Text("Saúde do Veículo")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12), // Espaçamento ao redor da lista.
        itemCount: _healthData.length, // Número de itens na lista de dados de saúde.
        itemBuilder: (context, index) {
          final item = _healthData[index]; // Obtém o item de saúde atual.
          // Constrói um HealthMetricCard para cada item de saúde.
          return HealthMetricCard(
            icon: item["icon"] as IconData,
            title: item["title"] as String,
            value: item["value"] as String,
            unit: item["unit"] as String,
            status: item["status"] as String,
            progress: item["progress"] as double?,
            isAlert: item["isAlert"] as bool? ?? false, // Usa ?? false para garantir um valor booleano.
            expandedContent: item["expandedContent"] as Widget?,
          );
        },
      ),
      // Botão flutuante para atualizar os dados de saúde.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _generateHealthData, // Chama o método para gerar novos dados.
        label: const Text("Atualizar Saúde"),
        icon: const Icon(Icons.refresh),
        // Comentário original: backgroundColor: theme.colorScheme.secondary, // Opcional: cor específica
        // Comentário original: foregroundColor: theme.colorScheme.onSecondary,
      ),
      // Posição do botão flutuante.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}