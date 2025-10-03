import 'dart:ffi';

class UsuarioCadastroRequest {
  final int? id;
  final String cpf;
  final String nome;
  final String email;
  final String telefone;
  final int tipo;
  UsuarioCadastroRequest({
    this.id,
    required this.cpf,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.tipo,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'cpf': cpf,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'tipo': tipo,
    };
  }
}