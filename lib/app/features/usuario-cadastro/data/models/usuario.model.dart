import 'package:travel_doc_app/app/features/usuario-cadastro/domain/entities/usuario.entity.dart';

class UsuarioModel extends UsuarioEntity {
  final int? id;
  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final int? tipo;

  UsuarioModel({
    this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
     this.tipo,
  
  }) : super(
          id: id,
          nome: nome,
          cpf: cpf,
          email: email,
          telefone: telefone,
          tipo: tipo,
        );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return new UsuarioModel(
      id: json["id"],
      nome: json["nome"],
      cpf: json["cpf"],
      email: json["email"],
      telefone: json["telefone"],
      tipo: json["tipo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nome": nome,
      "cpf": cpf,
      "email": email,
      "telefone": telefone,
      "tipo": tipo,
    };
  }
}
