import 'package:equatable/equatable.dart';

class UsuarioEntity extends Equatable {
  final int? id;
  final String cpf;
  final String nome;
  final String email;
  final String telefone;
  final int? tipo; 

  const UsuarioEntity({
    this.id,
    required this.cpf,
    required this.nome,
    required this.email,
    required this.telefone,
    this.tipo,
  });

  @override
  List<Object> get props => [id ?? 0, cpf, nome, email, telefone, tipo ?? 0];
}
