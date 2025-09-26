import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/core/repositories/base.repository.dart';
import 'package:travel_doc_app/app/features/login/data/datasources/ilogin.datasource.dart';
import 'package:travel_doc_app/app/features/login/domain/repositories/ilogin.repository.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';

@Injectable(as: ILoginRepository, order: -1)
class LoginRepository extends BaseRepository
    implements ILoginRepository {
  final ILoginDatasource datasource;

  LoginRepository(
  {required this.datasource, required super.networkInfo});

  
  @override
  Future<Either<Failure, UsuarioModel>> loginUsuarioAsync(
      String email) async {
    return executeSafely(() async {
      var result = await datasource.loginUsuarioAsync(email);
      return result;
    });
  }
  
}
