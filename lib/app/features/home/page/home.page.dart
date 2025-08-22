import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// O conteúdo deste arquivo foi atualizado para a HomePage,
// com um layout claro e barra de navegação flutuante.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          color: Colors.white,
          child: SafeArea(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A4DA1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.flight, color: Colors.white, size: 22),
                        const SizedBox(width: 4),
                        Icon(Icons.directions_car, color: Colors.white, size: 22),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'TravelDoc',
                  style: TextStyle(
                    color: Color(0xFF0A4DA1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: Colors.black54),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[200],
                  child: Text('JS', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra de progresso próxima viagem
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      value: 0.7,
                      minHeight: 7,
                      backgroundColor: Colors.grey[300],
                      color: const Color(0xFF0A4DA1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Faltam 8 dias para sua próxima viagem',
                      style: TextStyle(
                        color: Color(0xFF0A4DA1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Campo de busca
              TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar viagens...',
                  prefixIcon: Icon(Icons.search, color: Colors.black38),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF0A4DA1), width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Gerencie seus documentos e viagens em um só lugar',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 18),

              // Título Próximas Viagens
              Row(
                children: [
                  const Text(
                    'Próximas Viagens',
                    style: TextStyle(
                      color: Color(0xFF0A4DA1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF0A4DA1), width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: 'Todas',
                      underline: Container(),
                      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF0A4DA1)),
                      items: const [
                        DropdownMenuItem(value: 'Todas', child: Text('Todas')),
                        DropdownMenuItem(value: 'Minhas', child: Text('Minhas')),
                      ],
                      onChanged: (v) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Indicador de rolagem
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.keyboard_arrow_down, color: Colors.black38, size: 22),
                  SizedBox(width: 4),
                  Text(
                    'Arraste para ver mais',
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Cards de viagem em coluna com barra de rolagem
              Container(
                height: 260,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      _buildViagemCard(
                        local: 'Portugal - Lisboa',
                        tipo: 'Viagem de negócios',
                        tags: ['Criada por mim', 'Viagem próxima'],
                        periodo: '29/08/2025 - 04/09/2025',
                        participantes: '1 participante(s) (João Silva)',
                        documentos: '0 documento(s)',
                        descricao: 'Conferência internacional',
                      ),
                      const SizedBox(height: 16),
                      _buildViagemCard(
                        local: 'França - Paris',
                        tipo: 'Lua de mel',
                        tags: ['Criada por mim'],
                        periodo: '14/09/2025 - 21/09/2025',
                        participantes: '2 participante(s) (João Silva, Maria Santos)',
                        documentos: '1 documento(s)',
                        descricao: 'Lua de mel em Paris',
                      ),
                      // Adicione mais cards conforme necessário
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Ofertas de parceiros
              const Text(
                'Ofertas de Parceiros',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              _buildOfertaCard(
                titulo: 'Alerta Amarelo',
                subtitulo: 'Ofertas arrasadoras para aproveitar agora',
                parceiro: 'Paradise Travel',
                preco: 'A partir de R\$ 299',
                cor: Colors.amber,
              ),
              const SizedBox(height: 12),
              _buildOfertaCard(
                titulo: 'Hora de Viajar',
                subtitulo: 'Prepare-se para sua próxima aventura',
                parceiro: 'Adventure Tours',
                preco: 'A partir de R\$ 299',
                cor: Colors.lightBlue,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildViagemCard({
    required String local,
    required String tipo,
    required List<String> tags,
    required String periodo,
    required String participantes,
    required String documentos,
    required String descricao,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Color(0xFF0A4DA1), size: 20),
              const SizedBox(width: 4),
              Text(
                local,
                style: const TextStyle(
                  color: Color(0xFF0A4DA1),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            tipo,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: tags.map((tag) {
              final isYellow = tag == 'Viagem próxima';
              return Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isYellow ? Colors.amber[200] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: isYellow ? Colors.orange[900] : Color(0xFF0A4DA1),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(periodo, style: TextStyle(color: Colors.black87, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.people, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(participantes, style: TextStyle(color: Colors.black87, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.description, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(documentos, style: TextStyle(color: Colors.black87, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            descricao,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Color(0xFF0A4DA1), size: 20),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.black38, size: 20),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOfertaCard({
    required String titulo,
    required String subtitulo,
    required String parceiro,
    required String preco,
    required Color cor,
  }) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/images/oferta_bg.jpg'), // Imagem genérica, troque se quiser
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.darken),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  subtitulo,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    parceiro,
                    style: TextStyle(
                      color: cor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: cor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                preco,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 8,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.8),
                minimumSize: const Size(80, 28),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Ver ofertas',
                style: TextStyle(
                  color: Color(0xFF0A4DA1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Viagens',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.camera_alt),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          label: 'Documentos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Pessoas',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF0A4DA1),
      unselectedItemColor: Colors.black38,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }
}
