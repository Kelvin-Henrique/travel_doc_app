import 'package:dartz/dartz.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';

abstract class IViagemRepository {
Future<Either<Failure, void>> cadastrarViagemAsync(
      CadastroViagemRequest dadosViagem);
}
