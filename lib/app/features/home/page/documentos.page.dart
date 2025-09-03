import 'package:flutter/material.dart';

class DocumentosPage extends StatelessWidget {
  const DocumentosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                const Text(
                  'Meus Documentos',
                  style: TextStyle(
                    color: Color(0xFF0A4DA1),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Gerencie seus documentos pessoais',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 18),
                // Busca
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscar documentos...',
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
                const SizedBox(height: 10),
                // Filtro
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'Todos os tipos',
                      items: const [
                        DropdownMenuItem(value: 'Todos os tipos', child: Text('Todos os tipos')),
                        DropdownMenuItem(value: 'RG', child: Text('RG')),
                        DropdownMenuItem(value: 'Passaporte', child: Text('Passaporte')),
                        DropdownMenuItem(value: 'Visto', child: Text('Visto')),
                        DropdownMenuItem(value: 'Seguro', child: Text('Seguro')),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                // Documentos Pessoais
                const Text(
                  'Documentos Pessoais',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                // Lista de documentos pessoais
                _buildDocumentosPessoaisList(),
                const SizedBox(height: 18),
                // Documentos de Viagem
                const Text(
                  'Documentos de Viagem',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: 10),
                _buildViagemDocumentoCard(context),
                const SizedBox(height: 10),
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
                      icon: const Icon(Icons.add),
                      label: const Text('Adicionar Documento'),
                      onPressed: () {
                        _abrirModalDocumento(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                              // TODO: Implementar seleção de arquivo
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
                              // TODO: Salvar documento
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

  Widget _buildDocumentosPessoaisList() {
    return Column(
      children: [
        _buildDocumentoCard(
          titulo: 'RG João Silva',
          tipo: 'RG',
          data: 'Adicionado em 14/01/2024',
          arquivo: 'PDF',
          corTipo: Colors.blue[100],
          corTipoTexto: Color(0xFF0A4DA1),
        ),
        _buildDocumentoCard(
          titulo: 'Passaporte João Silva',
          tipo: 'Passaporte',
          data: 'Adicionado em 15/01/2024',
          arquivo: 'PDF',
          corTipo: Colors.purple[100],
          corTipoTexto: Colors.purple,
        ),
        // Adicione mais cards conforme necessário
      ],
    );
  }

  Widget _buildDocumentoCard({
    required String titulo,
    required String tipo,
    required String data,
    required String arquivo,
    required Color? corTipo,
    required Color corTipoTexto,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
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
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: corTipo,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tipo,
                  style: TextStyle(
                    color: corTipoTexto,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            data,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.picture_as_pdf, color: Colors.black54, size: 20),
              const SizedBox(width: 6),
              Text(
                arquivo,
                style: const TextStyle(color: Colors.black87, fontSize: 14),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.download, color: Color(0xFF0A4DA1), size: 22),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.black38, size: 22),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViagemDocumentoCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color(0xFF0A4DA1), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título da viagem
            Row(
              children: [
                const Icon(Icons.flight, color: Color(0xFF0A4DA1), size: 20),
                const SizedBox(width: 6),
                const Text(
                  'Lua de mel',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '14/09/2025',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              'França - Paris · 1 documento(s)',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 10),
            // Card do documento
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[200]!),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Passagem Paris',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Passagem',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Passagem',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.comment, color: Colors.black54, size: 18),
                      const SizedBox(width: 4),
                      const Text(
                        'Comentários',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black38, size: 18),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 2, bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: const Text(
                      'Voo direto com escala em Madrid. Embarque às 14h30.',
                      style: TextStyle(color: Colors.black87, fontSize: 13),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.black54, size: 16),
                      const SizedBox(width: 4),
                      const Text(
                        '31/01/2024',
                        style: TextStyle(color: Colors.black87, fontSize: 13),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.download, color: Color(0xFF0A4DA1), size: 20),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.black38, size: 20),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
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
  }
}
