import 'package:dartz/dartz.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/entities/viagens.entity.dart';

abstract class IViagemRepository {
Future<Either<Failure, void>> cadastrarViagemAsync(
      CadastroViagemRequest dadosViagem);
      Future<Either<Failure, List<ViagensEntity>>> obterViagensPorUsuarioIdAsync();
      Future<Either<Failure, void>> convidarParticipanteAsync(
      String email, int viagemId);
}
