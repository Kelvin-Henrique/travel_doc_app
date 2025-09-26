import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/usecases/usecase.dart';
import 'package:travel_doc_app/app/features/login/domain/repositories/ilogin.repository.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/domain/entities/usuario.entity.dart';
@Singleton(order: 0)
class LoginUsecase
    implements UseCase<UsuarioEntity, LoginParams> {
  final ILoginRepository repository;

  LoginUsecase({required this.repository});

  @override
  Future<Either<Failure, UsuarioEntity>> call(
      LoginParams params) async {
    return await repository.loginUsuarioAsync(params.email);
  }
}

class LoginParams {
  final String email;

  LoginParams({required this.email});
}
