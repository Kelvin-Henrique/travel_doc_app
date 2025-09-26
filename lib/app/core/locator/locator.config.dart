// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:travel_doc_app/app/core/platform/network-info/inetwork-info.dart'
    as _i775;
import 'package:travel_doc_app/app/features/login/data/datasources/ilogin.datasource.dart'
    as _i1008;
import 'package:travel_doc_app/app/features/login/data/datasources/login.datasource.dart'
    as _i793;
import 'package:travel_doc_app/app/features/login/data/repositories/login.repository.dart'
    as _i1058;
import 'package:travel_doc_app/app/features/login/domain/repositories/ilogin.repository.dart'
    as _i627;
import 'package:travel_doc_app/app/features/login/domain/usecases/login.usecase.dart'
    as _i242;
import 'package:travel_doc_app/app/features/login/presentation/controllers/login.controller.dart'
    as _i279;
import 'package:travel_doc_app/app/features/usuario-cadastro/data/datasources/iusuario-cadastro.datasource.dart'
    as _i249;
import 'package:travel_doc_app/app/features/usuario-cadastro/data/datasources/usuario-cadastro.datasource.dart'
    as _i1015;
import 'package:travel_doc_app/app/features/usuario-cadastro/data/repositories/usuario-cadastro.repository.dart'
    as _i592;
import 'package:travel_doc_app/app/features/usuario-cadastro/domain/repositories/iusuario-cadastro.repository.dart'
    as _i176;
import 'package:travel_doc_app/app/features/usuario-cadastro/domain/usecases/cadastrar-usuario.usecase.dart'
    as _i55;
import 'package:travel_doc_app/app/features/usuario-cadastro/presentation/controllers/usuario-cadastro.controller.dart'
    as _i336;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i249.IUsuarioCadastroDatasource>(
        () => _i1015.UsuarioCadastroDatasource(gh<_i361.Dio>()));
    gh.factory<_i176.IUsuarioCadastroRepository>(
        () => _i592.UsuarioCadastroRepository(
              datasource: gh<_i249.IUsuarioCadastroDatasource>(),
              networkInfo: gh<_i775.INetworkInfo>(),
            ));
    gh.factory<_i1008.ILoginDatasource>(
        () => _i793.LoginDatasource(gh<_i361.Dio>()));
    gh.factory<_i627.ILoginRepository>(() => _i1058.LoginRepository(
          datasource: gh<_i1008.ILoginDatasource>(),
          networkInfo: gh<_i775.INetworkInfo>(),
        ));
    gh.singleton<_i55.CadastrarUsuarioUsecase>(() =>
        _i55.CadastrarUsuarioUsecase(
            repository: gh<_i176.IUsuarioCadastroRepository>()));
    gh.singleton<_i242.LoginUsecase>(
        () => _i242.LoginUsecase(repository: gh<_i627.ILoginRepository>()));
    gh.singleton<_i279.LoginController>(() => _i279.LoginController());
    gh.singleton<_i336.UsuarioCadastroController>(
        () => _i336.UsuarioCadastroController());
    return this;
  }
}
