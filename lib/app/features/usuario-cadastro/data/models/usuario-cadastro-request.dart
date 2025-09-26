class UsuarioCadastroRequest {
  final String cpf;
  final String nome;
  final String email;
  final String telefone;
  final int tipo;
  UsuarioCadastroRequest({
    required this.cpf,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.tipo,
  });

  Map<String, dynamic> toJson() {
    return {
      'cpf': cpf,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'tipo': tipo,
    };
  }
}