import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iva_app/app/core/models/dialog-request.dart';
import 'package:iva_app/app/core/models/dialog-response.dart';

class DialogService {
  final GlobalKey<NavigatorState> _dialogNavigationKey =
      GlobalKey<NavigatorState>();
  Function(DialogRequest)? _showDialogListener;
  late Completer<DialogResponse> _dialogCompleter;

  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  void registerDialogListener(Function(DialogRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<DialogResponse> showDialog({
    required String title,
    required String description,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    if (_showDialogListener != null) {
      _showDialogListener!(DialogRequest(
        title: title,
        description: description,
        buttonTitle: buttonTitle,
      ));
    } else {
      throw Exception('Dialog listener is not registered');
    }
    return _dialogCompleter.future;
  }

  void dialogComplete(DialogResponse response) {
    _dialogCompleter.complete(response);
    _dialogNavigationKey.currentState?.pop();
  }
}
