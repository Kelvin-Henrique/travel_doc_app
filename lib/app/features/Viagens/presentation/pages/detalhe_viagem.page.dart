import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/features/Viagens/presentation/controllers/viagem.controller.dart';
import 'package:travel_doc_app/app/features/loader/presentation/pages/loader.view.dart';
import 'package:travel_doc_app/app/shared/widgets/success_animated_dialog.dart';

class DetalheViagemPage extends StatefulWidget {
  final dynamic viagem;
  const DetalheViagemPage({Key? key, required this.viagem}) : super(key: key);

  @override
  State<DetalheViagemPage> createState() => _DetalheViagemPageState();
}

class _DetalheViagemPageState extends State<DetalheViagemPage> {
  bool _loading = false;

  String _formatarData(dynamic data) {
    if (data == null) return '';
    try {
      final date = data is DateTime ? data : DateTime.parse(data.toString());
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataInicio = _formatarData(widget.viagem.dataInicio);
    final dataFim = _formatarData(widget.viagem.dataFim);
    final viagemController = locator<ViagemController>();

    return Loader(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Viagem', style: TextStyle(color: Colors.white),),
          backgroundColor: const Color(0xFF0A4DA1),
          foregroundColor: Colors.black,
          elevation: 0,
          leading: BackButton(color: Colors.white),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.viagem.nomeViagem ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Color(0xFF0A4DA1)),
                        const SizedBox(width: 4),
                        Text(widget.viagem.destino ?? '', style: const TextStyle(color: Color(0xFF0A4DA1))),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Text('$dataInicio - $dataFim', style: const TextStyle(color: Colors.black87)),
                        const SizedBox(width: 12),
                        const Icon(Icons.people, size: 16, color: Colors.black54),
                        const SizedBox(width: 4),
                        Text('1 pessoa', style: TextStyle(color: Colors.black87)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
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
                        const Text('Pessoas na Viagem (1)', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        
                      ],
                    ),
                    const SizedBox(height: 8),
                    /* ListTile(
                      leading: CircleAvatar(child: Text('MS')),
                      title: Text('Maria Santos'),
                      subtitle: Text('maria@email.com'),
                      trailing: OutlinedButton(onPressed: () {}, child: const Text('Espaço')),
                    ), */
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    const Expanded(child: Text('Documentos da Viagem (5)', style: TextStyle(fontWeight: FontWeight.bold))),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Adicionar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0A4DA1),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(40, 32),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    const Expanded(child: Text('Descrição da Viagem', style: TextStyle(fontWeight: FontWeight.bold))),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(widget.viagem.descricao ?? '', style: const TextStyle(color: Colors.black54)),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    const Expanded(child: Text('Informações do Carro Alugado', style: TextStyle(fontWeight: FontWeight.bold))),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    const Expanded(child: Text('Informações de Bagagem', style: TextStyle(fontWeight: FontWeight.bold))),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
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
