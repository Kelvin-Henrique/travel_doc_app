import 'package:travel_doc_app/app/features/usuario-cadastro/domain/entities/usuario.entity.dart';

class UsuarioModel extends UsuarioEntity {
  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final int? tipo;

  UsuarioModel({
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
     this.tipo,
  
  }) : super(
          nome: nome,
          cpf: cpf,
          email: email,
          telefone: telefone,
          tipo: tipo,
        );

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return new UsuarioModel(
      nome: json["nome"],
      cpf: json["cpf"],
      email: json["email"],
      telefone: json["telefone"],
      tipo: json["tipo"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "cpf": cpf,
      "email": email,
      "telefone": telefone,
      "tipo": tipo,
    };
  }
}
