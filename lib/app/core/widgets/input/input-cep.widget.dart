import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputCepWidget extends StatefulWidget {
  final String? label;
  final double? height;
  final double? width;
  final double fontSized;
  final bool disabled;
  final int maxLength;
  final String? value;
  final TextEditingController? controller;
  final MaskTextInputFormatter? mask;
  final void Function(String value)? onChanged;
  final String Function(String value)? validator;

  const InputCepWidget(
      {super.key,
      this.label,
      this.height,
      this.width,
      this.fontSized = 13,
      this.disabled = false,
      this.maxLength = 200,
      this.value,
      this.onChanged,
      this.validator,
      this.mask,
      this.controller});

  @override
  State<InputCepWidget> createState() => _InputCepWidgetState();
}

class _InputCepWidgetState extends State<InputCepWidget> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: widget.width,
      child: Container(
        child: TextFormField(
          inputFormatters: [maskFormatter],
          validator: (input) => widget.validator!(input!),
          initialValue: maskFormatter.maskText(widget.value ?? ''),
          textInputAction: TextInputAction.done,
          readOnly: widget.disabled,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            widget.onChanged!(maskFormatter.getUnmaskedText());
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8.0),
            labelText: widget.label,
            errorStyle: TextStyle(height: 0),
            labelStyle: TextStyle(
              fontSize: widget.fontSized,
            ),
            filled: widget.disabled,
            fillColor: Color(0xFFF2F2F2),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                width: 2,
                color: Colors.red,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 2,
                color: Color(0xFF52a1bf),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
