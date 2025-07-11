import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// O conteúdo deste arquivo foi atualizado para a HomePage,
// com um layout escuro e barra de navegação flutuante.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2; // Inicia na aba "Home"

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Fundo escuro principal
      appBar: _buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildFeelingCard(),
              const SizedBox(height: 24),
              _buildSectionHeader(title: 'Para sua edificação'),
              const SizedBox(height: 16),
              // Adicione aqui os widgets da seção "Para sua edificação"
              Container(
                height: 200,
                alignment: Alignment.center,
                child: Text(
                  'Conteúdo em breve...',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Constrói a AppBar personalizada com tema escuro.
  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF121212), // Cor de fundo da AppBar
      elevation: 0,
      toolbarHeight: 80,
      title: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFF2A2A2A),
            child: Icon(Icons.person_outline, size: 28, color: Colors.white70),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Olá,',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
              ),
              const Text(
                'Bem-vindo! 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Ação para notificações
          },
          icon: Icon(
            FontAwesomeIcons.bell,
            color: Colors.grey[400],
            size: 22,
          ),
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png', // Seu logo
            height: 30,
            color: Colors.yellow[600], // Cor amarela para o logo
          ),
        ),
      ),
    );
  }

  /// Constrói o card "Como está se sentindo hoje?" com tema escuro.
  Widget _buildFeelingCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Text('😊', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          const Text(
            'Como está se sentindo hoje?',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }

  /// Constrói o cabeçalho de uma seção com tema escuro.
  Widget _buildSectionHeader({required String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Text(
                'Expandir',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: Colors.grey[400]),
            ],
          ),
        ),
      ],
    );
  }

  /// Constrói a BottomNavigationBar com efeito flutuante ("suspense").
  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.video_collection_outlined),
              label: 'Conteúdo',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.calendar),
              label: 'Eventos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Generosidade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Mais',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors
              .transparent, // Fundo transparente para usar a cor do Container
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.yellow[600],
          unselectedItemColor: Colors.grey[500],
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
        ),
      ),
    );
  }
}
