import 'package:dartz/dartz.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario-cadastro-request.dart';

abstract class IUsuarioCadastroRepository {
Future<Either<Failure, void>> cadastrarUsuarioAsync(
      UsuarioCadastroRequest dadosCadastro);
      Future<Either<Failure, void>> atualizarUsuarioAsync(UsuarioCadastroRequest dadosAtualizacao);
}
