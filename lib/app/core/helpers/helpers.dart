import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Helpers {
  static FlutterSecureStorage storage = FlutterSecureStorage();
  static final String _token = "token";
  static final String _username = "username";
  static final String _password = "password";
  static final String _idSindicatoMetalurgicos = "idSindicatoMetalurgicos";

  static String? _accessToken;

  static Future setToken(String accessToken) async {
    _accessToken = accessToken;
    await storage.write(key: _token, value: accessToken);
  }

  static Future<String> getToken() async {
    var jwt = await storage.read(key: _token);
    if (jwt == null) return "";
    return jwt;
  }

  static dynamic _decodeJWT(String jwt) {
    final data = jwt.split(".");

    final payload = data[1];
    return json
        .decode(utf8.decode(base64Url.decode(base64Url.normalize(payload))));
  }

  static bool isValidToken() {
    var payload = _decodeJWT(_accessToken ?? '');
    return DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
        .isAfter(DateTime.now());
  }

  static Future<String> getDocument() async {
    var payload = await _decodeJWT(await getToken());

    if (payload["document"] != null) return payload["document"];

    return "";
  }

  static Future setCredentials(String username, String password) async {
    await storage.write(key: _username, value: username);
    await storage.write(key: _password, value: password);
  }

  static Future setPassword(String password) async {
    await storage.write(key: _password, value: password);
  }

  static Future<String?> getPassword() async {
    return await storage.read(key: _password);
  }

  static Future<String?> getUsername() async {
    return await storage.read(key: _username);
  }

  static Future setIdSindicatoMetalurgicos(String sharedKey) async {
    await storage.write(key: _idSindicatoMetalurgicos, value: sharedKey);
  }

  static Future<String?> getIdSindicatoMetalurgicos() async {
    try {
      return await storage.read(key: _idSindicatoMetalurgicos);
    } catch (e) {
      return null;
    }
  }
}
