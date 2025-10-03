import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/core/usecases/usecase.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/entities/viagens.entity.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/usecases/cadastrar-viagem.usecase.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/usecases/convidar-participante.usecase.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/usecases/obter-viagens.usecase.dart';

part 'viagem.controller.g.dart';

@Singleton(order: 1)
class ViagemController = _ViagemControllerBase with _$ViagemController;

abstract class _ViagemControllerBase with Store {
  final _cadastrarViagemUsecase = locator<CadastrarViagemUsecase>();
  final _obterViagensUsecase = locator<ObterViagensUseCase>();
  final _convidarParticipanteUsecase = locator<ConvidarParticipanteUsecase>();

   @action
  Future<void> cadastrarViagemAsync(CadastroViagemRequest dadosCadastros) async {
    var result = await _cadastrarViagemUsecase(
        CadastrarViagemParams(dadosCadastro: dadosCadastros));

    return result.fold((failure) {
      return Future.error(failure.message);
    }, (value) => value);
  }

  @action
  Future<List<ViagensEntity>> obterViagensPorUsuarioIdAsync() async {
    var result = await _obterViagensUsecase(NoParams());
    return result.fold(
      (failure) => Future.error(failure.message),
      (viagens) => viagens,
    );
  }

  @action
  Future<void> convidarParticipanteAsync(String email, int viagemId) async {
    var result = await _convidarParticipanteUsecase(
        ConvidarParticipanteParams(email: email, viagemId: viagemId));
    return result.fold((failure) {
      return Future.error(failure.message);
    }, (value) => value);
  }
}
