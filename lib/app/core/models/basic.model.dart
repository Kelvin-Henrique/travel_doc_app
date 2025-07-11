import 'package:equatable/equatable.dart';

class BasicModel extends Equatable {
  final dynamic id;
  final String nome;

  const BasicModel({this.id, required this.nome});

  @override
  bool operator ==(dynamic other) => other != null && other is BasicModel && id == other.id && nome == other.nome;

  @override
  List<Object> get props => [id, nome];

  factory BasicModel.fromJson(Map<String, dynamic> json) {
    return BasicModel(
      id: json["id"],
      nome: json["nome"],
    );
  }
}
