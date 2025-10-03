
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario-cadastro-request.dart';

abstract class IUsuarioCadastroDatasource{
  Future<void> cadastrarUsuarioAsync(UsuarioCadastroRequest dadosCadastro);
  Future<void> atualizarUsuarioAsync(UsuarioCadastroRequest dadosAtualizacao);
}
