import 'package:travel_doc_app/app/features/Viagens/domain/entities/viagens.entity.dart';

class ViagensModel extends ViagensEntity {
  final int id;
  final String nomeViagem;
  final String destino;
  final DateTime dataInicio;
  final DateTime dataFim;
  final String descricao;
  final int criadorId;
  final int status;

  ViagensModel({
    required this.id,
    required this.nomeViagem,
    required this.destino,
    required this.dataInicio,
    required this.dataFim,
    required this.descricao,
    required this.criadorId,
    required this.status
  }) : super(
          id: id,
          nomeViagem: nomeViagem,
          destino: destino,
          dataInicio: dataInicio,
          dataFim: dataFim,
          descricao: descricao,
          criadorId: criadorId,
          status: status
        );


  factory ViagensModel.fromJson(Map<String, dynamic> json) {
    return ViagensModel(
      id: json["id"] ?? 0,
      nomeViagem: json["nomeViagem"] ?? '',
      destino: json["destino"] ?? '',
      dataInicio: DateTime.parse(json["dataInicio"]),
      dataFim: DateTime.parse(json["dataFim"]),
      descricao: json["descricao"] ?? '',
      criadorId: json["criadorId"] ?? '',
      status: json["status"] ?? 0 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nomeViagem": nomeViagem,
      "destino": destino,
      "dataInicio": dataInicio.toIso8601String(),
      "dataFim": dataFim.toIso8601String(),
      "descricao": descricao,
      "criadorId": criadorId,
      "status": status
    };
  }
}
