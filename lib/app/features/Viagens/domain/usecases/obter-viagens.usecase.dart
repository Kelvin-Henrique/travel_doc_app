import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/usecases/usecase.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/entities/viagens.entity.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/repositories/iviagem.repository.dart';
@Singleton(order: 0)
class ObterViagensUseCase
    implements UseCase<List<ViagensEntity>, NoParams> {
  final IViagemRepository repository;

  ObterViagensUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ViagensEntity>>> call(
      NoParams params) async {
    return await repository.obterViagensPorUsuarioIdAsync();
  }
}


