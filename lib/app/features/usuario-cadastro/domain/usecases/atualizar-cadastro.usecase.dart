import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/usecases/usecase.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario-cadastro-request.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/domain/repositories/iusuario-cadastro.repository.dart';
@Singleton(order: 0)
class AtualizarCadastroUseCase
    implements UseCase<void, AtualizarCadastroParams> {
  final IUsuarioCadastroRepository repository;

  AtualizarCadastroUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(
      AtualizarCadastroParams params) async {
    return await repository.atualizarUsuarioAsync(params.dadosAtualizacao);
  }
}

class AtualizarCadastroParams {
  final UsuarioCadastroRequest dadosAtualizacao;

  AtualizarCadastroParams({required this.dadosAtualizacao});
}
