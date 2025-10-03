import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/helpers/shared-preferences.dart';
import 'package:travel_doc_app/app/features/Viagens/data/datasources/iviagem.datasource.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/viagens.model.dart';


@Injectable(as: IViagemDatasource, order: -1)
class ViagemDatasource extends IViagemDatasource {
  final Dio dio;

  ViagemDatasource(this.dio);

  @override
  Future cadastrarViagemAsync(CadastroViagemRequest dadosViagem) async {
    final response = await dio.post('/viagens', data: dadosViagem.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception('Erro ao cadastrar viagem');
    }
  }

  @override
  Future<List<ViagensModel>> obterViagemPorUsuarioIdAsync() async {
    var cliente = await SharedPreferencesHelper.getClient();
    final response = await dio.get('/viagens/usuario/${cliente.id}');
    
    if (response.statusCode == 200) {
      final lista = (response.data as List)
          .map((json) => ViagensModel.fromJson(json))
          .toList();
      return lista;
    } else {
      throw Exception('Erro ao buscar viagens');
    }
  }

  @override
  Future convidarParticipanteAsync(String email, int viagemId) async {
    final response = await dio.post('/viagens/participantes', data: {'emailConvidado': email, 'viagemId': viagemId});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception('Erro ao convidar participante');
    }
  }
}
