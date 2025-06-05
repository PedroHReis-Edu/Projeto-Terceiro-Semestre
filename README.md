# Projeto CONECTCAR (Simulador)

Bem-vindo ao CONECTCAR! Este é um projeto Flutter desenvolvido como um **simulador de aplicativo de conectividade e gerenciamento veicular**. Ele demonstra diversas funcionalidades comuns em aplicativos automotivos, como visualização de informações do veículo, monitoramento de "saúde", controles remotos simulados e gerenciamento de perfil de usuário.

O objetivo principal deste projeto é servir como uma peça de portfólio e um exemplo prático de desenvolvimento de UI/UX em Flutter, integração de componentes e navegação.

## Funcionalidades Principais

*   **Autenticação Simulada:** Tela de login para entrada de e-mail, senha e marca do veículo.
*   **Dashboard do Veículo:**
    *   **Informações Detalhadas:** Visualize dados como marca, modelo, ano, placa, chassi (VIN), cor e uma imagem do veículo. Inclui informações simuladas de localização e manutenção.
    *   **Saúde do Veículo:** Monitore métricas simuladas como nível de combustível, autonomia, vida útil do óleo, pressão dos pneus, status da bateria e temperatura do motor, com dados atualizáveis.
    *   **Controles Remotos:** Interaja com controles simulados como trancar/destravar portas, ligar/desligar motor, controlar o ar condicionado, acionar alarme, piscas e faróis.
*   **Central de Ajuda Interativa:**
    *   **Chat Simulado:** Converse com um assistente virtual para obter ajuda.
    *   **FAQ:** Acesse uma lista de Perguntas Frequentes interativas.
*   **Gerenciamento de Perfil e Configurações:**
    *   **Visualização de Perfil:** Veja o nome e e-mail do usuário.
    *   **Edição de Perfil (Simulada):** Modifique nome e e-mail.
    *   **Configurações do Aplicativo (Simuladas):** Ajuste opções como tema (modo escuro), tamanho da fonte e preferências de notificação.
    *   **Documentos Legais:** Acesse telas de Termos de Serviço e Política de Privacidade.
    *   **Logout:** Saia do aplicativo e retorne à tela de login.
*   **Interface Moderna e Responsiva:**
    *   Uso de `ThemeData` customizado para uma aparência consistente.
    *   Widgets reutilizáveis para componentes de UI comuns.
    *   Navegação intuitiva por abas e telas.

## Observações Importantes

*   **Simulação:** Todas as interações com o veículo (dados, controles, API) são **simuladas**. Não há conexão com nenhum hardware ou serviço externo real de veículos.
*   **Persistência de Dados:** As informações de perfil e configurações do aplicativo são simuladas e não são persistidas entre as sessões (exceto o que é mantido em memória durante a execução do app).

## Tecnologias Utilizadas

*   **Flutter:** Framework de UI para desenvolvimento de aplicativos multiplataforma.
*   **Dart:** Linguagem de programação utilizada pelo Flutter.

## Como Executar o Projeto

1.  **Baixe o arquivo APK:**
    *   Você pode encontrar o arquivo de instalação `CONECTCAR.apk` na seção de "Releases" deste repositório no GitHub ou através do link direto que pode ser fornecido pelo desenvolvedor.
2.  **Permita a instalação de fontes desconhecidas (se necessário):**
    *   No seu dispositivo Android, pode ser necessário permitir a instalação de aplicativos de "fontes desconhecidas". Geralmente, essa opção é encontrada em:
        *   `Configurações > Segurança`
        *   Ou `Configurações > Aplicativos > Acesso especial a apps > Instalar apps desconhecidos` (e então permitir para o navegador ou gerenciador de arquivos que você usará).
    *   *Este passo pode variar dependendo da versão do Android e do fabricante do seu dispositivo.*
3.  **Instale o APK:**
    *   Localize o arquivo `CONECTCAR.apk` que você baixou (geralmente na pasta "Downloads").
    *   Toque no arquivo para iniciar o processo de instalação.
    *   Siga as instruções na tela para concluir a instalação.
4.  **Abra o CONECTCAR:**
    *   Após a instalação ser concluída, você encontrará o ícone do CONECTCAR na sua gaveta de aplicativos ou na tela inicial. Toque nele para iniciar!

