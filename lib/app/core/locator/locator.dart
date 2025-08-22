import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_doc_app/app/core/interceptors/interceptor-request.dart';
import 'package:travel_doc_app/app/core/logs/log.dart';
import 'package:travel_doc_app/app/core/platform/network-info/inetwork-info.dart';
import 'package:travel_doc_app/app/core/platform/network-info/network-info.dart';
import 'package:travel_doc_app/app/core/services/dialog.service.dart';
import 'package:travel_doc_app/app/core/services/erro.service.dart';
import 'package:travel_doc_app/app/features/loader/usecases/loader.controller.dart';

import 'locator.config.dart';

final locator = GetIt.instance;

@InjectableInit()
void setupDependencies() {
  locator.registerLazySingleton(() => Log());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => ErroService());

  locator.registerLazySingleton(() => InterceptorRequest(Dio()).dio);
  locator.registerLazySingleton(() => LoaderController());
  locator.registerLazySingleton<INetworkInfo>(() => NetworkInfo());
  locator.init();
}
