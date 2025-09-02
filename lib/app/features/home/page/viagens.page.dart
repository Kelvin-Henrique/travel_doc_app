import 'package:flutter/material.dart';
import 'package:travel_doc_app/app/features/home/page/nova_viagem.page.dart';

class ViagensPage extends StatefulWidget {
  const ViagensPage({super.key});

  @override
  State<ViagensPage> createState() => _ViagensPageState();
}

class _ViagensPageState extends State<ViagensPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildViagemCard({
    required String titulo,
    required String local,
    required String periodo,
    required String participantes,
    required String descricao,
    required String status,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFEAF2FB),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Color(0xFF0A4DA1),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Color(0xFF0A4DA1)),
              const SizedBox(width: 4),
              Text(
                local,
                style: const TextStyle(
                  color: Color(0xFF0A4DA1),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                periodo,
                style: const TextStyle(color: Colors.black87, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.people, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(
                participantes,
                style: const TextStyle(color: Colors.black87, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            descricao,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ],
      ),
    );
  }

  void _abrirModalNovaViagem(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nomeController = TextEditingController();
    final _destinoController = TextEditingController();
    final _inicioController = TextEditingController();
    final _fimController = TextEditingController();
    final _descricaoController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 18,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Container(
                      width: constraints.maxWidth,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                              Expanded(
                                child: Column(
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
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
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
            );
          },
        );
      },
    );
  }

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
                'Minhas Viagens',
                style: TextStyle(
                  color: Color(0xFF0A4DA1),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Gerencie todas as suas viagens',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 18),
              // Tabs
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Color(0xFF0A4DA1),
                  unselectedLabelColor: Colors.black54,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  tabs: const [
                    Tab(child: Align(alignment: Alignment.center, child: Text('Viagens Atuais'))),
                    Tab(child: Align(alignment: Alignment.center, child: Text('Histórico'))),
                  ],
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Viagens Atuais
                    ListView(
                      children: [
                        _buildViagemCard(
                          titulo: 'Lua de mel',
                          local: 'França - Paris',
                          periodo: '14/09/2025 - 21/09/2025',
                          participantes: '2 viajantes',
                          descricao: 'Lua de mel em Paris',
                          status: 'Planejada',
                        ),
                        _buildViagemCard(
                          titulo: 'Disney com as crianças',
                          local: 'EUA - Orlando',
                          periodo: '09/12/2025 - 19/12/2025',
                          participantes: '1 viajante',
                          descricao: 'Disney com as crianças',
                          status: 'Planejada',
                        ),
                        _buildViagemCard(
                          titulo: 'Viagem de negócios',
                          local: 'Portugal - Lisboa',
                          periodo: '29/08/2025 - 04/09/2025',
                          participantes: '1 viajante',
                          descricao: 'Conferência internacional',
                          status: 'Planejada',
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0A4DA1),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(160, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: const Icon(Icons.add),
                            label: const Text('Nova Viagem'),
                            onPressed: () {
                              _abrirModalNovaViagem(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    // Histórico
                    Center(
                      child: Text(
                        'Nenhuma viagem finalizada.',
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
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
