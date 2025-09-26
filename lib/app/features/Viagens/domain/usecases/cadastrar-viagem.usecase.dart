import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/usecases/usecase.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/repositories/iviagem.repository.dart';
@Singleton(order: 0)
class CadastrarViagemUsecase
    implements UseCase<void, CadastraViagemParams> {
  final IViagemRepository repository;

  CadastrarViagemUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(
      CadastraViagemParams params) async {
    return await repository.cadastrarViagemAsync(params.dadosCadastro);
  }
}

class CadastraViagemParams {
  final CadastroViagemRequest dadosCadastro;

  CadastraViagemParams({required this.dadosCadastro});
}
