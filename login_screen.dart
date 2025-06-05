// lib/login_screen.dart
import 'package:flutter/material.dart';
import 'car_model.dart'; // Modelo de dados para informações do veículo.
import 'info_screen.dart'; // Tela principal após o login bem-sucedido.
import 'car_api_service.dart'; // Serviço para simular a busca de dados do veículo.

/// Tela de login da aplicação.
///
/// Permite que o usuário insira suas credenciais (email e senha) e a marca
/// do veículo para simular o acesso às informações e funcionalidades do app.
class LoginScreen extends StatefulWidget {
  /// Cria uma instância de LoginScreen.
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

/// Estado para o widget [LoginScreen].
///
/// Gerencia o estado do formulário, controladores de texto,
/// estado de carregamento e a lógica de login.
class _LoginScreenState extends State<LoginScreen> {
  // Chave global para identificar o formulário e permitir validação.
  final _formKey = GlobalKey<FormState>();
  // Controlador para o campo de texto do email.
  final _emailController = TextEditingController();
  // Controlador para o campo de texto da senha.
  final _passwordController = TextEditingController();
  // Controlador para o campo de texto da marca do veículo.
  final _brandController = TextEditingController();

  // Controla a exibição do indicador de carregamento durante o login.
  bool _isLoading = false;
  // Controla a visibilidade do texto no campo de senha.
  bool _obscurePassword = true;

  // Instância do serviço de API para buscar informações do carro.
  final CarApiService _carApiService = CarApiService();

  @override
  void dispose() {
    // Libera os recursos dos controladores de texto quando o widget é descartado.
    _emailController.dispose();
    _passwordController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  /// Tenta realizar o login do usuário.
  ///
  /// Valida os campos do formulário, simula uma chamada à API para buscar
  /// informações do veículo e, se bem-sucedido, navega para a [InfoScreen].
  /// Em caso de erro, exibe uma mensagem para o usuário.
  Future<void> _login() async {
    // Valida o formulário. Se for válido, prossegue com o login.
    if (_formKey.currentState!.validate()) {
      // Ativa o indicador de carregamento.
      setState(() {
        _isLoading = true;
      });

      // Obtém os valores dos campos de email e marca.
      final email = _emailController.text;
      final brand = _brandController.text;

      // Deriva o nome do usuário a partir do email.
      String userName = "Usuário"; // Valor padrão para o nome do usuário.
      if (email.isNotEmpty && email.contains('@')) {
        // Se o email contiver '@', usa a parte antes do '@' como nome.
        userName = email.split('@')[0];
        if (userName.isNotEmpty) {
          // Capitaliza a primeira letra do nome.
          userName = userName[0].toUpperCase() + userName.substring(1);
        }
      } else if (email.isNotEmpty) {
        // Se não for um email válido mas não estiver vazio, usa o texto digitado como nome.
        userName = email;
        if (userName.isNotEmpty) {
          // Capitaliza a primeira letra do nome.
          userName = userName[0].toUpperCase() + userName.substring(1);
        } else {
          // Se o nome resultante for vazio, volta ao padrão.
          userName = "Usuário";
        }
      }

      try {
        // Chama o serviço da API para obter informações do carro.
        // Passa a marca do veículo e o nome de usuário derivado.
        final carDataFromApi =
        await _carApiService.getCarInfoByBrand(brand, userName);

        // Verifica se o widget ainda está montado antes de navegar.
        if (mounted) {
          // Navega para a InfoScreen, substituindo a tela de login da pilha.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => InfoScreen(
                carInfo: carDataFromApi,
                userEmail: email,
                userName: userName, // Passa o nome de usuário para a InfoScreen.
              ),
            ),
          );
        }
      } catch (e) {
        // Em caso de erro na chamada da API:
        // Verifica se o widget ainda está montado antes de mostrar o SnackBar.
        if (mounted) {
          // Exibe uma mensagem de erro para o usuário.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Erro: ${e.toString().replaceFirst("Exception: ", "")}'),
              backgroundColor: Colors.red, // Cor de fundo para erro.
            ),
          );
          // Desativa o indicador de carregamento.
          setState(() {
            _isLoading = false;
            // Considerar limpar o campo da marca em caso de erro específico.
            // _brandController.clear();
          });
        }
      }
      // Nota: O estado _isLoading é desativado no bloco catch em caso de erro.
      // Em caso de sucesso, a navegação ocorre e este widget é desmontado,
      // então não é estritamente necessário desativar _isLoading aqui.
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o tema atual para estilização.
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        // Garante que o conteúdo não sobreponha áreas do sistema (notch, etc.).
        child: Center(
          // Centraliza o conteúdo na tela.
          child: SingleChildScrollView(
            // Permite rolagem se o conteúdo exceder a altura da tela.
            padding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Form(
              key: _formKey, // Associa a chave global ao formulário.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo da aplicação.
                  Image.asset(
                    'assets/images/IconLogo.png',
                    height: 100,
                    width: 100,
                  ),
                  // Texto de boas-vindas.
                  Text(
                    "Bem-vindo!",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 8),
                  // Instrução para o usuário.
                  Text(
                    "Faça login e informe a marca do veículo.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 40),
                  // Campo de texto para o email.
                  TextFormField(
                    controller: _emailController,
                    enabled: !_isLoading, // Desabilita se estiver carregando.
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'seuemail@exemplo.com',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu email';
                      }
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Por favor, insira um email válido';
                      }
                      return null; // Retorna null se a validação for bem-sucedida.
                    },
                  ),
                  const SizedBox(height: 16),
                  // Campo de texto para a senha.
                  TextFormField(
                    controller: _passwordController,
                    enabled: !_isLoading, // Desabilita se estiver carregando.
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        tooltip: _obscurePassword
                            ? 'Mostrar senha'
                            : 'Ocultar senha',
                        onPressed: _isLoading
                            ? null // Desabilita o botão se estiver carregando.
                            : () {
                          // Alterna a visibilidade da senha.
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword, // Oculta o texto da senha.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }
                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }
                      return null; // Retorna null se a validação for bem-sucedida.
                    },
                  ),
                  const SizedBox(height: 16),
                  // Campo de texto para a marca do veículo.
                  TextFormField(
                    controller: _brandController,
                    enabled: !_isLoading, // Desabilita se estiver carregando.
                    decoration: const InputDecoration(
                      labelText: 'Marca do Veículo',
                      prefixIcon: Icon(Icons.directions_car_filled_outlined),
                      hintText: 'Ex: Fiat, Ford, VW',
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words, // Capitaliza cada palavra.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a marca do veículo';
                      }
                      return null; // Retorna null se a validação for bem-sucedida.
                    },
                  ),
                  const SizedBox(height: 12),
                  // Botão "Esqueceu sua senha?".
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _isLoading
                          ? null // Desabilita se estiver carregando.
                          : () {
                        // Simula a funcionalidade de "Esqueci minha senha".
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Funcionalidade 'Esqueci minha senha' (simulado)")),
                        );
                      },
                      child: Text(
                        "Esqueceu sua senha?",
                        style: TextStyle(
                            color: _isLoading
                                ? Colors.grey // Cor quando desabilitado.
                                : theme.primaryColor), // Cor padrão.
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Botão de login.
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null // Desabilita se estiver carregando.
                        : _login, // Chama o método _login ao ser pressionado.
                    style: theme.elevatedButtonTheme.style?.copyWith(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 16)),
                    ),
                    child: _isLoading
                    // Mostra um indicador de progresso se estiver carregando.
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    // Mostra o texto do botão se não estiver carregando.
                        : const Text('Entrar e Consultar'),
                  ),
                  const SizedBox(height: 24),
                  // Opção para registrar-se.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Não tem uma conta?",
                          style: TextStyle(color: Colors.grey[600])),
                      TextButton(
                        onPressed: _isLoading
                            ? null // Desabilita se estiver carregando.
                            : () {
                          // Simula a funcionalidade de "Registrar-se".
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Funcionalidade 'Registrar-se' (simulado)")),
                          );
                        },
                        child: Text(
                          "Registre-se",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isLoading
                                ? Colors.grey // Cor quando desabilitado.
                                : theme.primaryColor, // Cor padrão.
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}