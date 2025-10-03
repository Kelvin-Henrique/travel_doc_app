// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viagem.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ViagemController on _ViagemControllerBase, Store {
  late final _$cadastrarViagemAsyncAsyncAction = AsyncAction(
      '_ViagemControllerBase.cadastrarViagemAsync',
      context: context);

  @override
  Future<void> cadastrarViagemAsync(CadastroViagemRequest dadosCadastros) {
    return _$cadastrarViagemAsyncAsyncAction
        .run(() => super.cadastrarViagemAsync(dadosCadastros));
  }

  late final _$obterViagensPorUsuarioIdAsyncAsyncAction = AsyncAction(
      '_ViagemControllerBase.obterViagensPorUsuarioIdAsync',
      context: context);

  @override
  Future<List<ViagensEntity>> obterViagensPorUsuarioIdAsync() {
    return _$obterViagensPorUsuarioIdAsyncAsyncAction
        .run(() => super.obterViagensPorUsuarioIdAsync());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
