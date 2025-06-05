// lib/controle_screen.dart
import 'package:flutter/material.dart';
import 'dart:math'; // Para a temperatura randômica
// Removido o import de 'reusable_widgets.dart' se ControlButton for definido aqui
// ou se você for ajustar o ControlButton existente. (Comentário original mantido)

/// Uma tela (ou aba) que simula os controles remotos de um veículo.
///
/// Permite ao usuário interagir com funcionalidades como trancar/destravar portas,
/// alterar o status geral do veículo, controlar o ar condicionado e
/// acionar outros controles rápidos simulados.
class ControleScreen extends StatefulWidget {
  /// Cria uma instância de [ControleScreen].
  const ControleScreen({super.key});

  @override
  State<ControleScreen> createState() => _ControleScreenState();
}

/// O estado para o widget [ControleScreen].
///
/// Gerencia o estado dos diversos controles simulados, como o status de trava,
/// status geral do veículo, temperatura do ar condicionado e o estado
/// dos controles rápidos.
class _ControleScreenState extends State<ControleScreen> {
  // Estados para os botões de trava e status geral (mantidos do seu código)
  /// Indica se o veículo está trancado (`true`) ou destrancado (`false`).
  bool _isLocked = true;
  /// Representa o status geral atual do veículo (ex: "Desligado", "Ligado").
  String _generalStatus = "Desligado";
  /// Índice atual na lista `_possibleStatuses` para controlar o status geral.
  int _currentStatusIndex = 0;
  /// Lista de possíveis status gerais do veículo, cada um com um rótulo, ícone e cor.
  final List<Map<String, dynamic>> _possibleStatuses = [
    {"label": "Desligado", "icon": Icons.power_settings_new_rounded, "color": Colors.grey.shade600},
    {"label": "Ligado", "icon": Icons.flash_on_rounded, "color": Colors.green.shade600},
    {"label": "Em Movimento", "icon": Icons.drive_eta_rounded, "color": Colors.blue.shade600},
    {"label": "Alerta Ativo", "icon": Icons.warning_amber_rounded, "color": Colors.orange.shade700},
  ];

  // Estados para o Ar Condicionado
  /// A temperatura selecionada pelo usuário para o ar condicionado.
  double _selectedAcTemperature = 22.0;
  /// A temperatura atual simulada do ar condicionado no interior do veículo.
  late double _currentAcTemperature;

  // Estados para os botões de controle rápido
  /// Um mapa que armazena o estado (ligado/desligado) de cada controle rápido.
  /// As chaves são os nomes dos controles (ex: "Alarme") e os valores são booleanos.
  final Map<String, bool> _quickControlsState = { // Alterado para final, pois a referência do Map não muda.
    "Alarme": false,
    "Pisca": false,
    "Farol": false,
    "Vidros": false,
    "Som": false,
    "Farol Milha": false,
    "Ar Cond. On/Off": false, // Controle de ligar/desligar o AC
    "Ligar Motor": false,
    "Porta Malas": false,
  };

  @override
  void initState() {
    super.initState();
    // Inicializa a temperatura atual do AC com um valor randômico entre 18 e 27 graus.
    _currentAcTemperature = 18.0 + Random().nextInt(10);
  }

  /// Alterna o status geral do veículo para o próximo na lista `_possibleStatuses`.
  ///
  /// Exibe uma [SnackBar] informando a mudança de status.
  void _cycleGeneralStatus() {
    setState(() {
      _currentStatusIndex = (_currentStatusIndex + 1) % _possibleStatuses.length;
      _generalStatus = _possibleStatuses[_currentStatusIndex]["label"];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Status Geral alterado para: $_generalStatus"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  /// Alterna o estado de trava do veículo (trancado/destrancado).
  ///
  /// Exibe uma [SnackBar] informando o novo estado de trava.
  void _toggleLock() {
    setState(() {
      _isLocked = !_isLocked;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isLocked ? "Veículo Trancado" : "Veículo Destrancado"),
        duration: const Duration(seconds: 1),
        backgroundColor: _isLocked ? Colors.blueAccent : Colors.green,
      ),
    );
  }

  /// Alterna o estado de um controle rápido específico.
  ///
  /// [controlName]: A chave do controle no mapa `_quickControlsState`.
  /// Exibe uma [SnackBar] informando o novo estado do controle.
  void _toggleQuickControl(String controlName) {
    setState(() {
      _quickControlsState[controlName] = !_quickControlsState[controlName]!;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "$controlName: ${_quickControlsState[controlName]! ? 'Ativado' : 'Desativado'} (simulado)"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  /// Constrói um widget de botão para as ações de trancar ou destrancar. (mantido do seu código)
  ///
  /// [icon]: O ícone a ser exibido no botão.
  /// [label]: O texto do rótulo do botão.
  /// [onTap]: A função a ser chamada quando o botão é pressionado. `null` para desabilitar.
  /// [isActive]: Indica se o estado representado pelo botão está ativo.
  /// [activeColor]: A cor a ser usada quando o botão representa um estado ativo.
  Widget _buildLockControlButtonV2({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    required bool isActive,
    required Color activeColor,
  }) {
    final theme = Theme.of(context); // Obtém o tema atual.
    return Expanded( // Ocupa o espaço disponível na Row.
      child: InkWell(
        onTap: onTap, // Define a ação de toque.
        borderRadius: BorderRadius.circular(10), // Bordas arredondadas para o efeito de toque.
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          decoration: BoxDecoration(
            // Cor de fundo sutil se ativo, transparente caso contrário.
            color: isActive ? activeColor.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(10), // Bordas arredondadas do container.
            border: Border.all( // Borda do container.
              color: isActive ? activeColor : Colors.grey[300]!,
              width: isActive ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ocupa o mínimo de espaço vertical.
            children: [
              Icon(
                icon,
                size: 36,
                // Cor do ícone baseada no estado (habilitado/desabilitado, ativo/inativo).
                color: onTap == null
                    ? Colors.grey[400]
                    : (isActive ? activeColor : theme.textTheme.bodyLarge?.color ?? Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  // Cor e peso da fonte do texto baseados no estado.
                  color: onTap == null
                      ? Colors.grey[400]
                      : (isActive ? activeColor : theme.textTheme.bodyLarge?.color ?? Colors.black87),
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Constrói o card que exibe o status geral do veículo. (mantido do seu código)
  Widget _buildGeneralStatusCard() {
    final theme = Theme.of(context); // Obtém o tema atual.
    // Obtém a configuração (ícone, cor) para o status atual.
    final currentStatusConfig = _possibleStatuses[_currentStatusIndex];
    final Color statusColor = currentStatusConfig["color"] as Color;
    final IconData statusIcon = currentStatusConfig["icon"] as IconData;

    return Card(
      elevation: 4,
      color: statusColor.withOpacity(0.1), // Cor de fundo sutil baseada no status.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: statusColor, width: 1.5), // Borda colorida baseada no status.
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça os elementos.
          children: [
            Row( // Agrupa ícone e texto do status.
              children: [
                Icon(statusIcon, color: statusColor, size: 28),
                const SizedBox(width: 12),
                Text(
                  "Status: ",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  _generalStatus, // Exibe o status atual.
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            TextButton( // Botão para ciclar o status.
              onPressed: _cycleGeneralStatus,
              child: Text("Mudar", style: TextStyle(color: statusColor)),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                side: BorderSide(color: statusColor.withOpacity(0.5)), // Borda sutil no botão.
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Constrói o card de controle do ar condicionado.
  ///
  /// Inclui um [Switch] para ligar/desligar o AC e um [Slider] para
  /// selecionar a temperatura desejada.
  Widget _buildAcControlCard() {
    final theme = Theme.of(context); // Obtém o tema atual.
    // Verifica se o ar condicionado está ligado com base no estado em `_quickControlsState`.
    bool isAcOn = _quickControlsState["Ar Cond. On/Off"] ?? false;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder( // Adicionar/Padronizar (Comentário original mantido)
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo à esquerda.
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça título e switch.
              children: [
                Text(
                  "Ar Condicionado",
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Transform.scale( // Reduz o tamanho do switch.
                  scale: 0.8,
                  child: Switch(
                    value: isAcOn, // Estado atual do switch.
                    onChanged: (value) {
                      // Alterna o estado do controle "Ar Cond. On/Off".
                      _toggleQuickControl("Ar Cond. On/Off");
                    },
                    activeColor: theme.primaryColor, // Cor do switch quando ativo.
                  ),
                )
              ],
            ),
            const Divider(), // Linha divisória.
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça as temperaturas.
              children: [
                Text("Temp. Atual: ${_currentAcTemperature.toStringAsFixed(0)}°C", style: theme.textTheme.bodyMedium),
                Text("Selecionada: ${_selectedAcTemperature.toStringAsFixed(0)}°C", style: theme.textTheme.titleMedium?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              value: _selectedAcTemperature, // Valor atual do slider.
              min: 16, // Temperatura mínima.
              max: 30, // Temperatura máxima.
              divisions: 14, // Número de divisões (30-16).
              label: "${_selectedAcTemperature.toStringAsFixed(0)}°C", // Rótulo exibido ao arrastar.
              // Habilita o slider apenas se o AC estiver ligado.
              onChanged: isAcOn ? (double value) {
                setState(() {
                  _selectedAcTemperature = value; // Atualiza a temperatura selecionada.
                });
              } : null,
              activeColor: theme.primaryColor, // Cor da parte ativa do slider.
              inactiveColor: Colors.grey[300], // Cor da parte inativa do slider.
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói um botão para a grade de controles rápidos.
  ///
  /// [defaultIcon]: O ícone padrão para o estado desligado/inativo.
  /// [activeIcon]: O ícone opcional para o estado ligado/ativo.
  /// [label]: O rótulo do botão.
  /// [controlKey]: A chave usada para identificar o estado deste controle em `_quickControlsState`.
  Widget _buildQuickControlButton({
    required IconData defaultIcon,
    IconData? activeIcon,
    required String label,
    required String controlKey,
  }) {
    final theme = Theme.of(context); // Obtém o tema atual.
    // Verifica o estado atual do controle.
    final bool isActive = _quickControlsState[controlKey] ?? false;
    final Color activeColor = theme.primaryColor; // Cor para o estado ativo.

    IconData currentIcon = defaultIcon; // Ícone padrão.
    // Se estiver ativo e um ícone ativo for fornecido, usa o ícone ativo.
    if (isActive && activeIcon != null) {
      currentIcon = activeIcon;
    }

    // Lógica específica para o ícone do botão "Ligar Motor".
    if (controlKey == "Ligar Motor") {
      currentIcon = isActive ? Icons.flash_on_rounded : Icons.power_settings_new_rounded;
    }
    // Você pode adicionar mais 'else if' aqui para outros botões (Comentário original mantido)
    // que precisem de ícones dinâmicos diferentes do par default/activeIcon.

    return InkWell(
      onTap: () => _toggleQuickControl(controlKey), // Alterna o estado do controle ao tocar.
      borderRadius: BorderRadius.circular(10), // Bordas arredondadas para o efeito de toque.
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        decoration: BoxDecoration(
          // Cor de fundo baseada no estado (ativo/inativo).
          color: isActive ? activeColor.withOpacity(0.15) : Colors.grey[100],
          borderRadius: BorderRadius.circular(10), // Bordas arredondadas do container.
          border: Border.all( // Borda do container.
            color: isActive ? activeColor : Colors.grey[300]!,
            width: 1.0,
          ),
          // Sombra sutil se o botão estiver ativo.
          boxShadow: isActive
              ? [
            BoxShadow(
              color: activeColor.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            )
          ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o conteúdo verticalmente.
          children: [
            Icon(
              currentIcon, // USA O ÍCONE DINÂMICO AQUI (Comentário original mantido)
              size: 30,
              // Cor do ícone baseada no estado.
              color: isActive ? activeColor : Colors.grey[700],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                // Cor e peso da fonte do texto baseados no estado.
                color: isActive ? activeColor : Colors.grey[800],
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtém o tema atual.
    // Utiliza ListView para permitir rolagem caso o conteúdo exceda a tela.
    return ListView(
      padding: const EdgeInsets.all(16), // Espaçamento geral da tela.
      children: [
        // Card de Status Geral.
        _buildGeneralStatusCard(),
        const SizedBox(height: 20),
        // Botões de Trancar/Destrancar.
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder( // Adicionar/Padronizar (Comentário original mantido)
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaça os botões.
              children: [
                _buildLockControlButtonV2(
                  icon: Icons.lock_outline_rounded,
                  label: "Trancar",
                  // Habilita o botão apenas se o veículo não estiver trancado.
                  onTap: _isLocked ? null : _toggleLock,
                  isActive: _isLocked, // Indica se o estado "Trancado" está ativo.
                  activeColor: theme.primaryColor,
                ),
                const SizedBox(width: 12),
                _buildLockControlButtonV2(
                  icon: Icons.lock_open_rounded,
                  label: "Destrancar",
                  // Habilita o botão apenas se o veículo estiver trancado.
                  onTap: !_isLocked ? null : _toggleLock,
                  isActive: !_isLocked, // Indica se o estado "Destrancado" está ativo.
                  activeColor: Colors.green.shade600,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Card de Controle do Ar Condicionado.
        _buildAcControlCard(),

        const SizedBox(height: 24),
        // Título para a seção de "Outros Controles".
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
          child: Text(
            "Outros Controles",
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: Colors.grey[700]),
          ),
        ),
        // Grade de botões para controles rápidos.
        GridView.count(
          crossAxisCount: 3, // 3 colunas na grade.
          shrinkWrap: true, // Ajusta o tamanho da grade ao conteúdo.
          physics: const NeverScrollableScrollPhysics(), // Desabilita rolagem da grade (ListView já rola).
          crossAxisSpacing: 12, // Espaçamento horizontal entre os botões.
          mainAxisSpacing: 12, // Espaçamento vertical entre os botões.
          children: [
            // Definição de cada botão de controle rápido.
            _buildQuickControlButton(defaultIcon: Icons.notifications_active_outlined, label: "Alarme", controlKey: "Alarme"),
            _buildQuickControlButton(defaultIcon: Icons.lightbulb_outline_rounded, label: "Pisca", controlKey: "Pisca"),
            _buildQuickControlButton(defaultIcon: Icons.highlight_outlined, label: "Farol", controlKey: "Farol"),
            _buildQuickControlButton(defaultIcon: Icons.sensor_window_outlined, label: "Vidros", controlKey: "Vidros"),
            _buildQuickControlButton(defaultIcon: Icons.volume_up_outlined, label: "Som", controlKey: "Som"),
            _buildQuickControlButton(defaultIcon: Icons.flare_outlined, label: "Farol Milha", controlKey: "Farol Milha"),
            _buildQuickControlButton(
                defaultIcon: Icons.power_settings_new_rounded, // Ícone para estado desligado
                activeIcon: Icons.flash_on_rounded,         // Ícone para estado ligado (opcional, pois a lógica interna já trata "Ligar Motor")
                label: "Ligar Motor",
                controlKey: "Ligar Motor"
            ),
            _buildQuickControlButton(defaultIcon: Icons.key_outlined, label: "Porta Malas", controlKey: "Porta Malas"),
            // Adicione mais _buildQuickControlButton aqui se necessário.
          ],
        ),
      ],
    );
  }
}