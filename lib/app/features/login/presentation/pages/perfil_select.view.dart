import 'package:flutter/material.dart';
import 'package:travel_doc_app/app/features/home/page/home.page.dart';

class PerfilSelectView extends StatefulWidget {
  const PerfilSelectView({super.key});

  @override
  State<PerfilSelectView> createState() => _PerfilSelectViewState();
}

class _PerfilSelectViewState extends State<PerfilSelectView> {
  int? _selectedPerfil; // 0 = Viajante, 1 = Agência

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xEAF2FBFF),
      body: Center(
        child: Container(
          width: size.width < 400 ? size.width * 0.95 : 400,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo azul com ícones
              Container(
                width: 110,
                height: 90,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A4DA1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flight, color: Colors.white, size: 32),
                      const SizedBox(width: 12),
                      Icon(Icons.directions_car, color: Colors.white, size: 32),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selecione seu perfil',
                style: TextStyle(
                  color: Color(0xFF0A4DA1),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Escolha como você utilizará o TravelDoc',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 28),

              // Opção Viajante
              InkWell(
                onTap: () => setState(() => _selectedPerfil = 0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: _selectedPerfil == 0 ? const Color(0xFF0A4DA1) : Colors.black12,
                      width: _selectedPerfil == 0 ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 0,
                        groupValue: _selectedPerfil,
                        onChanged: (v) => setState(() => _selectedPerfil = v),
                        activeColor: const Color(0xFF0A4DA1),
                      ),
                      const Icon(Icons.person, color: Color(0xFF0A4DA1)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Viajante',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Organize suas próprias viagens',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Opção Agência de Turismo
              InkWell(
                onTap: () => setState(() => _selectedPerfil = 1),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: _selectedPerfil == 1 ? const Color(0xFF0A4DA1) : Colors.black12,
                      width: _selectedPerfil == 1 ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Radio<int>(
                        value: 1,
                        groupValue: _selectedPerfil,
                        onChanged: (v) => setState(() => _selectedPerfil = v),
                        activeColor: const Color(0xFF0A4DA1),
                      ),
                      const Icon(Icons.business, color: Color(0xFF0A4DA1)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Agência de Turismo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Gerencie viagens para seus clientes',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Botão Continuar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedPerfil == null ? null : () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A4DA1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    disabledBackgroundColor: const Color(0xFFBFD4EA),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
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
