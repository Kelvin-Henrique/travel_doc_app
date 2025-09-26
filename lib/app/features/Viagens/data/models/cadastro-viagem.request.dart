class CadastroViagemRequest {
  final int usuarioId;
  final String nomeViagem;
  final String destino;
  final DateTime dataInicio;
  final DateTime dataFim;
  final String descricao;
  
  CadastroViagemRequest({
    required this.usuarioId,
    required this.nomeViagem,
    required this.destino,
    required this.dataInicio,
    required this.dataFim,
    required this.descricao,
  });

  Map<String, dynamic> toJson() {
    return {
      'usuarioId': usuarioId,
      'nomeViagem': nomeViagem,
      'destino': destino,
      'dataInicio': dataInicio.toIso8601String(),
      'dataFim': dataFim.toIso8601String(),
      'descricao': descricao,
    };
  }
}