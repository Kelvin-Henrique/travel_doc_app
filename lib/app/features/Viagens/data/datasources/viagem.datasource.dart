import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/features/Viagens/data/datasources/iviagem.datasource.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';


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

}
