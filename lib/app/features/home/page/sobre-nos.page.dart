import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iva_app/app/core/providers/theme_provider.dart';
import 'package:iva_app/app/core/widgets/painel/painel-default.widget.dart';

class SobreNosPage extends StatefulWidget {
  const SobreNosPage({super.key});

  @override
  State<SobreNosPage> createState() => _SobreNosPageState();
}

class _SobreNosPageState extends State<SobreNosPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PainelDefault(
      subTitulo: "Sobre nós",
      showNotification: true,
      showBackButton: true,
      showBottomNavigationBar: true,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
              child: Column(
            children: [
              Text(
                "Aqui é o seu lugar! 💛",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              )
            ],
          )),
          const SizedBox(height: 20),
          Image.asset(
            "assets/images/iva_povo.jpg",
            fit: BoxFit.contain,
            height: 300,
            width: 300,
          ),
          const SizedBox(height: 30),
          Center(
              child: Text(
            "Acreditamos que cada um de nós tem o poder de fazer a diferença. Juntos, podemos criar um mundo mais justo e igualitário.",
            style: TextStyle(
              fontSize: 16,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          )),
          const SizedBox(height: 20),
          const SizedBox(height: 40),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
