import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pais.model.dart';

class PaisService {
  Future<List<PaisModel>> buscarPaisesAsync() async {
    final url = Uri.parse('https://restcountries.com/v3.1/all?fields=name,capital,flags');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => PaisModel.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar países: ${response.statusCode}');
    }
  }
}
