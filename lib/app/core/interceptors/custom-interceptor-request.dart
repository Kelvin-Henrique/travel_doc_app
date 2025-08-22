import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/core/logs/log.dart';
import 'package:travel_doc_app/app/features/loader/usecases/loader.controller.dart';

class CustomInterceptor extends Interceptor {
  LoaderController controller = GetIt.I.get<LoaderController>();

  final Log _log = locator<Log>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
/*     options.baseUrl = F.apiUrl;
 */
    options.headers['ApiKey'] = 'E91rJ3YSa8p9hLMbi3JGbrUi6O37cDDO6qRE8szL';

    controller.startLoading();

    _log.saveRequest(options);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    controller.stopLoading();

    _log.saveResponse(response);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log.saveError(err);

    controller.stopLoading();

    if (err.response == null) {
      return super.onError(
          DioException(
              requestOptions: err.requestOptions,
              error: "Erro não esperado, tente novamente mais tarde!"),
          handler);
    }

    if (err.response?.statusCode == 401) {
      Modular.to.pushNamed('/login');
      return super.onError(
          DioException(
              requestOptions: err.requestOptions,
              error: "Por favor, realize novamente o login"),
          handler);
    }

    return super.onError(
        DioException(
            requestOptions: err.requestOptions,
            error: err.response?.data['descri_retorno']),
        handler);
  }
}
