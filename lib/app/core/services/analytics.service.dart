/* import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({required String userId}) async {
    await _analytics.setUserId(id: userId);
  }

  /* Future logCadastroEvent(Usuario usuario) async {
    _analytics.logEvent(
        name: "cadastro_finalizado", parameters: usuario.toUsuarioJson());
  } */

  Future logErroEvent(String erro) async {
    _analytics.logEvent(name: "erro", parameters: {"Mensagem": erro});
  }
}
 */
