// lib/privacy_policy_screen.dart
import 'package:flutter/material.dart';

/// Uma tela que exibe a Política de Privacidade do aplicativo.
///
/// Apresenta o conteúdo da política em um formato legível, utilizando
/// seções e parágrafos para detalhar como as informações (simuladas)
/// do usuário são tratadas.
class PrivacyPolicyScreen extends StatelessWidget {
  /// Cria uma instância de [PrivacyPolicyScreen].
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Acessa o tema atual para estilização.

    return Scaffold(
      appBar: AppBar(
        title: const Text("Política de Privacidade"), // Título da AppBar.
      ),
      body: SingleChildScrollView( // Permite rolagem se o texto for longo.
        padding: const EdgeInsets.all(16.0), // Espaçamento interno da tela.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo à esquerda.
          children: [
            // Título principal da página.
            Text(
              "Política de Privacidade",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            // Introdução à política.
            Text(
              "Sua privacidade é importante para nós. Esta política descreve como coletamos, usamos e protegemos suas informações pessoais.",
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            // Seção 1: Informações que Coletamos.
            _buildSectionTitle(theme, "1. Informações que Coletamos"),
            _buildParagraph(theme, "Podemos coletar informações que você nos fornece diretamente, como seu nome e e-mail ao criar uma conta (simulado). Nenhuma informação pessoal real é coletada ou armazenada, pois este é um aplicativo de demonstração."),
            const SizedBox(height: 12),
            // Seção 2: Como Usamos Suas Informações.
            _buildSectionTitle(theme, "2. Como Usamos Suas Informações"),
            _buildParagraph(theme, "As informações simuladas são usadas apenas para personalizar sua experiência dentro do aplicativo (ex: nome de usuário exibido)."),
            const SizedBox(height: 12),
            // Seção 3: Compartilhamento de Informações.
            _buildSectionTitle(theme, "3. Compartilhamento de Informações"),
            _buildParagraph(theme, "Não compartilhamos suas informações pessoais simuladas com terceiros."),
            const SizedBox(height: 12),
            // Seção 4: Segurança.
            _buildSectionTitle(theme, "4. Segurança"),
            _buildParagraph(theme, "Em um aplicativo real, implementaríamos medidas de segurança para proteger suas informações. Neste aplicativo de simulação, os dados são locais e temporários."),
            const SizedBox(height: 24),
            // Data da última atualização.
            Center(
              child: Text(
                "Última atualização: [Data Atual]", // Placeholder para a data.
                style: theme.textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói um widget de título para uma seção da política.
  ///
  /// [theme]: O tema atual para estilização.
  /// [title]: O texto do título da seção.
  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0), // Espaçamento vertical.
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Constrói um widget de parágrafo para o texto da política.
  ///
  /// [theme]: O tema atual para estilização.
  /// [text]: O conteúdo do parágrafo.
  Widget _buildParagraph(ThemeData theme, String text) {
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5), // Altura da linha para melhor legibilidade.
      textAlign: TextAlign.justify, // Justifica o texto do parágrafo.
    );
  }
}