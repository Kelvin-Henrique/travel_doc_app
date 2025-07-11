import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InputCurrencyText extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double>? onChanged;

  const InputCurrencyText({super.key, this.initialValue = 0.0, this.onChanged});

  @override
  _InputCurrencyTextState createState() => _InputCurrencyTextState();
}

class _InputCurrencyTextState extends State<InputCurrencyText> {
  late TextEditingController _controller;
  late NumberFormat _numberFormat;

  @override
  void initState() {
    super.initState();
    _numberFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    _controller =
        TextEditingController(text: _numberFormat.format(widget.initialValue));
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
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: _onChanged,
      decoration: InputDecoration(
        labelText: 'Valor',
        border: OutlineInputBorder(),
      ),
    );
  }
}
