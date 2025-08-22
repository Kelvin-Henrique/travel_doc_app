import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_doc_app/app/features/loader/usecases/loader.controller.dart';

import 'custom-interceptor-request.dart';

class InterceptorRequest {
  Dio dio;

  LoaderController controller = GetIt.I.get<LoaderController>();

  InterceptorRequest(this.dio) {
    dio = dio..interceptors.add(CustomInterceptor());
  }
}
