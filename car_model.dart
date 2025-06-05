/// Representa a estrutura de dados para as informações de um veículo.
///
/// Contém detalhes como nome (geralmente uma combinação de modelo e proprietário),
/// marca, modelo, ano, caminho da imagem, placa, número do chassi (VIN) e cor.
class CarInfoData {
  /// O nome de exibição do veículo, frequentemente combinando o modelo e o nome do proprietário.
  /// Exemplo: "Argo de Pedro".
  final String name;

  /// A marca do veículo.
  /// Exemplo: "FIAT", "VOLKSWAGEN".
  final String brand;

  /// O modelo específico do veículo.
  /// Exemplo: "Argo", "Polo".
  final String model;

  /// O ano de fabricação do veículo.
  final int year;

  /// O caminho para a imagem do veículo.
  /// Pode ser um caminho de asset local (ex: "assets/images/car_placeholder.png")
  /// ou, em uma implementação futura, uma URL de uma imagem remota.
  final String imageUrl;

  /// A placa de identificação do veículo.
  /// Exemplo: "BRA2E19".
  final String plate;

  /// O Número de Identificação do Veículo, também conhecido como Chassi.
  /// Exemplo: "9BWZZZ377VT012345".
  final String vin;

  /// A cor do veículo.
  /// Exemplo: "Vermelho Monte Carlo", "Branco Banchisa".
  final String color;
  // Adicione outros campos que desejar (Este comentário estava no original)

  /// Cria uma instância de [CarInfoData].
  ///
  /// Todos os campos são obrigatórios.
  CarInfoData({
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.imageUrl,
    required this.plate,
    required this.vin,
    required this.color,
  });
}