import 'package:equatable/equatable.dart';

class UsuarioEntity extends Equatable {
  final String cpf;
  final String nome;
  final String email;
  final String telefone;
  final int? tipo; 

  const UsuarioEntity({
    required this.cpf,
    required this.nome,
    required this.email,
    required this.telefone,
    this.tipo,
  });

  @override
  List<Object> get props => [cpf, nome, email, telefone, tipo ?? 0];
}
