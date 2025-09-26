import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:travel_doc_app/app/features/loader/usecases/loader.controller.dart';

class Loader extends StatefulWidget {
  final Widget? child;

  const Loader({super.key, this.child});

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  final controller = GetIt.I.get<LoaderController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        children: [
          widget.child!,
          if (controller.loading)
            Container(
              color: Colors.white.withOpacity(0.7),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0A4DA1)),
                              strokeWidth: 6,
                            ),
                          ),
                          Image.asset(
                            'assets/images/travel_doc_logo.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Carregando...',
                      style: TextStyle(
                        color: Color(0xFF0A4DA1),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none, 
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
