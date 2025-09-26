import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';

abstract class ILoginDatasource{
  Future<UsuarioModel> loginUsuarioAsync(String email);
}
