import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/usecases/usecase.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario-cadastro-request.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/domain/repositories/iusuario-cadastro.repository.dart';
@Singleton(order: 0)
class CadastrarUsuarioUsecase
    implements UseCase<void, CadastrarUsuarioParams> {
  final IUsuarioCadastroRepository repository;

  CadastrarUsuarioUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(
      CadastrarUsuarioParams params) async {
    return await repository.cadastrarUsuarioAsync(params.dadosCadastro);
  }
}

class CadastrarUsuarioParams {
  final UsuarioCadastroRequest dadosCadastro;

  CadastrarUsuarioParams({required this.dadosCadastro});
}
