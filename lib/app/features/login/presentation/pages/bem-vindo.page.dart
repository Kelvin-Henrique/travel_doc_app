import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iva_app/app/core/providers/theme_provider.dart';
import 'package:iva_app/app/features/home/page/home.page.dart';
import 'package:iva_app/app/features/login/presentation/pages/login.view.dart';

// O widget de animação para os botões. Nenhuma alteração necessária aqui.
class SlideInButton extends StatefulWidget {
  final Widget child;
  final double delay;
  final Duration duration;

  const SlideInButton({
    super.key,
    required this.child,
    this.delay = 0.0,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  _SlideInButtonState createState() => _SlideInButtonState();
}

class _SlideInButtonState extends State<SlideInButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: widget.duration, vsync: this);

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(curvedAnimation);

    // Adiciona um atraso para a animação iniciar
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

// A página de Boas-Vindas, agora com o layout unificado.
class BemVindoPage extends StatefulWidget {
  final List<String> welcomeMessages = [
    "Olá,",
    "seja bem-vindo",
  ];

  BemVindoPage({super.key});

  @override
  _BemVindoPageState createState() => _BemVindoPageState();
}

class _BemVindoPageState extends State<BemVindoPage> {
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
    _timer?.cancel(); // Cancela o timer corretamente para evitar memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // --- BACKGROUND DINÂMICO UNIFICADO ---
          // Anima a transição entre as imagens de fundo
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
          // Overlay escuro para melhorar a legibilidade, igual à tela de login
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo com tamanho ajustado
                  Image.asset(
                    'assets/images/logo.png', // Verifique se é o mesmo logo da tela de login
                    color: Colors.yellow,
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  // Texto animado
                  TypewriterAnimatedTextKit(
                    speed: const Duration(milliseconds: 100),
                    totalRepeatCount: 1,
                    text: widget.welcomeMessages,
                    textStyle: const TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  // Botão primário
                  SlideInButton(
                    delay: 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(220, 50),
                      ),
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botão secundário para a área de voluntários/login
                  SlideInButton(
                    delay: 1.0,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.yellow, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(220, 50),
                      ),
                      child: const Text(
                        'ÁREA DO VOLUNTÁRIO',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
