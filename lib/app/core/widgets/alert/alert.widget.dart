import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:iva_app/app/core/widgets/animate/animate.widget.dart';
import 'package:iva_app/app/core/widgets/button/button.widget.dart';

class AlertWidget extends StatelessWidget {
  final String titulo;
  final String mensagem;
  final IconData icone;

  const AlertWidget(
      {super.key,
      required this.titulo,
      required this.mensagem,
      required this.icone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              color: Colors.black38,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimateWidget(
                  curve: Curves.elasticOut,
                  child: Icon(
                    icone,
                    color: Color(0xFFFF9800),
                    size: 100,
                  ),
                ),
                Text(
                  mensagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonWidget(
              color: Color(0xFFFF9800),
              left: 10,
              right: 10,
              description: "VER ACOMPANHAMENTO",
              onTap: () {
                Navigator.pop(context);
                Modular.to.popAndPushNamed("/acompanhamento");
              },
            ),
          ),
        ],
      ),
    );
  }
}
