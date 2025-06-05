// lib/edit_profile_screen.dart
import 'package:flutter/material.dart';

/// Uma tela que permite ao usuário editar suas informações de perfil.
///
/// Atualmente, simula a edição de nome e e-mail, e inclui um campo
/// para uma nova senha (opcional), mas a lógica de salvamento real
/// (backend, estado global) não está implementada.
class EditProfileScreen extends StatefulWidget {
  /// Cria uma instância de [EditProfileScreen].
  const EditProfileScreen({super.key});

  // TODO: Em um app real, você passaria os dados atuais do usuário para esta tela
  // e os usaria para inicializar os controladores.
  // Ex: final String currentUserName;
  //     final String currentUserEmail;
  //     const EditProfileScreen({super.key, required this.currentUserName, required this.currentUserEmail});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

/// O estado para o widget [EditProfileScreen].
///
/// Gerencia os controladores de texto para os campos de nome e e-mail,
/// e a lógica para simular o salvamento das alterações do perfil.
class _EditProfileScreenState extends State<EditProfileScreen> {
  /// Controlador para o campo de texto do nome.
  late TextEditingController _nameController;
  /// Controlador para o campo de texto do e-mail.
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores. Em um app real, você os inicializaria
    // com os dados atuais do usuário.
    _nameController = TextEditingController(text: "Usuário Exemplo"); // Simulado
    _emailController = TextEditingController(text: "usuario@exemplo.com"); // Simulado
  }

  @override
  void dispose() {
    // Libera os recursos dos controladores de texto quando o widget é descartado.
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Simula o salvamento das alterações do perfil.
  ///
  /// Obtém os novos valores dos campos de nome e e-mail e exibe uma
  /// [SnackBar] de confirmação. A lógica de persistência real não está implementada.
  void _saveProfileChanges() {
    // Lógica para salvar alterações (simulado por enquanto)
    String newName = _nameController.text;
    String newEmail = _emailController.text;

    // TODO: Em um app real, você validaria os dados e os enviaria para um backend
    // ou atualizaria um estado global/local.
    // Por agora, apenas mostramos um SnackBar e podemos simular o retorno dos dados.

    // Exibe uma mensagem de feedback para o usuário.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Perfil atualizado para: $newName, $newEmail (simulado)!"),
        backgroundColor: Colors.green, // Cor de fundo para sucesso.
      ),
    );

    // Opcional: Retornar os dados atualizados para a tela anterior
    // Navigator.pop(context, {'name': newName, 'email': newEmail});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Acessa o tema atual para estilização.

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil"), // Título da AppBar.
      ),
      body: SingleChildScrollView( // Adicionado para evitar overflow com teclado.
        padding: const EdgeInsets.all(16.0), // Espaçamento interno da tela.
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center, // Removido para alinhar ao topo
          crossAxisAlignment: CrossAxisAlignment.stretch, // Para o botão ocupar a largura.
          children: [
            const SizedBox(height: 20), // Espaço no topo.
            // Ícone representativo do perfil.
            Icon(
              Icons.person_pin_circle_outlined, // Ícone diferente
              size: 80,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 30),
            // Campo de texto para o nome completo.
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nome Completo",
                hintText: "Seu nome como será exibido",
                prefixIcon: Icon(Icons.person_outline, color: theme.colorScheme.primary),
                // border: OutlineInputBorder(), // O InputDecorationTheme já cuida disso (Comentário original mantido)
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            // Campo de texto para o e-mail.
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-mail",
                hintText: "Seu endereço de e-mail",
                prefixIcon: Icon(Icons.email_outlined, color: theme.colorScheme.primary),
                // border: OutlineInputBorder(), // O InputDecorationTheme já cuida disso (Comentário original mantido)
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Campo de texto para a nova senha (opcional).
            TextFormField(
              // controller: _passwordController, // Se fosse adicionar senha (Comentário original mantido)
              decoration: InputDecoration(
                labelText: "Nova Senha (Opcional)",
                hintText: "Deixe em branco para não alterar",
                prefixIcon: Icon(Icons.lock_outline, color: theme.colorScheme.primary),
                // border: OutlineInputBorder(), // O InputDecorationTheme já cuida disso (Comentário original mantido)
              ),
              obscureText: true, // Oculta o texto da senha.
            ),
            const SizedBox(height: 30),
            // Botão para salvar as alterações.
            ElevatedButton(
              onPressed: _saveProfileChanges, // Chama o método para salvar.
              child: const Text("Salvar Alterações"),
            ),
            const SizedBox(height: 20), // Espaço no final.
          ],
        ),
      ),
    );
  }
}