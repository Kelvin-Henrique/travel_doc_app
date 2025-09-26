import 'package:dartz/dartz.dart';
import 'package:travel_doc_app/app/core/errors/failures.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';

abstract class ILoginRepository {
Future<Either<Failure, UsuarioModel>> loginUsuarioAsync(
      String email);
}
