import 'package:flutter/material.dart';

class NovaViagemPage extends StatefulWidget {
  const NovaViagemPage({super.key});

  @override
  State<NovaViagemPage> createState() => _NovaViagemPageState();
}

class _NovaViagemPageState extends State<NovaViagemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _destinoController = TextEditingController();
  final _inicioController = TextEditingController();
  final _fimController = TextEditingController();
  final _descricaoController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _destinoController.dispose();
    _inicioController.dispose();
    _fimController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título e subtítulo
              const Text(
                'Nova Viagem',
                style: TextStyle(
                  color: Color(0xFF0A4DA1),
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Crie uma nova viagem e organize todos os detalhes',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 18),
              // Card de informações
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cabeçalho do card
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFF0A4DA1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.flight, color: Colors.white, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Informações da Viagem',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              'Preencha os dados básicos da sua viagem',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Formulário
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nomeController,
                            decoration: const InputDecoration(
                              labelText: 'Nome da viagem *',
                              hintText: 'Ex: Lua de mel em Paris',
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _destinoController,
                            decoration: const InputDecoration(
                              labelText: 'Destino *',
                              hintText: 'Ex: Paris, França',
                              border: OutlineInputBorder(),
                            ),
                            validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _inicioController,
                            decoration: const InputDecoration(
                              labelText: 'Data de início *',
                              hintText: 'dd/mm/aaaa',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today, size: 20),
                            ),
                            validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                            keyboardType: TextInputType.datetime,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _fimController,
                            decoration: const InputDecoration(
                              labelText: 'Data de fim *',
                              hintText: 'dd/mm/aaaa',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today, size: 20),
                            ),
                            validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                            keyboardType: TextInputType.datetime,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _descricaoController,
                            decoration: const InputDecoration(
                              labelText: 'Descrição (opcional)',
                              hintText: 'Conte mais sobre sua viagem...',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Card plano
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Color(0xFFEAF2FB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Seu Plano: Individual',
                            style: TextStyle(
                              color: Color(0xFF0A4DA1),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '• Até 5 viagens\n• Até 3 participantes por viagem',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Botões
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black54,
                            minimumSize: const Size(90, 40),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0A4DA1),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(110, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // TODO: Salvar viagem
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Criar Viagem'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
