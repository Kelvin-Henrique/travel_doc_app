import 'package:iva_app/app/core/locator/locator.dart';
import 'package:iva_app/app/core/models/dial-error.model.dart';

import 'dialog.service.dart';

class ErroService {
  final _dialogService = locator<DialogService>();
/*   final _analyticsService = locator<AnalyticsService>();
 */
  Future dispath(dynamic error, {String title = "Alerta"}) async {
    String erro = DialError.dialError(error);

    await _dialogService.showDialog(title: title, description: erro);
/*     await _analyticsService.logErroEvent(erro);
 */
  }
}
