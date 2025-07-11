import 'package:dio/dio.dart';

class DialError {
  static String dialError(dynamic error) {
    if (error is String) {
      if (error.isEmpty) {
        return "Erro não esperado!";
      }

      return error;
    }

    if (error is Error) return "Erro interno não esperado";

    if (error.response == null) return error.message;

    var errors = error.response.data;

    if (errors["errors"] == null) return error.message;

    var list = errors["errors"] as List;
    if (list.isNotEmpty) {
      return list[0];
    }

    return "Erro não esperado!";
  }

  static DioException dialErrorDio(DioException dioError) {
    if (dioError.response == null) {
      return DioException(
          requestOptions: dioError.requestOptions,
          error: "Erro não esperado, tente novamente mais tarde!");
    }

    var errors = dioError.response?.data;

    if (dioError.response?.statusCode == 401) {
      return DioException(
          requestOptions: dioError.requestOptions,
          error: "Usuário expirado, favor realizar o login novamente!");
    }

    if (errors is String) {
      if (errors.isEmpty) {
        return DioException(
            requestOptions: dioError.requestOptions, error: dioError.message);
      }

      return DioException(
          requestOptions: dioError.requestOptions, error: errors);
    }

    if (errors is Map<String, dynamic>) {
      if (errors["errors"] == null) {
        return DioException(
            requestOptions: dioError.requestOptions,
            error: "Erro não esperado!");
      }
    } else {
      return DioException(
          requestOptions: dioError.requestOptions, error: dioError.message);
    }

    var list = errors["errors"] as List;
    if (list.isNotEmpty) {
      return DioException(
          requestOptions: dioError.requestOptions, error: list[0]);
    }

    return DioException(
        requestOptions: dioError.requestOptions, error: "Erro não esperado!");
  }
}
