/* import 'package:flutter/material.dart';
import 'package:ventuno_app/app/core/widgets/animate/animate.widget.dart';

class SolicitacaoSucessoPage extends StatefulWidget {
  final Widget? button;
  final String? mensagem;
  final int? matricula;

  const SolicitacaoSucessoPage(
      {super.key, this.button, this.matricula, this.mensagem});

  @override
  _SolicitacaoSucessoPageState createState() => _SolicitacaoSucessoPageState();
}

class _SolicitacaoSucessoPageState extends State<SolicitacaoSucessoPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimateWidget(
                curve: Curves.bounceInOut,
                child: Container(
                  child: Icon(
                    Icons.check_circle,
                    color: const Color(0xFFFF6F00),
                    size: 200,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.mensagem ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              if (widget.matricula != null && widget.matricula! > 0) ...[
                SizedBox(height: 16),
                Text(
                  "Matrícula: ${widget.matricula}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
              SizedBox(height: 24),
              if (widget.button != null) widget.button!,
            ],
          ),
        ),
      ),
    );
  }
}
 */
