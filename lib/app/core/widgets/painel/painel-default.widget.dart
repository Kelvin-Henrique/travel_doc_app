import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// O widget PainelDefault foi atualizado para remover o modo noturno
// e apresentar um design mais moderno no cabeçalho.

class PainelDefault extends StatelessWidget {
  final String? titulo;
  final String? tituloPagina;
  final Widget? body;
  final int currentIndex;
  final Function(int)? onTabTapped;
  final String? subTitulo;
  final bool showBottomNavigationBar;
  final bool showNotification;
  final bool showBackButton;
  final bool showLogoutButton;
  final VoidCallback? onLogout;

  const PainelDefault({
    super.key,
    this.titulo,
    this.tituloPagina,
    this.body,
    required this.subTitulo,
    this.currentIndex = 0,
    this.onTabTapped,
    required this.showNotification,
    required this.showBottomNavigationBar,
    this.showBackButton = false,
    this.showLogoutButton = false,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F5F5), // Cor de fundo padrão para o app
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Stack(
          children: [
            // Container do cabeçalho com gradiente
            Container(
              height: 180,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFD60A), Color(0xFFFFC300)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30), // Espaço para os ícones no topo
                    // Logo
                    Image(
                      image: const AssetImage("assets/images/logoIva.png"),
                      fit: BoxFit.contain,
                      height: 50.0,
                      color: Colors.black, // Cor fixa
                    ),
                    const SizedBox(height: 15),
                    // Subtítulo
                    Text(
                      subTitulo?.toUpperCase() ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Cor fixa
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Botão de voltar
            if (showBackButton)
              Positioned(
                top: 45,
                left: 10,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            // Ícones à direita (Notificação e Logout)
            Positioned(
              top: 45,
              right: 10,
              child: Row(
                children: [
                  if (showNotification)
                    IconButton(
                      onPressed: () {
                        // TODO: Implementar navegação para a tela de notificações.
                      },
                      icon: const FaIcon(FontAwesomeIcons.bell,
                          color: Colors.black, size: 22),
                    ),
                  if (showLogoutButton)
                    IconButton(
                      onPressed: onLogout,
                      icon: const FaIcon(FontAwesomeIcons.signOutAlt,
                          color: Colors.black, size: 22),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: body,
      // A BottomNavigationBar permanece comentada, conforme o código original.
      /* bottomNavigationBar: showBottomNavigationBar
          ? BottomNavigationBar(...)
          : null, */
    );
  }
}
