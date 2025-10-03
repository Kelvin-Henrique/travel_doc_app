import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/repositories/base.repository.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/datasources/iusuario-cadastro.datasource.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario-cadastro-request.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/domain/repositories/iusuario-cadastro.repository.dart';

@Injectable(as: IUsuarioCadastroRepository, order: -1)
class UsuarioCadastroRepository extends BaseRepository
    implements IUsuarioCadastroRepository {
  final IUsuarioCadastroDatasource datasource;

  UsuarioCadastroRepository(
  {required this.datasource, required super.networkInfo});

  
  @override
  Future<Either<Failure, void>> cadastrarUsuarioAsync(
      UsuarioCadastroRequest dadosCadastro) async {
    return executeSafely(() async {
      var result = await datasource.cadastrarUsuarioAsync(dadosCadastro);
      return result;
    });
  }

  @override
  Future<Either<Failure, void>> atualizarUsuarioAsync(UsuarioCadastroRequest dadosAtualizacao) async {
    return executeSafely(() async {
      var result = await datasource.atualizarUsuarioAsync(dadosAtualizacao);
      return result;
    });
  }
  
}
