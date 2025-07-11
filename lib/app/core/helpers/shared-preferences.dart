import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _cliente = "cliente";
  static final String _notification = "notification";

  static Future setNotification(bool notification) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setBool(_notification, notification);
  }

  static Future<bool> getNotification() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    bool notification = shared.getBool(_notification) ?? false;

    await setNotification(false);

    return notification;
  }

  static Future clearClient() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString(_cliente, "");
  }

  /* static Future setClient(UsuarioModel usuario) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString(_cliente, jsonEncode(usuario));
  }

  static Future<UsuarioModel> getClient() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    if (shared.getString(_cliente)!.isEmpty) return UsuarioModel();

    String? clienteString = shared.getString(_cliente);
    if (clienteString == null || clienteString.isEmpty) return UsuarioModel();
    return UsuarioModel.fromJson(jsonDecode(clienteString));
  } */

  static Future setVisibleCaptial(bool visible) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setBool("capital", visible);
  }

  static Future<bool?> getVisibleCapital() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getBool("capital");
  }

  static Future setClienteIndicacaoId(String clienteId) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString("clienteIndicacaoId", clienteId);
  }

  static Future<String?> getClienteIndicacaoId() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getString("clienteIndicacaoId");
  }
}
