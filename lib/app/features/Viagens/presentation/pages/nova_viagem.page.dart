import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:travel_doc_app/app/features/Viagens/data/models/cadastro-viagem.request.dart';
import 'package:travel_doc_app/app/features/Viagens/presentation/controllers/viagem.controller.dart';
import 'package:travel_doc_app/app/features/loader/presentation/pages/loader.view.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';
import 'package:travel_doc_app/app/features/pais/data/models/pais.model.dart';
import 'package:travel_doc_app/app/features/pais/presentation/controllers/pais.controller.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';

class NovaViagemPage extends StatefulWidget {
  final UsuarioModel usuario;
  final ViagemController viagemController;

  const NovaViagemPage({
    Key? key,
    required this.usuario,
    required this.viagemController,
  }) : super(key: key);

  @override
  State<NovaViagemPage> createState() => _NovaViagemPageState();
}

class _NovaViagemPageState extends State<NovaViagemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  PaisModel? paisSelecionadoModal;

  DateTime? _dataInicio;
  DateTime? _dataFim;

  final _paisController = locator<PaisController>();
  List<PaisModel> _listaPaises = [];
  bool _carregandoPaises = false;

  @override
  void initState() {
    super.initState();
    _carregarPaises();
    _nomeController.addListener(_onFormChanged);
    _descricaoController.addListener(_onFormChanged);
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
      // erro silencioso
    } finally {
      setState(() {
        _carregandoPaises = false;
      });
    }
  }

  bool get _formValido =>
      _nomeController.text.isNotEmpty &&
      paisSelecionadoModal != null &&
      _dataInicio != null &&
      _dataFim != null;

  void _onFormChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _nomeController.removeListener(_onFormChanged);
    _descricaoController.removeListener(_onFormChanged);
    _nomeController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Loader(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nova Viagem', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF0A4DA1),
          leading: BackButton(color: Colors.white),
        ),
        body: _carregandoPaises
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Crie uma nova viagem e organize todos os detalhes',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 18),
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
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0A4DA1),
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
                                  DropdownButtonFormField<PaisModel>(
                                    value: paisSelecionadoModal,
                                    decoration: const InputDecoration(
                                      labelText: 'Destino *',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: _listaPaises.map((pais) {
                                      return DropdownMenuItem<PaisModel>(
                                        value: pais,
                                        child: SizedBox(
                                          width: 160,
                                          child: Row(
                                            children: [
                                              Image.network(
                                                pais.bandeiraUrl,
                                                width: 18,
                                                height: 14,
                                                errorBuilder: (_, __, ___) => const SizedBox(width: 18, height: 14),
                                              ),
                                              const SizedBox(width: 6),
                                              Flexible(
                                                child: Text(
                                                  pais.nome, // Apenas o nome do país
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: const TextStyle(fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (pais) {
                                      setState(() {
                                        paisSelecionadoModal = pais;
                                      });
                                    },
                                    validator: (v) => v == null ? 'Selecione o destino' : null,
                                  ),
                                  const SizedBox(height: 14),
                                  DateTimeFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Data de início *',
                                      hintText: 'Selecione a data',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.calendar_today, size: 20),
                                    ),
                                    mode: DateTimeFieldPickerMode.date,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                    validator: (v) => v == null ? 'Campo obrigatório' : null,
                                    onChanged: (date) {
                                      setState(() {
                                        _dataInicio = date;
                                      });
                                    },
                                    dateFormat: DateFormat('dd-MM-yyyy'),
                                  ),
                                  const SizedBox(height: 14),
                                  DateTimeFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Data de fim *',
                                      hintText: 'Selecione a data',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.calendar_today, size: 20),
                                    ),
                                    mode: DateTimeFieldPickerMode.date,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                    validator: (v) => v == null ? 'Campo obrigatório' : null,
                                    onChanged: (date) {
                                      setState(() {
                                        _dataFim = date;
                                      });
                                    },
                                    dateFormat: DateFormat('dd-MM-yyyy'),
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
                                color: const Color(0xFFEAF2FB),
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
                                    backgroundColor: const Color(0xFF0A4DA1),
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(110, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: _formValido
                                      ? () {
                                          if (_formKey.currentState?.validate() ?? false) {
                                            try {
                                              final inicio = _dataInicio!;
                                              final fim = _dataFim!;
                                              widget.viagemController.cadastrarViagemAsync(
                                                CadastroViagemRequest(
                                                  usuarioId: widget.usuario.id ?? 0,
                                                  nomeViagem: _nomeController.text,
                                                  destino: paisSelecionadoModal != null
                                                      ? '${paisSelecionadoModal!.capital}, ${paisSelecionadoModal!.nome}'
                                                      : '',
                                                  dataInicio: inicio,
                                                  dataFim: fim,
                                                  descricao: _descricaoController.text,
                                                ),
                                              ).then((_) {
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text('Viagem criada com sucesso!')),
                                                );
                                              }).catchError((error) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('Erro ao criar viagem: $error')),
                                                );
                                              });
                                            } catch (e) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text('Formato de data inválido! Use yyyy-MM-dd')),
                                              );
                                            }
                                          }
                                        }
                                      : null,
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
            ),
      );
  }
}
