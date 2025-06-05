// lib/car_api_service.dart
import 'dart:async';
import 'dart:math'; // Para gerar dados aleatórios na simulação
import 'car_model.dart'; // Nosso modelo de dados

/// Simula um serviço de API para buscar informações de veículos.
///
/// Em uma aplicação real, esta classe se comunicaria com um backend.
/// Aqui, ela usa dados locais e lógica de simulação para retornar
/// informações de um carro com base na marca fornecida.
class CarApiService {
  // Simula uma chamada de API que busca informações de um carro pela MARCA.
  // O parâmetro loggedInUserName é usado para personalizar o nome do veículo.
  /// Busca informações simuladas de um veículo com base na [brandName] e no [loggedInUserName].
  ///
  /// Retorna um [Future<CarInfoData>] com os dados do veículo se a marca for
  /// reconhecida. Caso contrário, lança uma [Exception].
  ///
  /// O [loggedInUserName] é utilizado para compor o nome do veículo retornado
  /// (ex: "Modelo de NomeDoUsuario").
  Future<CarInfoData> getCarInfoByBrand(String brandName, String loggedInUserName) async {
    // Simula um atraso de rede para tornar a experiência mais realista.
    await Future.delayed(const Duration(seconds: 2));

    // Lista de marcas conhecidas e modelos para simulação.
    // Cada entrada de modelo contém 'model', 'year', 'color', e opcionalmente 'fuel' e 'doors'.
    final Map<String, List<Map<String, dynamic>>> knownBrands = {
      "VOLKSWAGEN": [
        {"model": "Gol", "year": 2018, "color": "Prata", "fuel": "Flex", "doors": 4},
        {"model": "Polo", "year": 2020, "color": "Branco", "fuel": "Flex", "doors": 4},
        {"model": "Virtus", "year": 2022, "color": "Preto", "fuel": "Flex", "doors": 4},
        {"model": "Nivus", "year": 2023, "color": "Cinza", "fuel": "Flex", "doors": 4},
      ],
      "FIAT": [
        {"model": "Mobi", "year": 2019, "color": "Vermelho", "fuel": "Flex", "doors": 4},
        {"model": "Argo", "year": 2021, "color": "Azul", "fuel": "Flex", "doors": 4},
        {"model": "Toro", "year": 2022, "color": "Branco", "fuel": "Diesel", "doors": 4},
        {"model": "Strada", "year": 2023, "color": "Preto", "fuel": "Flex", "doors": 2},
      ],
      "CHEVROLET": [
        {"model": "Onix", "year": 2020, "color": "Prata", "fuel": "Flex", "doors": 4},
        {"model": "Tracker", "year": 2021, "color": "Cinza", "fuel": "Flex", "doors": 4},
        {"model": "S10", "year": 2022, "color": "Branco", "fuel": "Diesel", "doors": 4},
      ],
      "FORD": [
        {"model": "Ka", "year": 2018, "color": "Branco", "fuel": "Flex", "doors": 4},
        {"model": "Ranger", "year": 2021, "color": "Prata", "fuel": "Diesel", "doors": 4},
        {"model": "Territory", "year": 2022, "color": "Azul", "fuel": "Gasolina", "doors": 4},
      ],
      "HONDA": [
        {"model": "Civic", "year": 2020, "color": "Preto", "fuel": "Flex", "doors": 4},
        {"model": "HR-V", "year": 2022, "color": "Cinza", "fuel": "Flex", "doors": 4},
      ],
      "TOYOTA": [
        {"model": "Corolla", "year": 2021, "color": "Prata", "fuel": "Flex", "doors": 4},
        {"model": "Hilux", "year": 2023, "color": "Branco", "fuel": "Diesel", "doors": 4},
      ],
      "HYUNDAI": [
        {"model": "HB20", "year": 2019, "color": "Branco", "fuel": "Flex", "doors": 4},
        {"model": "Creta", "year": 2022, "color": "Preto", "fuel": "Flex", "doors": 4},
      ],
      "JEEP": [
        {"model": "Renegade", "year": 2020, "color": "Verde", "fuel": "Flex", "doors": 4},
        {"model": "Compass", "year": 2022, "color": "Cinza", "fuel": "Flex", "doors": 4},
      ],
      "RENAULT": [
        {"model": "Kwid", "year": 2021, "color": "Branco", "fuel": "Flex", "doors": 4},
        {"model": "Duster", "year": 2022, "color": "Laranja", "fuel": "Flex", "doors": 4},
        {"model": "Sandero", "year": 2019, "color": "Prata", "fuel": "Flex", "doors": 4},
      ],
      "NISSAN": [
        {"model": "Kicks", "year": 2021, "color": "Azul", "fuel": "Flex", "doors": 4},
        {"model": "Frontier", "year": 2023, "color": "Preto", "fuel": "Diesel", "doors": 4},
      ],
    };

    // Normaliza o nome da marca para correspondência insensível a maiúsculas/minúsculas.
    String normalizedBrandName = brandName.toUpperCase();

    // Verifica se a marca fornecida existe no mapa de marcas conhecidas.
    if (knownBrands.containsKey(normalizedBrandName)) {
      Random random = Random(); // Instância de Random para selecionar um modelo aleatório.
      List<Map<String, dynamic>> models = knownBrands[normalizedBrandName]!;
      // Seleciona um modelo aleatório da lista de modelos da marca.
      Map<String, dynamic> selectedModel = models[random.nextInt(models.length)];

      // Extrai informações do modelo selecionado.
      int year = selectedModel["year"] as int;
      String color = selectedModel["color"] as String;
      // Gera placa e VIN aleatórios para a simulação.
      String plate = _generatePlate();
      String vin = _generateVin();

      // String userName = "Proprietário(a)"; // Linha antiga, mantida como referência do código original.
      // Utiliza o nome de usuário logado para compor o nome do carro.
      String carOwnerName = loggedInUserName;


      // Retorna uma instância de CarInfoData com as informações simuladas.
      // Nota: Os campos 'fuel' e 'doors' de knownBrands não são usados aqui
      // porque o construtor de CarInfoData (conforme o arquivo car_model.dart fornecido)
      // não os inclui.
      return CarInfoData(
        // O nome do carro é uma combinação do modelo e do nome do proprietário.
        name: "${selectedModel["model"]} de $carOwnerName",
        // Formata a marca para exibição (ex: "Fiat" em vez de "FIAT").
        brand: normalizedBrandName[0] + normalizedBrandName.substring(1).toLowerCase(),
        model: selectedModel["model"] as String,
        year: year,
        imageUrl: "assets/images/car_placeholder.png", // Imagem placeholder padrão.
        plate: plate,
        vin: vin,
        color: color,
      );
    } else {
      // Lança uma exceção se a marca não for encontrada.
      throw Exception('Marca "$brandName" não reconhecida.');
    }
  }

  /// Gera uma placa de veículo aleatória no formato Mercosul (LLLNLNN).
  String _generatePlate() {
    final Random random = Random();
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const numbers = '0123456789';

    String plate = "";
    // Gera 3 letras.
    for (int i = 0; i < 3; i++) {
      plate += letters[random.nextInt(letters.length)];
    }
    // Gera 1 número.
    plate += numbers[random.nextInt(numbers.length)];
    // Gera 1 letra.
    plate += letters[random.nextInt(letters.length)];
    // Gera 2 números (00-99).
    plate += random.nextInt(100).toString().padLeft(2, '0');

    return plate;
  }

  /// Gera um Número de Identificação do Veículo (VIN/Chassi) aleatório.
  /// O formato é simplificado para simulação, consistindo em 17 caracteres alfanuméricos.
  String _generateVin() {
    final Random random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    // Gera uma string de 17 caracteres escolhendo aleatoriamente de 'chars'.
    return String.fromCharCodes(Iterable.generate(
        17, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}