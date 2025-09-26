
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';

abstract class IViagemDatasource{
  Future cadastrarViagemAsync(CadastroViagemRequest dadosViagem);
}
