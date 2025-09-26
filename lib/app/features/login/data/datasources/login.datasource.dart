import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/features/login/data/datasources/ilogin.datasource.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';
import 'package:travel_doc_app/app/core/helpers/shared-preferences.dart';



@Injectable(as: ILoginDatasource, order: -1)
class LoginDatasource extends ILoginDatasource {
  final Dio dio;

  LoginDatasource(this.dio);

  @override
  Future<UsuarioModel> loginUsuarioAsync(String email) async {
    final response = await dio.post('/login', data: {
      'email': email,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      final usuario = UsuarioModel.fromJson(response.data['value']);
      await SharedPreferencesHelper.setClient(usuario);
      return usuario;
    } else {
      throw Exception('Erro ao cadastrar usuário');
    }
  }

}
