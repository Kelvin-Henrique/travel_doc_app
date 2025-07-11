import 'dart:async';
import 'package:flutter/material.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _senhaVisivel = false;

  // --- LÓGICA PARA O BACKGROUND DINÂMICO ---
  final List<String> _backgroundImages = [
    'assets/images/img_home.jpg', // Certifique-se que esta imagem existe
    'assets/images/img_home2.jpg', // Certifique-se que esta imagem existe
  ];
  int _currentBackgroundImageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Inicia o timer para trocar a imagem de fundo a cada 5 segundos
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _currentBackgroundImageIndex =
              (_currentBackgroundImageIndex + 1) % _backgroundImages.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    _timer?.cancel(); // Cancela o timer para evitar memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // --- BACKGROUND DINÂMICO ---
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Image.asset(
              _backgroundImages[_currentBackgroundImageIndex],
              key: ValueKey<int>(_currentBackgroundImageIndex),
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          // Overlay escuro para melhorar a legibilidade
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // --- CONTEÚDO PRINCIPAL (FORMULÁRIO) ---
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Image.asset(
                      'assets/images/logoIva.png',
                      fit: BoxFit.contain,
                      height: 60.0,
                      color: Colors.yellow,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Crie sua conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Container do formulário
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: <Widget>[
                          _buildTextField(
                            controller: _nomeController,
                            hintText: 'Nome completo',
                            icon: Icons.person,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          _buildTextField(
                            controller: _telefoneController,
                            hintText: 'Telefone',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 20),
                          _buildPasswordField(),
                          const SizedBox(height: 24),

                          // Botão de Cadastrar
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implementar lógica de cadastro
                              // Validar se a senha tem 8 dígitos, etc.
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Text(
                              'CADASTRAR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- SEÇÃO DE LOGIN ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Já tem uma conta?',
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            // Volta para a tela de login
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6)),
                          child: const Text(
                            'Entre',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget para o campo de senha
  Widget _buildPasswordField() {
    return TextField(
      obscureText: !_senhaVisivel,
      controller: _senhaController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Senha (mínimo 8 dígitos)',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(Icons.lock, color: Colors.yellow.shade700),
        suffixIcon: IconButton(
          icon: Icon(
            _senhaVisivel ? Icons.visibility : Icons.visibility_off,
            color: Colors.yellow.shade700,
          ),
          onPressed: () {
            setState(() {
              _senhaVisivel = !_senhaVisivel;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.yellow.shade700, width: 2),
        ),
      ),
    );
  }

  // Widget genérico para os campos de texto
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(icon, color: Colors.yellow.shade700),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.yellow.shade700, width: 2),
        ),
      ),
    );
  }
}
