// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loader.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoaderController on _LoaderControllerBase, Store {
  late final _$loadingAtom =
      Atom(name: '_LoaderControllerBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_LoaderControllerBaseActionController =
      ActionController(name: '_LoaderControllerBase', context: context);

  @override
  dynamic startLoading() {
    final _$actionInfo = _$_LoaderControllerBaseActionController.startAction(
        name: '_LoaderControllerBase.startLoading');
    try {
      return super.startLoading();
    } finally {
      _$_LoaderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic stopLoading() {
    final _$actionInfo = _$_LoaderControllerBaseActionController.startAction(
        name: '_LoaderControllerBase.stopLoading');
    try {
      return super.stopLoading();
    } finally {
      _$_LoaderControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}
