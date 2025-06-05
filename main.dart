// lib/main.dart
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa a tela de login inicial

// Ponto de entrada principal da aplicação Flutter.
void main() {
    runApp(const MyApp());
}

/// Widget raiz da aplicação.
///
/// Configura o tema geral e define a tela inicial como [LoginScreen].
class MyApp extends StatelessWidget {
    /// Cria uma instância de MyApp.
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        // Definição de cores base para o ColorScheme.
        // Estas cores são usadas para gerar uma paleta de cores harmoniosa
        // para a aplicação através do `ColorScheme.fromSeed`.
        const Color primaryColor = Color(0xFF3F51B5); // Azul Índigo (Exemplo)
        const Color secondaryColor = Color(0xFF009688); // Verde Azulado/Teal (Exemplo)
        const Color errorColor = Color(0xFFD32F2F); // Vermelho para erros (Exemplo)
        const Color lightBackgroundColor = Color(0xFFF5F5F5); // Um cinza bem claro para o fundo
        const Color darkTextColor = Color(0xFF212121); // Texto escuro para boa legibilidade
        const Color lightTextColor = Colors.white; // Texto claro para contraste em fundos escuros
        const Color surfaceColor = Colors.white; // Cor para superfícies como Cards, Dialogs
        const Color outlineColor = Color(0xFFBDBDBD); // Cinza para bordas e divisores

        return MaterialApp(
            title: 'Car Management App', // Título da aplicação, usado pelo sistema operacional
            debugShowCheckedModeBanner: false, // Remove o banner "DEBUG" no canto superior direito
            theme: ThemeData(
                // ColorScheme é a base para a maioria das cores dos componentes Material.
                // fromSeed gera uma paleta completa a partir de uma cor semente (seedColor).
                colorScheme: ColorScheme.fromSeed(
                    seedColor: primaryColor, // Cor principal usada para gerar a paleta
                    primary: primaryColor, // Cor primária principal
                    onPrimary: lightTextColor, // Cor do texto/ícones sobre a cor primária
                    primaryContainer: Color.lerp(primaryColor, Colors.white, 0.85), // Tom mais claro da primária para containers
                    onPrimaryContainer: darkTextColor, // Cor do texto/ícones sobre o primaryContainer
                    secondary: secondaryColor, // Cor secundária
                    onSecondary: lightTextColor, // Cor do texto/ícones sobre a cor secundária
                    secondaryContainer: Color.lerp(secondaryColor, Colors.white, 0.85), // Tom mais claro da secundária para containers
                    onSecondaryContainer: darkTextColor, // Cor do texto/ícones sobre o secondaryContainer
                    error: errorColor, // Cor para indicar erros
                    onError: lightTextColor, // Cor do texto/ícones sobre a cor de erro
                    errorContainer: Color.lerp(errorColor, Colors.white, 0.85), // Tom mais claro da cor de erro para containers
                    onErrorContainer: darkTextColor, // Cor do texto/ícones sobre o errorContainer
                    background: lightBackgroundColor, // Cor de fundo geral da aplicação
                    onBackground: darkTextColor, // Cor do texto/ícones sobre a cor de fundo
                    surface: surfaceColor, // Cor de superfícies de componentes (Cards, Dialogs)
                    onSurface: darkTextColor, // Cor do texto/ícones sobre a cor de superfície
                    outline: outlineColor, // Cor para bordas e divisores
                ),

                // Cor de fundo padrão para os Scaffolds.
                scaffoldBackgroundColor: lightBackgroundColor,

                // Tema customizado para AppBar.
                appBarTheme: const AppBarTheme(
                    backgroundColor: primaryColor,
                    foregroundColor: lightTextColor,
                    elevation: 1.0, // Sutil elevação para o AppBar
                    titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500, // Peso de fonte comum para títulos de AppBar
                        color: lightTextColor,
                    ),
                    iconTheme: IconThemeData(
                        color: lightTextColor, // Cor dos ícones no AppBar
                    ),
                ),

                // Tema customizado para InputDecoration (usado em TextFormField, TextField).
                inputDecorationTheme: InputDecorationTheme(
                    filled: true, // Indica que o campo de texto deve ser preenchido com fillColor
                    fillColor: surfaceColor, // Cor de preenchimento dos campos de texto
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    border: OutlineInputBorder( // Borda padrão (geralmente não visível se enabledBorder/focusedBorder são definidos)
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none, // Sem borda visível por padrão, confiando nas bordas de estado
                    ),
                    enabledBorder: OutlineInputBorder( // Borda quando o campo está habilitado mas não focado
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: outlineColor.withOpacity(0.5)), // Borda cinza sutil
                    ),
                    focusedBorder: OutlineInputBorder( // Borda quando o campo está focado
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: primaryColor, width: 1.5), // Borda com a cor primária
                    ),
                    labelStyle: TextStyle(color: darkTextColor.withOpacity(0.7)), // Estilo para o labelText
                    hintStyle: TextStyle(color: outlineColor), // Estilo para o hintText
                ),

                // Tema customizado para ElevatedButton.
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: lightTextColor,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
                        ),
                        elevation: 2, // Elevação padrão para botões elevados
                    ),
                ),

                // Tema customizado para TextButton.
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: primaryColor, // Cor do texto do TextButton
                        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                        ),
                    ),
                ),

                // Tema customizado para Card.
                cardTheme: CardTheme(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // Margem padrão
                    color: surfaceColor, // Cor de fundo dos cards
                    clipBehavior: Clip.antiAlias, // Garante que o conteúdo respeite as bordas arredondadas
                ),

                // Tema customizado para ListTile.
                listTileTheme: ListTileThemeData(
                    iconColor: primaryColor, // Cor padrão para ícones leading/trailing
                    titleTextStyle: TextStyle(fontSize: 16, color: darkTextColor, fontWeight: FontWeight.w500),
                    subtitleTextStyle: TextStyle(fontSize: 14, color: darkTextColor.withOpacity(0.7)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                    ),
                ),

                // Tema customizado para Divider.
                dividerTheme: DividerThemeData(
                    color: outlineColor.withOpacity(0.5), // Cor do divisor
                    thickness: 0.8, // Espessura do divisor
                    space: 24, // Espaço total vertical que o divisor ocupa
                    indent: 16, // Recuo inicial do divisor
                    endIndent: 16, // Recuo final do divisor
                ),

                // Definições de estilos de texto padrão para a aplicação.
                // Ajuda a manter a consistência tipográfica.
                textTheme: TextTheme(
                    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkTextColor),
                    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: darkTextColor),
                    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: darkTextColor),
                    bodyLarge: TextStyle(fontSize: 16, color: darkTextColor),
                    bodyMedium: TextStyle(fontSize: 14, color: darkTextColor.withOpacity(0.8)),
                    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: lightTextColor), // Usado por ElevatedButton
                ),
            ),
            home: const LoginScreen(), // Define LoginScreen como a tela inicial da aplicação
        );
    }
}