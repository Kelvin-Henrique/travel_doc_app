import 'package:flutter_modular/flutter_modular.dart';
import 'package:travel_doc_app/app/features/home/home.module.dart';
import 'package:travel_doc_app/app/features/login/login.module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: LoginModule());
    r.module('/home', module: HomeModule());
  }
}
