import 'package:flutter/material.dart';
import 'package:travel_doc_app/app/core/models/basic.model.dart';

class DropdownWidget extends StatefulWidget {
  final Function(BasicModel)? onChanged;
  final bool disabled;
  final String Function(BasicModel)? validator;
  final List<BasicModel>? lista;
  final BasicModel? valueDefault;
  final String titulo;
  final double width;

  const DropdownWidget(
      {super.key,
      this.onChanged,
      this.validator,
      this.disabled = false,
      this.lista,
      required this.titulo,
      this.valueDefault,
      this.width = double.infinity});

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late BasicModel selectValue;

  @override
  void initState() {
    super.initState();

    setState(() {
      selectValue = widget.valueDefault!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: widget.width,
      child: DropdownButtonFormField<BasicModel>(
        key: widget.key,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          labelText: widget.titulo,
          labelStyle: TextStyle(
            fontSize: 13,
          ),
          fillColor: Color(0xFF52a1bf),
          errorStyle: TextStyle(height: 0),
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
        value: selectValue,
        validator: widget.validator != null
            ? (value) {
                return widget.validator!(value!);
              }
            : null,
        onChanged: widget.disabled
            ? null
            : (BasicModel? value) {
                setState(() {
                  selectValue = value!;
                });
                widget.onChanged!(value!);
              },
        items: widget.lista != null
            ? widget.lista?.map((BasicModel value) {
                return DropdownMenuItem<BasicModel>(
                  value: value,
                  child: Text(value.nome),
                );
              }).toList()
            : List<DropdownMenuItem<BasicModel>>.empty(growable: true),
      ),
    );
  }
}
