import 'package:flutter/material.dart';
import 'package:travel_doc_app/app/core/locator/locator.dart';
import 'package:travel_doc_app/app/features/loader/presentation/pages/loader.view.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario-cadastro-request.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/data/models/usuario.model.dart';
import 'package:travel_doc_app/app/features/usuario-cadastro/presentation/controllers/usuario-cadastro.controller.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:travel_doc_app/app/shared/widgets/success_animated_dialog.dart';

class PerfilPage extends StatefulWidget {
  final UsuarioModel? usuario;

  const PerfilPage({super.key, required this.usuario});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _cadastroUsuarioController = locator<UsuarioCadastroController>();
  late final TextEditingController _telefoneController;

  bool _todosPreenchidos = false;

  void _verificarCamposPreenchidos() {
    setState(() {
      _todosPreenchidos =
        (widget.usuario?.nome ?? '').trim().isNotEmpty &&
        (widget.usuario?.email ?? '').trim().isNotEmpty &&
        _telefoneController.text.trim().isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    String telefone = widget.usuario?.telefone ?? '';
    if (telefone.isNotEmpty) {
      telefone = PhoneInputFormatter(
        allowEndlessPhone: false,
        defaultCountryCode: 'BR',
      ).formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(text: telefone),
      ).text;
    }
    _telefoneController = TextEditingController(
      text: telefone,
    );
    _telefoneController.addListener(_verificarCamposPreenchidos);
    _verificarCamposPreenchidos();
  }

  @override
  void dispose() {
    _telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Loader(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: BackButton(color: Colors.black87),
          title: const Text(
            'Perfil',
            style: TextStyle(
              color: Color(0xFF0A4DA1),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              // Avatar e nome
              Column(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.grey[200],
                    child: Text(
                      (widget.usuario?.nome != null && widget.usuario!.nome.trim().isNotEmpty)
                          ? (widget.usuario!.nome.trim().split(' ').length == 1
                              ? widget.usuario!.nome.trim().substring(0, 1).toUpperCase()
                              : (widget.usuario!.nome.trim().split(' ')[0].substring(0, 1) +
                                  widget.usuario!.nome.trim().split(' ').last.substring(0, 1)).toUpperCase())
                          : '',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.usuario?.nome ?? 'Nome do Usuário',
                    style: const TextStyle(
                      color: Color(0xFF0A4DA1),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    widget.usuario?.email ?? 'Email do Usuário',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAF2FB),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Plano Individual',
                      style: TextStyle(
                        color: Color(0xFF0A4DA1),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Informações Pessoais
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informações Pessoais',
                        style: TextStyle(
                          color: Color(0xFF0A4DA1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        initialValue: widget.usuario?.nome ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Nome completo',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: (_) => _verificarCamposPreenchidos(),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: widget.usuario?.email ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onChanged: (_) => _verificarCamposPreenchidos(),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _telefoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          PhoneInputFormatter(
                            allowEndlessPhone: false,
                            defaultCountryCode: 'BR',
                          ),
                        ],
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0A4DA1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: _todosPreenchidos
                              ? () async {
                                  var dadosAtualizacao = UsuarioCadastroRequest(
                                    id: widget.usuario?.id,
                                    nome: widget.usuario?.nome ?? '',
                                    email: widget.usuario?.email ?? '',
                                    telefone: toNumericString(_telefoneController.text),
                                    cpf: widget.usuario?.cpf ?? '',
                                    tipo: widget.usuario?.tipo ?? 0,
                                  );

                                  try {
                                    await _cadastroUsuarioController.atualizarCadastroAsync(dadosAtualizacao);
                                    await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => const SuccessAnimatedDialog(
                                        message: 'Cadastro atualizado com sucesso!',
                                      ),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Erro ao atualizar cadastro: $e')),
                                    );
                                  }
                                }
                              : null,
                          child: const Text('Salvar Alterações'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Plano Atual
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Plano Atual',
                        style: TextStyle(
                          color: Color(0xFF0A4DA1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Plano Individual',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xFFEAF2FB),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Ativo',
                              style: TextStyle(
                                color: Color(0xFF0A4DA1),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Renovação automática',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF0A4DA1),
                            side: BorderSide(color: Color(0xFF0A4DA1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Alterar Plano'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Notificações',
                        style: TextStyle(
                          color: Color(0xFF0A4DA1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      CheckboxListTile(
                        value: true,
                        onChanged: (v) {},
                        title: const Text('Notificações por email'),
                        subtitle: const Text('Receba atualizações sobre suas viagens'),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      CheckboxListTile(
                        value: false,
                        onChanged: (v) {},
                        title: const Text('Notificações push'),
                        subtitle: const Text('Receba lembretes importantes'),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Segurança',
                        style: TextStyle(
                          color: Color(0xFF0A4DA1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Alterar senha'),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF0A4DA1),
                              side: BorderSide(color: Color(0xFF0A4DA1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Alterar'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Última alteração há 3 meses',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Autenticação em dois fatores'),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Color(0xFF0A4DA1),
                              side: BorderSide(color: Color(0xFF0A4DA1)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Ativar'),
                          ),
                        ],
                      ),
                      const Text(
                        'Proteção adicional para sua conta',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              // Zona de Perigo
              Card(
                color: Colors.red[50],
                margin: const EdgeInsets.only(bottom: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Zona de Perigo',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ações irreversíveis que afetam sua conta',
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Excluir conta',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('Excluir Conta'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Exclui permanentemente sua conta e todos os dados.',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
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
