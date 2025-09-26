import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/core/logs/log.dart';
import 'package:travel_doc_app/app/core/models/dial-error.model.dart';
import 'package:travel_doc_app/app/features/loader/usecases/loader.controller.dart';
import 'package:travel_doc_app/themes/flavors.dart';

void _showErrorDialog(String mensagem) {
  final context = Modular.routerDelegate.navigatorKey.currentState?.context;
  if (context != null) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 8),
            const Text('Erro'),
          ],
        ),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class CustomInterceptor extends Interceptor {
  LoaderController controller = GetIt.I.get<LoaderController>();

  final Log _log = locator<Log>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
   options.baseUrl = F.apiUrl;

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

    String mensagem = "Erro não esperado, tente novamente mais tarde!";

    if (err.response == null) {
      _showErrorDialog(mensagem);
      return super.onError(
          DioException(
              requestOptions: err.requestOptions,
              error: mensagem),
          handler);
    }

    if (err.response?.statusCode == 400) {
      dynamic data = err.response?.data;
      if (data is Map) {
        if (data['mensagem'] != null && data['mensagem'].toString().isNotEmpty) {
          mensagem = data['mensagem'].toString();
        } else if (data['message'] != null && data['message'].toString().isNotEmpty) {
          mensagem = data['message'].toString();
        } else {
          mensagem = data.values.isNotEmpty ? data.values.first.toString() : mensagem;
        }
      } else if (data is String && data.isNotEmpty) {
        mensagem = data;
      } else if (data != null) {
        mensagem = data.toString();
      }
      _showErrorDialog(mensagem);
      return super.onError(
          DioException(
              requestOptions: err.requestOptions,
              error: mensagem),
          handler);
    }

    if (err.response?.statusCode == 401) {
      mensagem = "Por favor, realize novamente o login";
      _showErrorDialog(mensagem);
      Modular.to.pushNamed('/login');
      return super.onError(
          DioException(
              requestOptions: err.requestOptions,
              error: mensagem),
          handler);
    }

    controller.stopLoading();

    _showErrorDialog(DialError.dialErrorDio(err).error.toString());

    return super.onError(DialError.dialErrorDio(err), handler);
  }
}
