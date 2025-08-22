import 'package:flutter_modular/flutter_modular.dart';
import 'package:travel_doc_app/app/features/login/presentation/pages/login.view.dart';

import 'presentation/pages/cadastro.view.dart';

class LoginModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => LoginView());
    r.child('/cadastro', child: (context) => CadastroView());
  }
}
