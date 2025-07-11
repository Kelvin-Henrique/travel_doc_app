import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputPercentageText extends StatefulWidget {
  final String label;
  final double height;
  final double width;
  final double fontSize;
  final bool disabled;
  final int maxLength;
  final double value;
  final void Function(double value)? onChanged;
  final String Function(double value)? validator;

  const InputPercentageText({
    super.key,
    required this.label,
    required this.height,
    required this.width,
    this.fontSize = 13,
    this.disabled = false,
    this.maxLength = 200,
    required this.value,
    this.onChanged,
    this.validator,
  });

  @override
  _InputPercentageTextState createState() => _InputPercentageTextState();
}

class _InputPercentageTextState extends State<InputPercentageText> {
  late TextEditingController _controller;
  late NumberFormat _numberFormat;

  @override
  void initState() {
    super.initState();
    _numberFormat = NumberFormat.percentPattern('pt_BR');
    _controller =
        TextEditingController(text: _numberFormat.format(widget.value));
  }

  void _onChanged(String value) {
    String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    double newValue = double.parse(cleanedValue) / 100;
    _controller.value = TextEditingValue(
      text: _numberFormat.format(newValue),
      selection: TextSelection.collapsed(
          offset: _numberFormat.format(newValue).length),
    );
    if (widget.onChanged != null) {
      widget.onChanged!(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: _onChanged,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(),
        ),
        style: TextStyle(fontSize: widget.fontSize),
        enabled: !widget.disabled,
        maxLength: widget.maxLength,
      ),
    );
  }
}
