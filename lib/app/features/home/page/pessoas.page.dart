import 'package:flutter/material.dart';

class PessoasPage extends StatelessWidget {
  const PessoasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              const Text(
                'Pessoas Compartilhadas',
                style: TextStyle(
                  color: Color(0xFF0A4DA1),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Pessoas que participam das suas viagens',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 18),
              // Lista de pessoas
              Expanded(
                child: ListView(
                  children: [
                    _buildPessoaCard(
                      iniciais: 'JS',
                      nome: 'João Silva',
                      viagens: '3 viagens',
                      tipo: 'Companheiro(a)',
                      email: 'joao@email.com',
                      telefone: '(11) 99999-9999',
                      ultimaViagem: 'França - Paris',
                    ),
                    _buildPessoaCard(
                      iniciais: 'MS',
                      nome: 'Maria Santos',
                      viagens: '2 viagens',
                      tipo: 'Companheiro(a)',
                      email: 'maria@email.com',
                      telefone: '(11) 99999-9999',
                      ultimaViagem: 'França - Paris',
                    ),
                    // Adicione mais cards conforme necessário
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 220,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0A4DA1),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(160, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.person_add),
                    label: const Text('Convidar Pessoa'),
                    onPressed: () {
                      // TODO: ação de convidar pessoa
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPessoaCard({
    required String iniciais,
    required String nome,
    required String viagens,
    required String tipo,
    required String email,
    required String telefone,
    required String ultimaViagem,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF0A4DA1),
                child: Text(
                  iniciais,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nome,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          viagens,
                          style: const TextStyle(
                            color: Color(0xFF0A4DA1),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFFEAF2FB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tipo,
                            style: const TextStyle(
                              color: Color(0xFF0A4DA1),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.email, color: Colors.black54, size: 18),
              const SizedBox(width: 6),
              Text(email, style: const TextStyle(color: Colors.black87, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.black54, size: 18),
              const SizedBox(width: 6),
              Text(telefone, style: const TextStyle(color: Colors.black87, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.black54, size: 18),
              const SizedBox(width: 6),
              const Text('Última viagem:', style: TextStyle(color: Colors.black54, fontSize: 13)),
              const SizedBox(width: 4),
              Text(ultimaViagem, style: const TextStyle(color: Colors.black87, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF0A4DA1),
                side: const BorderSide(color: Color(0xFF0A4DA1)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // TODO: ação de ver detalhes
              },
              child: const Text(
                'Ver Detalhes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
