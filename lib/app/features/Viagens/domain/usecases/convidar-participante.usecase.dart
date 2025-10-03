import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/usecases/usecase.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/repositories/iviagem.repository.dart';
@Singleton(order: 0)
class ConvidarParticipanteUsecase
    implements UseCase<void, ConvidarParticipanteParams> {
  final IViagemRepository repository;

  ConvidarParticipanteUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(
      ConvidarParticipanteParams params) async {
    return await repository.convidarParticipanteAsync(
        params.email, params.viagemId);
  }
}

class ConvidarParticipanteParams {
  final String email;
  final int viagemId;

  ConvidarParticipanteParams({required this.email, required this.viagemId});
}
