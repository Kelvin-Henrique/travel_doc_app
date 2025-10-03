class PaisModel {
  final String nome;
  final String capital;
  final String bandeiraUrl;

  PaisModel({
    required this.nome,
    required this.capital,
    required this.bandeiraUrl,
  });

  factory PaisModel.fromJson(Map<String, dynamic> json) {
    final nome = json['name']?['common'] ?? 'Sem nome';
    
    String capital = '';
    if (json['capital'] != null && (json['capital'] as List).isNotEmpty) {
      capital = json['capital'][0];
    } else {
      capital = 'Sem capital';
    }

    final bandeiraUrl = json['flags']?['png'] ?? '';

    return PaisModel(
      nome: nome,
      capital: capital,
      bandeiraUrl: bandeiraUrl,
    );
  }
}
