import '../../data/models/pais.model.dart';
import '../../data/services/pais.service.dart';

class PaisController {
  final _service = PaisService();

  Future<List<PaisModel>> buscarPaisesAsync() {
    return _service.buscarPaisesAsync();
  }
}
