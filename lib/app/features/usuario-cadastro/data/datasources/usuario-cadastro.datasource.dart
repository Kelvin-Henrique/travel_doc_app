import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/datasources/iusuario-cadastro.datasource.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario-cadastro-request.dart';


@Injectable(as: IUsuarioCadastroDatasource, order: -1)
class UsuarioCadastroDatasource extends IUsuarioCadastroDatasource {
  final Dio dio;

  UsuarioCadastroDatasource(this.dio);

  @override
  Future cadastrarUsuarioAsync(UsuarioCadastroRequest dadosCadastro) async {
    final response = await dio.post('/usuarios', data: dadosCadastro.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception('Erro ao cadastrar usuário');
    }
  }

  @override
  Future atualizarUsuarioAsync(UsuarioCadastroRequest dadosAtualizacao) async {
    final response = await dio.post('/usuarios', data: dadosAtualizacao.toJson());
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro ao atualizar usuário');
    }
  }

}
