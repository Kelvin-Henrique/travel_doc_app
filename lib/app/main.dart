import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:iva_app/app/app.module.dart';
import 'package:iva_app/app/app.widget.dart';
import 'package:iva_app/app/core/locator/locator.dart';
import 'package:iva_app/app/core/providers/theme_provider.dart';
import 'package:iva_app/themes/flavors.dart';

void main() async {
  setupDependencies();

  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.DEV;

  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: ModularApp(module: AppModule(), child: AppWidget()),
    ),
  );
}
