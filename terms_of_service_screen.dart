// lib/terms_of_service_screen.dart
import 'package:flutter/material.dart';

/// Uma tela que exibe os Termos de Serviço do aplicativo.
///
/// Apresenta o conteúdo dos termos em um formato legível, utilizando
/// seções e parágrafos.
class TermsOfServiceScreen extends StatelessWidget {
  /// Cria uma instância de [TermsOfServiceScreen].
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Acessa o tema atual para estilização.

    return Scaffold(
      appBar: AppBar(
        title: const Text("Termos de Serviço"), // Título da AppBar.
      ),
      body: SingleChildScrollView( // Permite rolagem se o texto for longo.
        padding: const EdgeInsets.all(16.0), // Espaçamento interno da tela.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo à esquerda.
          children: [
            // Título principal da página.
            Text(
              "Termos e Condições de Uso",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            // Introdução aos termos.
            Text(
              "Bem-vindo ao nosso aplicativo! Ao utilizá-lo, você concorda com os seguintes termos e condições:",
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            // Seção 1: Aceitação dos Termos.
            _buildSectionTitle(theme, "1. Aceitação dos Termos"),
            _buildParagraph(theme, "Ao acessar ou usar nosso aplicativo, você confirma que leu, entendeu e concorda em estar vinculado por estes Termos de Serviço. Se você não concorda com estes termos, não utilize o aplicativo."),
            const SizedBox(height: 12),
            // Seção 2: Uso do Aplicativo.
            _buildSectionTitle(theme, "2. Uso do Aplicativo"),
            _buildParagraph(theme, "Nosso aplicativo é fornecido para seu uso pessoal e não comercial. Você concorda em não usar o aplicativo para qualquer finalidade ilegal ou proibida por estes termos."),
            _buildParagraph(theme, "Este aplicativo é uma simulação e não se conecta a um veículo real. Todas as funcionalidades de controle e dados do veículo são simulados para fins de demonstração e aprendizado."),
            const SizedBox(height: 12),
            // Seção 3: Conteúdo Gerado pelo Usuário (Exemplo).
            _buildSectionTitle(theme, "3. Conteúdo Gerado pelo Usuário"),
            _buildParagraph(theme, "(Se aplicável) Você é o único responsável por qualquer conteúdo que enviar ou transmitir através do aplicativo..."),
            const SizedBox(height: 12),
            // Seção 4: Limitação de Responsabilidade (Exemplo).
            _buildSectionTitle(theme, "4. Limitação de Responsabilidade"),
            _buildParagraph(theme, "O aplicativo é fornecido \"como está\" e \"conforme disponível\", sem garantias de qualquer tipo..."),
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

  /// Constrói um widget de título para uma seção dos termos.
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

  /// Constrói um widget de parágrafo para o texto dos termos.
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