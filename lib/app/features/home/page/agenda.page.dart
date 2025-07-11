import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iva_app/app/core/providers/theme_provider.dart';
import 'package:iva_app/app/core/widgets/painel/painel-default.widget.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  final List<Map<String, dynamic>> eventos = [
    {
      'dia': 'Domingo',
      'eventos': [
        {'hora': '09h', 'nome': 'Culto da Família'},
        {'hora': '18h', 'nome': 'Culto da Família'},
      ]
    },
    {
      'dia': 'Segunda-feira',
      'eventos': [
        {'hora': '20h', 'nome': 'Sala de Oração'},
      ]
    },
    {
      'dia': 'Quarta-feira',
      'eventos': [
        {'hora': '20h', 'nome': 'Quarta Profética'},
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PainelDefault(
      subTitulo: "Agenda da Semana!",
      showNotification: true,
      showBackButton: true,
      showBottomNavigationBar: true,
      body: ListView(
        children: eventos.map((dia) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Card(
                    color: themeProvider.isDarkMode
                        ? const Color.fromARGB(255, 30, 30, 30)
                        : Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: themeProvider.isDarkMode
                                      ? Colors.yellow
                                      : Colors.black),
                              onPressed: () {},
                            ),
                            Text(
                              dia['dia'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image(
                                image: const AssetImage(
                                  'assets/images/clock_icon.png',
                                ),
                                height: 20,
                                width: 20,
                                color: themeProvider.isDarkMode
                                    ? Colors.yellow
                                    : Colors.black,
                              ),
                              onPressed: () {
                                // Ação ao clicar no botão
                              },
                            ),
                            Text(
                              '20h - Culto da Família',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
