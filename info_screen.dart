// lib/info_screen.dart
import 'package:flutter/material.dart';
import 'car_model.dart'; // Modelo de dados para informações do veículo.
import 'profile_screen.dart'; // Tela de perfil do usuário.
// Importações das telas/widgets para cada aba.
import 'info_tab.dart'; // Aba de informações detalhadas do veículo.
import 'saude_screen.dart'; // Aba de saúde do veículo.
import 'ajuda_screen.dart'; // Aba de ajuda e suporte.
import 'controle_screen.dart'; // Aba de controles simulados do veículo.

/// Tela principal da aplicação após o login bem-sucedido.
///
/// Utiliza um [DefaultTabController] para gerenciar a navegação por abas,
/// exibindo informações e funcionalidades relacionadas ao veículo.
/// Também fornece acesso à [ProfileScreen].
class InfoScreen extends StatelessWidget {
  /// Informações detalhadas do veículo a serem exibidas e passadas para as abas.
  final CarInfoData carInfo;

  /// Email do usuário logado, para ser passado para a [ProfileScreen].
  final String userEmail;

  /// Nome do usuário logado, para ser passado para a [ProfileScreen].
  final String userName;

  /// Cria uma instância de [InfoScreen].
  ///
  /// Requer [carInfo], [userEmail] e [userName].
  const InfoScreen({
    super.key,
    required this.carInfo,
    required this.userEmail,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    // Envolve o Scaffold com DefaultTabController para gerenciar as abas.
    return DefaultTabController(
      length: 4, // Número total de abas.
      child: Scaffold(
        appBar: AppBar(
          // Título do AppBar exibe o nome do carro.
          title: Text(carInfo.name),
          // Define a TabBar na parte inferior do AppBar.
          bottom: TabBar(
            // Cor do label da aba selecionada, usando a cor secundária do tema.
            labelColor: Theme.of(context).colorScheme.secondary,
            // Cor do label da aba não selecionada.
            unselectedLabelColor: Colors.black54,
            // Cor do indicador da aba selecionada.
            indicatorColor: Theme.of(context).colorScheme.secondary,
            // Define as abas com ícones e texto.
            tabs: const [
              Tab(icon: Icon(Icons.info_outline), text: 'Info'),
              Tab(icon: Icon(Icons.healing), text: 'Saúde'),
              Tab(icon: Icon(Icons.help_outline), text: 'Ajuda'),
              Tab(icon: Icon(Icons.settings_remote), text: 'Controle'),
            ],
          ),
          // Ações no AppBar (ex: ícone de perfil).
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                onTap: () {
                  // Navega para a tela de perfil ao tocar no ícone.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        userEmail: userEmail,
                        userName: userName,
                      ),
                    ),
                  );
                },
                // Borda arredondada para o efeito de toque (InkWell).
                borderRadius: BorderRadius.circular(20),
                // Ícone de perfil dentro de um CircleAvatar.
                child: CircleAvatar(
                  backgroundColor: Colors.blue[100],
                  child: const Icon(Icons.person, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
        // Corpo do Scaffold, contendo as visualizações de cada aba.
        body: TabBarView(
          // Conteúdo de cada aba.
          children: [
            InfoTab(carInfo: carInfo), // Aba de Informações, passa carInfo.
            const SaudeScreen(), // Aba de Saúde.
            const AjudaScreen(), // Aba de Ajuda.
            const ControleScreen(), // Aba de Controle.
          ],
        ),
      ),
    );
  }
}