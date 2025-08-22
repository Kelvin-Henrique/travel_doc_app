import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travel_doc_app/app/features/login/presentation/pages/cadastro.view.dart';
import 'package:provider/provider.dart';

// Certifique-se de que o caminho para o seu ThemeProvider está correto.
// Se o arquivo estiver em lib/app/core/providers/theme_provider.dart,
// o import abaixo deve funcionar.
import 'package:travel_doc_app/app/core/providers/theme_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _passwordVisible = false;

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
    _passwordController.dispose();
    _emailController.dispose();
    _timer?.cancel(); // Cancela o timer para evitar memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // --- BACKGROUND DINÂMICO ---
          // Anima a transição entre as imagens de fundo
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Image.asset(
              _backgroundImages[_currentBackgroundImageIndex],
              // Usa a key para o AnimatedSwitcher identificar a mudança de widget
              key: ValueKey<int>(_currentBackgroundImageIndex),
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
            ),
          ),
          // Overlay escuro para melhorar a legibilidade do conteúdo
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          // --- CONTEÚDO PRINCIPAL (FORMULÁRIO) ---
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Espaçamento no topo
                    SizedBox(height: size.height * 0.15),

                    // Logo da aplicação
                    Image.asset(
                      'assets/images/logoIva.png',
                      fit: BoxFit.contain,
                      height: 80.0,
                      // Cor amarela para contrastar com o fundo escuro
                      color: Colors.yellow,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Bem-vindo(a) de volta!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Container do formulário com fundo translúcido
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.2))),
                      child: Column(
                        children: <Widget>[
                          // Campo de Email
                          _buildTextField(
                            controller: _emailController,
                            hintText: 'Email',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          // Campo de Senha
                          _buildPasswordField(),
                          const SizedBox(height: 24),

                          // Botão de Entrar
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implementar lógica de login
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
                              'ENTRAR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {
                              // TODO: Implementar recuperação de senha
                            },
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: Colors.yellow.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // --- SEÇÃO DE CADASTRO ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Ainda não possui uma conta?',
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CadastroView(),
                              ),
                            );
                          },
                          style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6)),
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Espaçamento inferior
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget refatorado para o campo de senha.
  // As cores agora são fixas para combinar com o fundo escuro.
  Widget _buildPasswordField() {
    return TextField(
      obscureText: !_passwordVisible,
      controller: _passwordController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Senha',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(Icons.lock, color: Colors.yellow.shade700),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.yellow.shade700,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
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

  // Widget refatorado para campos de texto genéricos.
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
