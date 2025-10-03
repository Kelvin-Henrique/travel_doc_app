
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/viagens.model.dart';

abstract class IViagemDatasource{
  Future cadastrarViagemAsync(CadastroViagemRequest dadosViagem);
  Future<List<ViagensModel>> obterViagemPorUsuarioIdAsync();
  Future convidarParticipanteAsync(String email, int viagemId);
}
