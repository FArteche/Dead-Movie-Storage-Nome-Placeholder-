import 'dart:convert';
import 'package:http/http.dart' as http;

class TMDBService {
  final String apiKey = 'e16e40aa493760e36e4cb2ff60ab3778'; 
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<Map<String, dynamic>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=pt-BR'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar filmes populares');
    }
  }
}

