import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iva_app/app/core/providers/theme_provider.dart';
import 'package:iva_app/app/core/widgets/painel/painel-default.widget.dart';

class PedidosOracaoPage extends StatefulWidget {
  const PedidosOracaoPage({super.key});

  @override
  State<PedidosOracaoPage> createState() => _PedidosOracaoPageState();
}

class _PedidosOracaoPageState extends State<PedidosOracaoPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _pedidoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nomeController.dispose();
    _pedidoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PainelDefault(
      subTitulo: "Pedidos de Oração!",
      showNotification: true,
      showBackButton: true,
      showBottomNavigationBar: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Envie seu pedido de oração",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nomeController,
                style: TextStyle(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Seu nome',
                  labelStyle: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.yellow
                          : Colors.black54),
                  hintText: 'Digite seu nome',
                  hintStyle: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.grey
                          : Colors.black54),
                  prefixIcon: Icon(Icons.person,
                      color: themeProvider.isDarkMode
                          ? Colors.yellow
                          : Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: themeProvider.isDarkMode
                            ? Colors.yellow
                            : Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: themeProvider.isDarkMode
                            ? Colors.yellow
                            : Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite seu nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _pedidoController,
                maxLines: 5,
                style: TextStyle(
                    color:
                        themeProvider.isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  labelText: 'Seu pedido de oração',
                  labelStyle: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.yellow
                          : Colors.black54),
                  hintText: 'Digite seu pedido de oração',
                  hintStyle: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.grey
                          : Colors.black54),
                  prefixIcon: Icon(Icons.message,
                      color: themeProvider.isDarkMode
                          ? Colors.yellow
                          : Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: themeProvider.isDarkMode
                            ? Colors.yellow
                            : Colors.black54),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: themeProvider.isDarkMode
                            ? Colors.yellow
                            : Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite seu pedido de oração';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implementar envio do pedido de oração
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Pedido de oração enviado com sucesso!',
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                        backgroundColor: themeProvider.isDarkMode
                            ? Colors.yellow
                            : Colors.black,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(200, 50),
                ),
                child: const Text(
                  'ENVIAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
