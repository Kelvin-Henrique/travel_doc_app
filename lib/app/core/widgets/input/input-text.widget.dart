import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputText extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final double fontSized;
  final bool disabled;
  final int maxLength;
  final String? value;
  final TextEditingController? controller;
  final MaskTextInputFormatter? mask;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;

  const InputText(
      {super.key,
      required this.label,
      required this.height,
      required this.width,
      this.fontSized = 13,
      this.disabled = false,
      this.maxLength = 200,
      this.value,
      this.onChanged,
      this.validator,
      this.mask,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        controller: controller,
        inputFormatters: mask != null ? [mask!] : [],
        decoration: InputDecoration(
          labelText: label,
        ),
        style: TextStyle(fontSize: fontSized),
        maxLength: maxLength,
        enabled: !disabled,
        initialValue: value,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
