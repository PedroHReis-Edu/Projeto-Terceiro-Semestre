// lib/ajuda_screen.dart
import 'package:flutter/material.dart';
import 'dart:async'; // Para Future.delayed

// Modelo para as mensagens do chat
/// Representa uma única mensagem na interface de chat.
class ChatMessage {
  /// O texto da mensagem.
  final String text;
  /// Indica se a mensagem foi enviada pelo usuário (`true`) ou pelo bot (`false`).
  final bool isUserMessage;
  /// Indica se esta mensagem do bot deve exibir um botão para o FAQ.
  final bool isFaqButton; // Novo campo para identificar o botão do FAQ

  /// Cria uma instância de [ChatMessage].
  ///
  /// [text] e [isUserMessage] são obrigatórios.
  /// [isFaqButton] é opcional e tem como padrão `false`.
  ChatMessage({
    required this.text,
    required this.isUserMessage,
    this.isFaqButton = false, // Padrão é falso
  });
}

/// Uma tela (ou aba) que fornece uma interface de chat de ajuda simulada
/// e acesso a Perguntas Frequentes (FAQ).
class AjudaScreen extends StatefulWidget {
  /// Cria uma instância de [AjudaScreen].
  const AjudaScreen({super.key});

  @override
  State<AjudaScreen> createState() => _AjudaScreenState();
}

/// O estado para o widget [AjudaScreen].
///
/// Gerencia a lista de mensagens do chat, controladores de texto e rolagem,
/// o estado de digitação do bot e a lógica para interagir com o FAQ.
class _AjudaScreenState extends State<AjudaScreen> {
  /// Lista de mensagens exibidas no chat.
  final List<ChatMessage> _messages = [];
  /// Controlador para o campo de entrada de texto do usuário.
  final TextEditingController _textController = TextEditingController();
  /// Controlador para a rolagem da lista de mensagens.
  final ScrollController _scrollController = ScrollController();
  /// Indica se o bot está atualmente "digitando" uma resposta.
  bool _isBotTyping = false;

  // Lista de Perguntas e Respostas Frequentes (mantida)
  /// Lista de perguntas e respostas frequentes (FAQ) pré-definidas.
  /// Cada item é um mapa contendo "pergunta" e "resposta".
  final List<Map<String, String>> faqs = const [
    {
      "pergunta": "Como altero minhas informações de perfil?",
      "resposta":
      "Para alterar suas informações de perfil, vá até a tela de 'Perfil' clicando no ícone de avatar no canto superior direito da tela principal. Lá você encontrará as opções para editar seus dados."
    },
    {
      "pergunta": "Onde vejo os detalhes do meu veículo?",
      "resposta":
      "Os detalhes completos do seu veículo, como marca, modelo, ano, placa, cor, etc., estão disponíveis na aba 'Info' da tela principal."
    },
    {
      "pergunta": "Como funciona a aba 'Saúde' do veículo?",
      "resposta":
      "A aba 'Saúde' apresenta um resumo de diversos indicadores importantes do seu veículo, como nível de combustível, autonomia, vida útil do óleo, pressão dos pneus e estado da bateria. Toque em cada card para ver mais detalhes."
    },
    {
      "pergunta": "Posso controlar funções do meu carro pelo app?",
      "resposta":
      "Sim, a aba 'Controle' permite simular algumas interações com o veículo, como travar/destravar portas e outros controles rápidos. Lembre-se que esta é uma funcionalidade simulada para fins de demonstração."
    },
    {
      "pergunta": "O que fazer se eu esquecer minha senha?",
      "resposta":
      "Na tela de login, clique em 'Esqueceu sua senha?'. Uma funcionalidade simulada será apresentada. Em um aplicativo real, você seguiria as instruções para redefinir sua senha."
    },
    {
      "pergunta": "Como entro em contato com o suporte?",
      "resposta":
      "Atualmente, esta é uma versão de demonstração. Para um aplicativo real, haveria uma seção de 'Contato' ou um chat de suporte disponível nesta tela de Ajuda ou na tela de Perfil."
    },
  ];

  @override
  void initState() {
    super.initState();
    // Adiciona uma mensagem inicial do bot quando a tela é carregada.
    _addBotMessage("Olá! Sou seu assistente virtual. Como posso ajudar hoje?",
        showFaqButton: true);
  }

  /// Realiza a rolagem da lista de mensagens para o final.
  ///
  /// Garante que a mensagem mais recente seja visível.
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  /// Adiciona uma nova mensagem à lista [_messages] e atualiza a UI.
  ///
  /// [text]: O conteúdo da mensagem.
  /// [isUserMessage]: `true` se a mensagem for do usuário, `false` se for do bot.
  /// [isFaqBtn]: `true` se a mensagem do bot deve incluir um botão de FAQ.
  void _addMessage(String text, bool isUserMessage, {bool isFaqBtn = false}) {
    setState(() {
      _messages.add(ChatMessage(
          text: text, isUserMessage: isUserMessage, isFaqButton: isFaqBtn));
      // Se o bot estava digitando e esta é uma mensagem do bot, para a indicação de digitação.
      if (_isBotTyping && !isUserMessage) {
        _isBotTyping = false;
      }
    });
    // Rola para o final da lista após a adição da mensagem.
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  /// Adiciona uma mensagem do bot à lista [_messages] após um atraso simulado.
  ///
  /// [text]: O conteúdo da mensagem do bot.
  /// [delaySeconds]: O atraso em segundos antes de exibir a mensagem.
  /// [showFaqButton]: `true` se a mensagem deve incluir um botão de FAQ.
  void _addBotMessage(String text,
      {int delaySeconds = 1, bool showFaqButton = false}) {
    // Ativa o indicador de que o bot está digitando.
    setState(() {
      _isBotTyping = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    // Simula um atraso antes de adicionar a mensagem do bot.
    Future.delayed(Duration(seconds: delaySeconds), () {
      if (mounted) { // Verifica se o widget ainda está montado.
        _addMessage(text, false, isFaqBtn: showFaqButton);
      }
    });
  }

  /// Processa a consulta enviada pelo usuário.
  ///
  /// Adiciona a mensagem do usuário ao chat, limpa o campo de texto
  /// e simula uma resposta do bot.
  void _handleUserQuery(String query) {
    if (query.trim().isEmpty) return; // Ignora consultas vazias.
    _addMessage(query, true); // Adiciona a mensagem do usuário.
    _textController.clear(); // Limpa o campo de entrada.

    // Simulação de resposta do bot.
    _addBotMessage("Entendido. Buscando informações sobre '$query'...");
    // Em um app real, aqui você processaria a query (ex: buscar em FAQs, chamar API de IA).
  }

  /// Exibe um diálogo contendo a lista de Perguntas Frequentes (FAQ).
  ///
  /// Cada item do FAQ é clicável e, ao ser selecionado, sua pergunta e resposta
  /// são adicionadas ao chat.
  void _showFaqDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Perguntas Frequentes"),
          contentPadding: const EdgeInsets.only(top: 20.0, bottom: 0, left: 0, right: 0),
          content: SizedBox(
            width: double.maxFinite, // Faz o conteúdo ocupar a largura máxima.
            child: ListView.separated(
              shrinkWrap: true, // Ajusta o tamanho da lista ao conteúdo.
              itemCount: faqs.length,
              itemBuilder: (context, index) {
                final faqItem = faqs[index];
                return ListTile(
                  title: Text(faqItem["pergunta"]!, style: const TextStyle(fontSize: 15)),
                  onTap: () {
                    Navigator.of(context).pop(); // Fecha o diálogo.
                    _handleFaqSelection(faqItem); // Processa a seleção do FAQ.
                  },
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1), // Divisor entre os itens.
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo.
              },
            ),
          ],
        );
      },
    );
  }

  /// Processa a seleção de um item do FAQ.
  ///
  /// Adiciona a pergunta selecionada como uma mensagem do usuário
  /// e a respectiva resposta como uma mensagem do bot no chat.
  void _handleFaqSelection(Map<String, String> faqItem) {
    // Adiciona a pergunta do usuário ao chat.
    _addMessage(faqItem["pergunta"]!, true);
    // Adiciona a resposta do bot.
    _addBotMessage(faqItem["resposta"]!, delaySeconds: 1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Obtém o tema atual para estilização.
    return Scaffold(
      // appBar: AppBar(title: const Text("Central de Ajuda")), // Comentário original: O AppBar já está na InfoScreen
      body: Column(
        children: [
          // Área de exibição das mensagens do chat.
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Controlador para rolagem.
              padding: const EdgeInsets.all(16.0),
              // Adiciona 1 ao itemCount se o bot estiver digitando para mostrar o indicador.
              itemCount: _messages.length + (_isBotTyping ? 1 : 0),
              itemBuilder: (context, index) {
                // Se o bot estiver digitando e este for o último item, mostra o indicador.
                if (_isBotTyping && index == _messages.length) {
                  return _buildBotTypingIndicator(theme);
                }
                final message = _messages[index]; // Obtém a mensagem atual.
                return _buildMessageBubble(message, theme); // Constrói o balão da mensagem.
              },
            ),
          ),
          // Área de entrada de texto do usuário.
          _buildInputArea(theme),
        ],
      ),
    );
  }

  /// Constrói o widget indicador de que o bot está "digitando".
  Widget _buildBotTypingIndicator(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft, // Alinha à esquerda para mensagens do bot.
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[200], // Cor de fundo do balão.
          borderRadius: const BorderRadius.only( // Bordas arredondadas.
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Ocupa o mínimo de espaço horizontal.
          children: const [ // Utiliza const aqui pois os filhos são constantes.
            TypingDot(delay: Duration.zero),
            SizedBox(width: 6),
            TypingDot(delay: Duration(milliseconds: 200)),
            SizedBox(width: 6),
            TypingDot(delay: Duration(milliseconds: 400)),
          ],
        ),
      ),
    );
  }

  /// Constrói o widget de balão para uma mensagem individual do chat.
  ///
  /// [message]: O objeto [ChatMessage] a ser exibido.
  /// [theme]: O tema atual para estilização.
  Widget _buildMessageBubble(ChatMessage message, ThemeData theme) {
    final bool isUser = message.isUserMessage;
    // Define o alinhamento do balão (direita para usuário, esquerda para bot).
    final alignment =
    isUser ? Alignment.centerRight : Alignment.centerLeft;
    // Define a cor de fundo do balão.
    final bubbleColor =
    isUser ? theme.primaryColor.withOpacity(0.15) : Colors.grey[200];
    // Define a cor do texto.
    final textColor = isUser
        ? theme.primaryColorDark
        : theme.textTheme.bodyLarge?.color;
    // Define o arredondamento das bordas do balão.
    final borderRadius = isUser
        ? const BorderRadius.only(
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(15),
      topRight: Radius.circular(15),
    )
        : const BorderRadius.only(
      topRight: Radius.circular(15),
      bottomRight: Radius.circular(15),
      topLeft: Radius.circular(15),
    );

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75), // Largura máxima do balão.
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: borderRadius,
          // Adiciona uma borda sutil para mensagens do usuário.
          border: isUser ? Border.all(color: theme.primaryColor.withOpacity(0.5)) : null,
        ),
        child: Column(
          crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.text,
              style: TextStyle(color: textColor, fontSize: 15, height: 1.3), // Altura da linha para melhor legibilidade.
            ),
            // Se for uma mensagem do bot e tiver o botão de FAQ, exibe o botão.
            if (message.isFaqButton && !isUser) ...[
              const SizedBox(height: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.quiz_outlined, size: 18),
                label: const Text("Ver Perguntas Frequentes"),
                onPressed: _showFaqDialog, // Mostra o diálogo de FAQ ao pressionar.
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  /// Constrói a área de entrada de texto na parte inferior da tela.
  Widget _buildInputArea(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor, // Cor de fundo da área de entrada.
        boxShadow: [ // Sombra para destacar a área de entrada.
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 3.0,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Digite sua pergunta...", // Texto de placeholder.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0), // Bordas arredondadas.
                  borderSide: BorderSide.none, // Sem borda visível.
                ),
                filled: true, // Preenchido com cor.
                fillColor: Colors.grey[100], // Cor de preenchimento.
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              ),
              onSubmitted: _handleUserQuery, // Envia a consulta ao submeter.
            ),
          ),
          const SizedBox(width: 8.0),
          // Botão de enviar.
          IconButton(
            icon: Icon(Icons.send, color: theme.primaryColor),
            onPressed: () => _handleUserQuery(_textController.text), // Envia a consulta ao pressionar.
          ),
        ],
      ),
    );
  }
}

// Widget para o ponto de "digitando..." (pode estar em reusable_widgets.dart)
// Se já estiver lá e for público, não precisa redefinir aqui.
// Certifique-se que o TypingDot em reusable_widgets.dart está assim:
/* // Comentário original
class TypingDot extends StatefulWidget { // Renomeado para ser público
  final Duration delay;
  const TypingDot({super.key, this.delay = Duration.zero}); // Adicionado super.key

  @override
  State<TypingDot> createState() => _TypingDotState();
}
// ... (resto da implementação do TypingDot)
*/ // Comentário original
// Para este exemplo, vou assumir que você tem o TypingDot em reusable_widgets.dart
// e que ele está importado corretamente.
// Se não, descomente e ajuste o widget TypingDot que está no final do arquivo reusable_widgets.dart
// que você me forneceu anteriormente.
// Para este exemplo, vou adicionar uma cópia simplificada aqui para garantir que funcione.

/// Um widget que exibe um ponto animado, usado para o indicador de "digitando".
class TypingDot extends StatefulWidget {
  /// O atraso antes da animação do ponto começar.
  final Duration delay;
  /// Cria uma instância de [TypingDot].
  const TypingDot({super.key, this.delay = Duration.zero});

  @override
  State<TypingDot> createState() => _TypingDotState();
}

/// O estado para o widget [TypingDot].
///
/// Gerencia a animação de fade e escala do ponto.
class _TypingDotState extends State<TypingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, // Necessário para a animação.
      duration: const Duration(milliseconds: 600), // Duração da animação.
    )..addStatusListener((status) {
      // Faz a animação repetir (loop).
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    // Inicia a animação após o atraso especificado.
    Future.delayed(widget.delay, () {
      if (mounted) { // Verifica se o widget ainda está montado.
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera o controlador da animação.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Combina animações de Fade (opacidade) e Scale (tamanho).
    return FadeTransition(
      opacity: Tween<double>(begin: 0.3, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.7, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: Colors.grey[500], // Cor do ponto.
            shape: BoxShape.circle, // Formato circular.
          ),
        ),
      ),
    );
  }
}