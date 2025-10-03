import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario-cadastro-request.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/domain/usecases/atualizar-cadastro.usecase.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/domain/usecases/cadastrar-usuario.usecase.dart';

part 'usuario-cadastro.controller.g.dart';

@Singleton(order: 1)
class UsuarioCadastroController = _UsuarioCadastroControllerBase
    with _$UsuarioCadastroController;

abstract class _UsuarioCadastroControllerBase with Store {
  final _cadastrarUsuarioUsecase = locator<CadastrarUsuarioUsecase>();
  final _atualizarCadastroUseCase = locator<AtualizarCadastroUseCase>();

   @action
  Future<void> cadastrarUsuarioAsync(UsuarioCadastroRequest dadosCadastros) async {
    var result = await _cadastrarUsuarioUsecase(
        CadastrarUsuarioParams(dadosCadastro: dadosCadastros));

    return result.fold((failure) {
      return Future.error(failure.message);
    }, (value) => value);
  }

    @action
  Future<void> atualizarCadastroAsync(UsuarioCadastroRequest dadosCadastros) async {
    var result = await _atualizarCadastroUseCase(
        AtualizarCadastroParams(dadosAtualizacao: dadosCadastros));

    return result.fold((failure) {
      return Future.error(failure.message);
    }, (value) => value);
  }
}
