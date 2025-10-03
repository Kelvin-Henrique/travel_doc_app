import 'package:equatable/equatable.dart';

class ViagensEntity extends Equatable {
  final int? id;
  final String nomeViagem;
  final String destino;
  final DateTime dataInicio;
  final DateTime dataFim;
  final String descricao;
  final int criadorId;
  final int status;

  const ViagensEntity({
    this.id,
    required this.nomeViagem,
    required this.destino,
    required this.dataInicio,
    required this.dataFim,
    required this.descricao,
    required this.criadorId,
    required this.status
  });

  @override
  List<Object> get props => [id ?? 0, nomeViagem, destino, dataInicio, dataFim, criadorId, status];
}
