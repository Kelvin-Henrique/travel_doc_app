import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/features/login/domain/usecases/login.usecase.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';

part 'login.controller.g.dart';

@Singleton(order: 1)
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final _loginUsecase = locator<LoginUsecase>();

   @action
  Future<UsuarioModel> loginUsuarioAsync(String email) async {
    var result = await _loginUsecase(
        LoginParams(email: email));

    return result.fold((failure) {
      return Future.error(failure.message);
    }, (value) => value as UsuarioModel);
  }
}
