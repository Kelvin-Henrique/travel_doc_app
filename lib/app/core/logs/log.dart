import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class Log {
  final String _logs = "logs";

  Future saveRequest(RequestOptions request) async {
    await FirebaseFirestore.instance.collection(_logs).doc(Uuid().v4()).set({
      'type': 'request',
      'method': request.method,
      'headers': request.headers,
      'apiUrl': '${request.baseUrl}${request.path}',
      'queryParameters': request.queryParameters,
      'body': request.data,
      'createdAt': FieldValue.serverTimestamp(),
      'expirationDate': DateTime.now().add(Duration(days: 90)),
    });
  }

  Future saveResponse(Response response) async {
    await FirebaseFirestore.instance.collection(_logs).doc(Uuid().v4()).set({
      'type': 'response',
      'method': response.requestOptions.method,
      'headers': response.requestOptions.headers,
      'apiUrl': '${response.requestOptions.baseUrl}${response.requestOptions.path}',
      'body': response.data,
      'statusCode': response.statusCode,
      'createdAt': FieldValue.serverTimestamp(),
      'expirationDate': DateTime.now().add(Duration(days: 90)),
    });
  }

  Future saveError(DioException error) async {
    await FirebaseFirestore.instance.collection(_logs).doc(Uuid().v4()).set({
      'type': 'error',
      'method': error.requestOptions.method,
      'headers': error.requestOptions.headers,
      'apiUrl': '${error.requestOptions.baseUrl}${error.requestOptions.path}',
      'errorMessage': error.message,
      'errorData': error.response?.data,
      'statusCode': error.response?.statusCode ?? 0,
      'createdAt': FieldValue.serverTimestamp(),
      'expirationDate': DateTime.now().add(Duration(days: 90)),
    });
  }
}

enum LogTypes { request, response, error }
