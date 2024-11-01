import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_picker/preferences.dart';

class TMDBService {
  final String apiKey = 'e16e40aa493760e36e4cb2ff60ab3778'; 
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String lang = Preferences().language;

  Future<Map<String, dynamic>> getFilmesPopulares() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=$lang'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar filmes populares');
    }
  }
  Future<Map<String, dynamic>> getFilmeDetalhe() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=$lang'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar filmes populares');
    }
  }
}

