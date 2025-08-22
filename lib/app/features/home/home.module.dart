import 'package:flutter_modular/flutter_modular.dart';
import 'package:travel_doc_app/app/features/home/page/agenda.page.dart';
import 'package:travel_doc_app/app/features/home/page/home.page.dart';
import 'package:travel_doc_app/app/features/home/page/oracao.page.dart';
import 'package:travel_doc_app/app/features/home/page/sobre-nos.page.dart';

class HomeModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
    r.child('/sobre', child: (context) => const SobreNosPage());
    r.child('/agenda', child: (context) => const AgendaPage());
    r.child('/oracao', child: (context) => const PedidosOracaoPage());
  }
}
