import 'package:flutter/material.dart';
import 'package:iva_app/app/core/locator/locator.dart';
import 'package:iva_app/app/core/models/dialog-request.dart';
import 'package:iva_app/app/core/models/dialog-response.dart';
import 'package:iva_app/app/core/services/dialog.service.dart';
import 'package:iva_app/app/core/widgets/dialog/dialog.widget.dart';

class DialogManager extends StatefulWidget {
  final Widget child;

  const DialogManager({super.key, required this.child});

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    showDialog(
      context: context,
      builder: (BuildContext contextConfirmacao) {
        return DialogWidget(
          title: request.title,
          content: request.description,
          yes: request.buttonTitle,
          no: request.cancelTitle ?? '',
          yesOnPressed: () {
            _dialogService.dialogComplete(DialogResponse(confirmed: true));
          },
          noOnPressed: () {
            _dialogService.dialogComplete(DialogResponse(confirmed: false));
          },
        );
      },
    );
  }
}
