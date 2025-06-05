// lib/profile_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Tela de login, para navegação ao sair.
import 'edit_profile_screen.dart'; // Tela para editar informações do perfil.
import 'app_settings_screen.dart'; // Tela para configurações do aplicativo.
import 'terms_of_service_screen.dart'; // Tela para exibir os Termos de Serviço.
import 'privacy_policy_screen.dart'; // Tela para exibir a Política de Privacidade.


/// Tela que exibe o perfil do usuário e oferece opções de navegação
/// para outras seções relacionadas a configurações e informações da conta.
class ProfileScreen extends StatelessWidget {
  /// O nome do usuário a ser exibido no perfil.
  final String userName;
  /// O email do usuário a ser exibido no perfil.
  final String userEmail;

  /// Cria uma instância de [ProfileScreen].
  ///
  /// [userName] e [userEmail] são obrigatórios.
  const ProfileScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Acessa o tema atual para estilização.

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil e Configurações"), // Título da AppBar.
      ),
      body: ListView(
        padding: const EdgeInsets.all(0), // Remove o padding padrão do ListView.
        children: <Widget>[
          // Seção de cabeçalho do perfil com avatar, nome e email.
          Container(
            padding: const EdgeInsets.fromLTRB(24.0, 48.0, 24.0, 24.0), // Espaçamento interno.
            color: theme.colorScheme.primaryContainer, // Cor de fundo do container.
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50, // Raio do avatar.
                  backgroundColor: theme.colorScheme.primary, // Cor de fundo do avatar.
                  child: Text(
                    // Exibe a primeira letra do nome do usuário em maiúsculas, ou "U" se o nome estiver vazio.
                    userName.isNotEmpty ? userName[0].toUpperCase() : "U",
                    style: TextStyle(fontSize: 40, color: theme.colorScheme.onPrimary),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userName, // Nome do usuário.
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail, // Email do usuário.
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16), // Espaçador vertical.

          // Opções do Menu de Perfil e Configurações.
          _buildProfileOptionTile(
            context: context,
            icon: Icons.edit_outlined,
            title: "Editar Perfil",
            onTap: () {
              // Navega para a tela de edição de perfil.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),
          _buildProfileOptionTile(
            context: context,
            icon: Icons.settings_outlined,
            title: "Configurações do App",
            onTap: () {
              // Navega para a tela de configurações do aplicativo.
              Navigator.push( // NAVEGAÇÃO REAL (Comentário original mantido)
                context,
                MaterialPageRoute(builder: (context) => const AppSettingsScreen()),
              );
            },
          ),
          _buildProfileOptionTile( // Mantido como simulação por enquanto, ou pode criar uma tela (Comentário original mantido)
            context: context,
            icon: Icons.notifications_outlined,
            title: "Notificações",
            onTap: () {
              // Simula a navegação para configurações de notificações.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Navegar para Configurações de Notificações (simulado)")),
              );
            },
          ),
          const Divider(), // Linha divisória.
          _buildProfileOptionTile(
            context: context,
            icon: Icons.description_outlined, // Ícone para Termos (Comentário original mantido)
            title: "Termos de Serviço",
            onTap: () {
              // Navega para a tela de Termos de Serviço.
              Navigator.push( // NAVEGAÇÃO REAL (Comentário original mantido)
                context,
                MaterialPageRoute(builder: (context) => const TermsOfServiceScreen()),
              );
            },
          ),
          _buildProfileOptionTile(
            context: context,
            icon: Icons.privacy_tip_outlined, // Ícone para Privacidade (Comentário original mantido)
            title: "Política de Privacidade",
            onTap: () {
              // Navega para a tela de Política de Privacidade.
              Navigator.push( // NAVEGAÇÃO REAL (Comentário original mantido)
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
              );
            },
          ),
          _buildProfileOptionTile( // Mantido como simulação por enquanto, ou pode integrar com a AjudaScreen (Comentário original mantido)
            context: context,
            icon: Icons.help_outline,
            title: "Ajuda e Suporte",
            onTap: () {
              // Simula a navegação para a tela de Ajuda e Suporte.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Navegar para Ajuda e Suporte (simulado)")),
              );
            },
          ),
          const Divider(), // Linha divisória.
          _buildProfileOptionTile(
            context: context,
            icon: Icons.logout,
            title: "Sair",
            textColor: theme.colorScheme.error, // Cor de texto para indicar ação destrutiva/importante.
            iconColor: theme.colorScheme.error, // Cor do ícone para indicar ação destrutiva/importante.
            onTap: () {
              // Realiza o logout, removendo todas as rotas anteriores e navegando para LoginScreen.
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false, // Predicado que remove todas as rotas.
              );
            },
          ),
          const SizedBox(height: 20), // Espaçador no final da lista.
        ],
      ),
    );
  }

  /// Constrói um item de lista (ListTile) para as opções do perfil.
  ///
  /// [context]: O contexto de build.
  /// [icon]: O ícone a ser exibido à esquerda do título.
  /// [title]: O texto do título da opção.
  /// [onTap]: A função a ser chamada quando o item é tocado.
  /// [textColor]: Cor opcional para o texto do título.
  /// [iconColor]: Cor opcional para o ícone.
  Widget _buildProfileOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    final theme = Theme.of(context); // Acessa o tema atual.
    return ListTile(
      leading: Icon(icon, color: iconColor ?? theme.listTileTheme.iconColor), // Ícone à esquerda.
      title: Text(
        title,
        // Aplica a cor de texto fornecida ou o padrão do tema para ListTile.
        style: (textColor != null)
            ? theme.listTileTheme.titleTextStyle?.copyWith(color: textColor)
            : theme.listTileTheme.titleTextStyle,
      ),
      trailing: Icon(Icons.keyboard_arrow_right, color: theme.colorScheme.outline), // Ícone de seta à direita.
      onTap: onTap, // Ação ao tocar.
    );
  }
}