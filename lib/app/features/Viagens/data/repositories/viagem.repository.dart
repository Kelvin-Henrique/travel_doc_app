import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/repositories/base.repository.dart';
import 'package:travel_doc_app/app/features/Viagens/data/datasources/iviagem.datasource.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/entities/viagens.entity.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/repositories/iviagem.repository.dart';

@Injectable(as: IViagemRepository, order: -1)
class ViagemRepository extends BaseRepository
    implements IViagemRepository {
  final IViagemDatasource datasource;

  ViagemRepository(
  {required this.datasource, required super.networkInfo});

  
  @override
  Future<Either<Failure, void>> cadastrarViagemAsync(
      CadastroViagemRequest dadosViagem) async {
    return executeSafely(() async {
      var result = await datasource.cadastrarViagemAsync(dadosViagem);
      return result;
    });
  }

  @override
  Future<Either<Failure, List<ViagensEntity>>> obterViagensPorUsuarioIdAsync() async {
    return executeSafely(() async {
      var result = await datasource.obterViagemPorUsuarioIdAsync();
      return result;
    });
  }
  
}
