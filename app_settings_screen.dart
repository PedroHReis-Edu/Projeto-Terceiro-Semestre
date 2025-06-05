// lib/app_settings_screen.dart
import 'package:flutter/material.dart';

/// Uma tela para o usuário configurar diversas opções do aplicativo.
///
/// Inclui configurações simuladas para aparência (modo escuro, tamanho da fonte),
/// notificações (e-mail) e outras opções como idioma e limpeza de cache.
/// A persistência real dessas configurações não está implementada.
class AppSettingsScreen extends StatefulWidget {
  /// Cria uma instância de [AppSettingsScreen].
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

/// O estado para o widget [AppSettingsScreen].
///
/// Gerencia os estados das opções de configuração, como
/// `_isDarkModeEnabled`, `_receiveEmailNotifications` e `_fontSizeMultiplier`.
class _AppSettingsScreenState extends State<AppSettingsScreen> {
  /// Controla o estado simulado do modo escuro.
  bool _isDarkModeEnabled = false; // Estado para o modo escuro simulado
  /// Controla o estado simulado das notificações por e-mail.
  bool _receiveEmailNotifications = true; // Estado para notificações por e-mail
  /// Controla o multiplicador simulado para o tamanho da fonte.
  double _fontSizeMultiplier = 1.0; // Estado para o tamanho da fonte

  // TODO: Em um app real, esses valores seriam lidos de SharedPreferences ou similar.
  // (Comentário original mantido)

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Acessa o tema atual para estilização.

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações do App"), // Título da AppBar.
      ),
      body: ListView( // Alterado para ListView para acomodar mais opções (Comentário original mantido)
        padding: const EdgeInsets.all(0), // Sem padding no ListView, ListTile cuidará (Comentário original mantido)
        children: [
          const SizedBox(height: 20), // Espaçador no topo da lista.
          // Seção de configurações de Aparência.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Aparência",
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Opção para alternar o Modo Escuro (simulado).
          SwitchListTile(
            title: Text(
              "Modo Escuro (Simulado)",
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              _isDarkModeEnabled ? "Ativado" : "Desativado",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            value: _isDarkModeEnabled,
            onChanged: (bool value) {
              setState(() {
                _isDarkModeEnabled = value; // Atualiza o estado do modo escuro.
              });
              // Exibe uma mensagem de feedback.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Modo Escuro ${value ? 'ativado' : 'desativado'} (simulado)."),
                  duration: const Duration(seconds: 1),
                ),
              );
              // TODO: Em um app real, você aplicaria o tema escuro e salvaria a preferência.
              // (Comentário original mantido)
            },
            secondary: Icon(
              _isDarkModeEnabled ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
              color: theme.colorScheme.primary,
            ),
            activeColor: theme.colorScheme.primary, // Cor do switch quando ativo (Comentário original mantido)
          ),
          // Opção para ajustar o Tamanho da Fonte (simulado).
          ListTile(
            title: Text("Tamanho da Fonte (Simulado)", style: theme.textTheme.titleMedium),
            subtitle: Text("Multiplicador: ${_fontSizeMultiplier.toStringAsFixed(1)}x", style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),),
            trailing: SizedBox(
              width: 150, // Ajuste a largura conforme necessário (Comentário original mantido)
              child: Slider(
                value: _fontSizeMultiplier,
                min: 0.8,
                max: 1.5,
                divisions: 7, // (1.5 - 0.8) / 0.1 = 7 (Comentário original mantido)
                label: _fontSizeMultiplier.toStringAsFixed(1), // Rótulo exibido ao arrastar.
                onChanged: (double value) {
                  setState(() {
                    _fontSizeMultiplier = value; // Atualiza o multiplicador de fonte.
                  });
                  // TODO: Em um app real, você aplicaria o multiplicador de fonte ao tema.
                  // (Comentário original mantido)
                },
                activeColor: theme.colorScheme.primary,
              ),
            ),
          ),
          const Divider(), // Linha divisória.
          // Seção de configurações de Notificações.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Notificações",
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Opção para alternar Notificações por E-mail (simulado).
          SwitchListTile(
            title: Text(
              "Notificações por E-mail",
              style: theme.textTheme.titleMedium,
            ),
            subtitle: Text(
              _receiveEmailNotifications ? "Ativadas" : "Desativadas",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            value: _receiveEmailNotifications,
            onChanged: (bool value) {
              setState(() {
                _receiveEmailNotifications = value; // Atualiza o estado das notificações por e-mail.
              });
              // Exibe uma mensagem de feedback.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Notificações por e-mail ${value ? 'ativadas' : 'desativadas'} (simulado)."),
                  duration: const Duration(seconds: 1),
                ),
              );
              // TODO: Em um app real, você salvaria essa preferência.
              // (Comentário original mantido)
            },
            secondary: Icon(
              _receiveEmailNotifications ? Icons.mark_email_read_outlined : Icons.email_outlined,
              color: theme.colorScheme.primary,
            ),
            activeColor: theme.colorScheme.primary,
          ),
          const Divider(), // Linha divisória.
          // Seção de "Outros" configurações.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Outros",
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Opção para Idioma (simulado).
          ListTile(
            leading: Icon(Icons.language_outlined, color: theme.colorScheme.primary),
            title: Text("Idioma", style: theme.textTheme.titleMedium),
            subtitle: Text("Português (Brasil)", style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: theme.colorScheme.outline),
            onTap: () {
              // Simula a ação de seleção de idioma.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Seleção de idioma (simulado)."),
                  duration: Duration(seconds: 1),
                ),
              );
              // TODO: Navegar para uma tela de seleção de idioma.
              // (Comentário original mantido)
            },
          ),
          // Opção para Limpar Cache (simulado).
          ListTile(
            leading: Icon(Icons.delete_sweep_outlined, color: theme.colorScheme.error),
            title: Text("Limpar Cache (Simulado)", style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.error)),
            onTap: () {
              // Simula a ação de limpar cache.
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Cache limpo (simulado)!"),
                  backgroundColor: theme.colorScheme.primary, // Usar uma cor de sucesso ou primária (Comentário original mantido)
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}