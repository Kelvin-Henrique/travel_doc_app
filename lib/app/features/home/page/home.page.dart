import 'package:flutter/material.dart';
import 'package:travel_doc_app/app/core/helpers/shared-preferences.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/features/home/page/travel_bottom_navigation_bar.dart';
import 'package:travel_doc_app/app/features/Viagens/presentation/controllers/viagem.controller.dart';
import 'package:travel_doc_app/app/features/Viagens/presentation/pages/viagens.page.dart';
import 'package:travel_doc_app/app/features/home/page/documentos.page.dart';
import 'package:travel_doc_app/app/features/home/page/pessoas.page.dart';
import 'package:travel_doc_app/app/features/loader/presentation/pages/loader.view.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';
import 'package:travel_doc_app/app/features/perfil/page/perfil.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey _avatarKey = GlobalKey();
  final ScrollController _viagemScrollController = ScrollController();
  final ScrollController _historicoScrollController = ScrollController();

  bool _viagensExpanded = true;
  bool _historicoExpanded = false;

  UsuarioModel? _usuario;
  final _viagemController = locator<ViagemController>();
  List _viagens = [];
  bool _carregandoViagens = false;

  @override
  void initState() {
    super.initState();
    _loadUsuario();
    _carregarViagensHome();
  }

  void _loadUsuario() async {
    final usuario = await SharedPreferencesHelper.getClient();
    setState(() {
      _usuario = usuario;
    });
  }

  void _carregarViagensHome() async {
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = 0;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedIndex = index;
        if (index == 0) {
          _carregarViagensHome();
        }
        if (index == 1) {
          ViagensPage.globalKey.currentState?.recarregarViagens();
        }
      });
    });
  }

  String _getInitials(String? nome) {
    if (nome == null || nome.trim().isEmpty) return '';
    final parts = nome.trim().split(' ');
    if (parts.length == 1) {
      return parts[0].substring(0, 1).toUpperCase();
    }
    return (parts[0].substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  void _showProfileMenu(BuildContext context) {
    final RenderBox renderBox = _avatarKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height + 8,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_usuario?.nome ?? 'Nome do Usuário', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
              Text(_usuario?.email ?? 'Email do Usuário', style: TextStyle(color: Colors.black54, fontSize: 13)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text('Plano:', style: TextStyle(color: Colors.black54, fontSize: 13)),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAF2FB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Individual',
                      style: TextStyle(
                        color: Color(0xFF0A4DA1),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 18),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.settings, size: 20, color: Colors.black),
                title: const Text('Perfil', style: TextStyle(fontSize: 14, color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PerfilPage(usuario: _usuario)),
                  );
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.credit_card, size: 20, color: Colors.black),
                title: const Text('Planos', style: TextStyle(fontSize: 14, color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout, size: 20, color: Colors.black54),
                title: const Text('Sair', style: TextStyle(fontSize: 14)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  void _abrirModalDocumento(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _nomeController = TextEditingController();
    String? _tipoSelecionado;
    String _arquivoNome = 'Nenhum arquivo escolhido';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Adicionar Novo Documento',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
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
                          labelText: 'Nome do documento',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 14),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Tipo',
                          border: OutlineInputBorder(),
                        ),
                        value: _tipoSelecionado,
                        items: [
                          DropdownMenuItem(value: null, child: Text('Selecione o tipo')),
                          DropdownMenuItem(value: 'Passaporte', child: Text('Passaporte')),
                          DropdownMenuItem(value: 'Visto', child: Text('Visto')),
                          DropdownMenuItem(value: 'Seguro', child: Text('Seguro')),
                          DropdownMenuItem(value: 'Outro', child: Text('Outro')),
                        ],
                        onChanged: (value) {
                          _tipoSelecionado = value;
                        },
                        validator: (v) => v == null ? 'Selecione o tipo' : null,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0A4DA1),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(40, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                            },
                            child: const Text('Escolher arquivo'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _arquivoNome,
                              style: const TextStyle(color: Colors.black54, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0A4DA1),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(160, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Adicionar Documento'),
                        ),
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
  }

  @override
  void dispose() {
    _viagemScrollController.dispose();
    _historicoScrollController.dispose();
    super.dispose();
  }

  String _formatarData(dynamic data) {
    if (data == null) return '';
    try {
      final date = data is DateTime ? data : DateTime.parse(data.toString());
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Loader(
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          color: Colors.white,
          child: SafeArea(
            child: Row(
              children: [
                Image.asset(
                  'assets/images/travel_doc_logo.png',
                  width: 90,
                  height: 90,
                  fit: BoxFit.contain,
                ),
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
                GestureDetector(
                  key: _avatarKey,
                  onTap: () => _showProfileMenu(context),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      _getInitials(_usuario?.nome),
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: _viagensExpanded,
                      onExpansionChanged: (expanded) {
                        setState(() => _viagensExpanded = expanded);
                      },
                      tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                      childrenPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      title: Row(
                        children: [
                          const Text(
                            'Próximas Viagens',
                            style: TextStyle(
                              color: Color(0xFF0A4DA1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        _viagensExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Color(0xFF0A4DA1),
                      ),
                      children: [
                        _carregandoViagens
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 32),
                                child: Center(child: CircularProgressIndicator()),
                              )
                            : (_viagens.isEmpty
                                ? const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Center(
                                      child: Text(
                                        'Nenhuma viagem encontrada.',
                                        style: TextStyle(color: Colors.black54, fontSize: 15),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 260,
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      controller: _viagemScrollController,
                                      child: ListView.builder(
                                        controller: _viagemScrollController,
                                        itemCount: _viagens.length,
                                        itemBuilder: (context, index) {
                                          final viagem = _viagens[index];
                                          final dataInicio = _formatarData(viagem.dataInicio);
                                          final dataFim = _formatarData(viagem.dataFim);
                                          return Container(
                                            margin: const EdgeInsets.only(bottom: 12),
                                            child: _buildViagemCard(
                                              local: viagem.destino ?? '',
                                              tipo: viagem.nomeViagem ?? '',
                                              tags: ['Criada por mim'],
                                              periodo: '$dataInicio - $dataFim',
                                              participantes: '1 participante',
                                              documentos: '0 documento(s)',
                                              descricao: viagem.descricao ?? '',
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )),
                        const SizedBox(height: 6),
                        if (!_carregandoViagens)
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: _historicoExpanded,
                      onExpansionChanged: (expanded) {
                        setState(() => _historicoExpanded = expanded);
                      },
                      tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                      childrenPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      title: const Text(
                        'Histórico de Viagens',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      trailing: Icon(
                        _historicoExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Colors.black54,
                      ),
                      children: [
                        Container(
                          height: 180,
                          child: Scrollbar(
                            thumbVisibility: true,
                            controller: _historicoScrollController,
                            child: ListView(
                              controller: _historicoScrollController,
                              children: [
                                _buildHistoricoCard(
                                  local: 'Brasil - São Paulo',
                                  tipo: 'Reunião de trabalho',
                                  tags: ['Criada por mim', 'Concluída'],
                                  periodo: '28/02/2023 - 04/03/2023',
                                  participantes: '1 participante(s) (João Silva)',
                                  documentos: '2 documento(s)',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
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
          ViagensPage(key: ViagensPage.globalKey),
          Container(),
          const DocumentosPage(),
          const PessoasPage(),
        ],
      ),
      bottomNavigationBar: TravelBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 2) {
            _abrirModalDocumento(context);
          } else {
            _onItemTapped(index);
          }
        },
      ),
    ));
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
                ));
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

  Widget _buildHistoricoCard({
    required String local,
    required String tipo,
    required List<String> tags,
    required String periodo,
    required String participantes,
    required String documentos,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.black54, size: 18),
              const SizedBox(width: 4),
              Text(
                local,
                style: const TextStyle(
                  color: Colors.black87,
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
              final isDone = tag == 'Concluída';
              return Container(
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isDone ? Colors.grey[300] : Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: isDone ? Colors.black54 : Color(0xFF0A4DA1),
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ));
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
              Text(participantes, style: TextStyle(color: Colors.black87, fontSize: 13, decoration: TextDecoration.underline)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.description, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(documentos, style: TextStyle(color: Colors.black87, fontSize: 13, decoration: TextDecoration.underline)),
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
          image: AssetImage('assets/images/oferta_bg.jpg'),
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
}