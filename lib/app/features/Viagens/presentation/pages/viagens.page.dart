import 'package:flutter/material.dart';
import 'package:travel_doc_app/app/core/helpers/shared-preferences.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/features/Viagens/presentation/controllers/viagem.controller.dart';
import 'package:travel_doc_app/app/features/Viagens/presentation/pages/nova_viagem.page.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';
import 'package:travel_doc_app/app/features/pais/presentation/controllers/pais.controller.dart';
import 'package:travel_doc_app/app/features/pais/data/models/pais.model.dart';
import 'package:intl/intl.dart';
import 'package:travel_doc_app/app/features/Viagens/domain/enums/status_viagem_enum.dart';
import 'package:travel_doc_app/app/features/Viagens/presentation/pages/detalhe_viagem.page.dart';

class ViagensPage extends StatefulWidget {
  const ViagensPage({super.key});
  static final GlobalKey<_ViagensPageState> globalKey = GlobalKey<_ViagensPageState>();
  @override
  State<ViagensPage> createState() => _ViagensPageState();
}

class _ViagensPageState extends State<ViagensPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _viagemController = locator<ViagemController>();
  final _paisController = locator<PaisController>();
  late UsuarioModel _usuario;
  PaisModel? _paisSelecionado;
  List<PaisModel> _listaPaises = [];
  bool _carregandoPaises = false;
  List _viagens = [];
  bool _carregandoViagens = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    SharedPreferencesHelper.getClient().then((user) {
      setState(() {
        _usuario = user;
      });
      _carregarViagens();
    });
    _carregarPaises();
  }

  void _carregarPaises() async {
    setState(() {
      _carregandoPaises = true;
    });
    try {
      final paises = await _paisController.buscarPaisesAsync();
      paises.sort((a, b) => a.nome.compareTo(b.nome));
      setState(() {
        _listaPaises = paises;
      });
    } catch (_) {
    } finally {
      setState(() {
        _carregandoPaises = false;
      });
    }
  }

  void _carregarViagens() async {
    setState(() {
      _carregandoViagens = true;
    });
    try {
      final viagens = await _viagemController.obterViagensPorUsuarioIdAsync();
      setState(() {
        _viagens = viagens;
      });
    } catch (_) {
    } finally {
      setState(() {
        _carregandoViagens = false;
      });
    }
  }

  String _formatarData(dynamic data) {
    if (data == null) return '';
    try {
      final date = data is DateTime ? data : DateTime.parse(data.toString());
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return '';
    }
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

  void abrirNovaViagemPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => NovaViagemPage(
          usuario: _usuario,
          viagemController: _viagemController,
        ),
      ),
    );
  }

  void recarregarViagens() {
    _carregarViagens();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    // Aba "Viagens Atuais"
                    _carregandoViagens
                        ? const Center(child: CircularProgressIndicator())
                        : Builder(
                            builder: (context) {
                              // Mostre apenas viagens NÃO finalizadas
                              final viagensAtuais = _viagens.where((viagem) => viagem.status != StatusViagemEnum.finalizada.numero).toList();
                              if (viagensAtuais.isEmpty) {
                                return Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 32, bottom: 16),
                                      child: Text(
                                        'Nenhuma viagem encontrada.',
                                        style: TextStyle(color: Colors.black54, fontSize: 15),
                                      ),
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
                                          abrirNovaViagemPage(context);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return ListView.builder(
                                itemCount: viagensAtuais.length,
                                itemBuilder: (context, index) {
                                  final viagem = viagensAtuais[index];
                                  final dataInicio = _formatarData(viagem.dataInicio);
                                  final dataFim = _formatarData(viagem.dataFim);

                                  String statusDescricao = '';
                                  if (viagem.status != null) {
                                    try {
                                      final statusEnum = StatusViagemEnum.values.firstWhere(
                                        (e) => e.numero == viagem.status,
                                        orElse: () => StatusViagemEnum.planejada,
                                      );
                                      statusDescricao = statusEnum.descricao;
                                    } catch (_) {
                                      statusDescricao = '';
                                    }
                                  }

                                  return GestureDetector(
                                    onTap: () => _abrirDetalheViagemPage(context, viagem),
                                    child: _buildViagemCard(
                                      titulo: viagem.nomeViagem ?? '',
                                      local: viagem.destino,
                                      periodo: '$dataInicio - $dataFim',
                                      participantes: _usuario.nome,
                                      descricao: viagem.descricao ?? '',
                                      status: statusDescricao,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                    // Aba "Histórico"
                    _carregandoViagens
                        ? const Center(child: CircularProgressIndicator())
                        : Builder(
                            builder: (context) {
                              final historicoViagens = _viagens.where((viagem) => viagem.status == StatusViagemEnum.finalizada.numero).toList();
                              if (historicoViagens.isEmpty) {
                                return Center(
                                  child: Text(
                                    'Nenhuma viagem finalizada.',
                                    style: TextStyle(color: Colors.black54, fontSize: 15),
                                  ),
                                );
                              }
                              return ListView.builder(
                                itemCount: historicoViagens.length,
                                itemBuilder: (context, index) {
                                  final viagem = historicoViagens[index];
                                  final dataInicio = _formatarData(viagem.dataInicio);
                                  final dataFim = _formatarData(viagem.dataFim);
                                  String statusDescricao = '';
                                  if (viagem.status != null) {
                                    try {
                                      final statusEnum = StatusViagemEnum.values.firstWhere(
                                        (e) => e.numero == viagem.status,
                                        orElse: () => StatusViagemEnum.finalizada,
                                      );
                                      statusDescricao = statusEnum.descricao;
                                    } catch (_) {
                                      statusDescricao = '';
                                    }
                                  }
                                  return GestureDetector(
                                    onTap: () => _abrirDetalheViagemPage(context, viagem),
                                    child: _buildViagemCard(
                                      titulo: viagem.nomeViagem ?? '',
                                      local: viagem.destino,
                                      periodo: '$dataInicio - $dataFim',
                                      participantes: _usuario.nome,
                                      descricao: viagem.descricao ?? '',
                                      status: statusDescricao,
                                    ),
                                  );
                                },
                              );
                            },
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

  void _abrirDetalheViagemPage(BuildContext context, dynamic viagem) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetalheViagemPage(viagem: viagem),
      ),
    );
  }
}