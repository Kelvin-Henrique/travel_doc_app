import 'package:flutter_modular/flutter_modular.dart';
import 'package:iva_app/app/features/login/presentation/pages/bem-vindo.page.dart';
import 'package:iva_app/app/features/login/presentation/pages/login.view.dart';

import 'presentation/pages/cadastro.view.dart';

class LoginModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (contex) => BemVindoPage());
    r.child('/login', child: (context) => LoginView());
    r.child('/cadastro', child: (context) => CadastroView());
  }
}
