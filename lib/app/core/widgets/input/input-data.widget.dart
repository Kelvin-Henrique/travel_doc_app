import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputData extends StatefulWidget {
  final bool disabled;
  final Function(DateTime)? onChanged;
  final String? name;
  final Function(DateTime)? onSaved;
  final DateTime? value;
  final String? Function(DateTime?)? validator;
  final bool border;

  const InputData({
    super.key,
    this.onChanged,
    this.validator,
    this.name,
    this.onSaved,
    this.border = true,
    this.value,
    this.disabled = false,
  });

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final _maskFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  late TextEditingController _controller;

  DateTime picker = DateTime.now();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.value != null ? _dateFormat.format(widget.value!) : '');
  }

  Future<void> _selectDate(BuildContext context) async {
    if (widget.disabled) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.value ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != widget.value) {
      setState(() {
        picker = picked;
        _controller.text = _dateFormat.format(picker);
      });
      if (widget.onChanged != null) {
        widget.onChanged!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.name,
        border: widget.border ? OutlineInputBorder() : InputBorder.none,
      ),
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(picker);
        }
        return null;
      },
      onSaved: (value) {
        if (widget.onSaved != null) {
          widget.onSaved!(picker);
        }
      },
      inputFormatters: [_maskFormatter],
      onTap: () => _selectDate(context),
      readOnly: true,
    );
  }
}
