import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_picker/model/cast_model.dart';
import 'package:movie_picker/model/filme_detalhe_model.dart';
import 'package:movie_picker/model/filme_model.dart';
import 'package:movie_picker/preferences.dart';

class TMDBService {
  final String _apiKey = 'e16e40aa493760e36e4cb2ff60ab3778';
  final String _baseUrl = 'https://api.themoviedb.org/3';
  final String _lang = pLanguage;

  Future<List<FilmeModel>> getFilmesPopulares(int page) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/movie/popular?api_key=$_apiKey&page=$page&language=$_lang'));

    if (response.statusCode == 200) {
      final dados = json.decode(response.body);

      if (dados['results'] is List) {
        return (dados['results'] as List)
            .map((item) => FilmeModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Falha ao carregar filmes populares');
      }
    } else {
      throw Exception('Falha ao carregar filmes populares');
    }
  }

  Future<List<FilmeModel>> getFilmesPorGenero(int generoId, int page) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/discover/movie?api_key=$_apiKey&page=$page&with_genres=$generoId&language=$_lang'));

    if (response.statusCode == 200) {
      final dados = json.decode(response.body);

      if (dados['results'] is List) {
        return (dados['results'] as List)
            .map((item) => FilmeModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Falha ao carregar filmes Busca');
      }
    } else {
      throw Exception('Falha ao carregar filmes Busca');
    }
  }

  Future<List<FilmeModel>> getFilmesPesquisa(String pesquisa, int page) async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/search/movie?api_key=$_apiKey&query=$pesquisa&language=$_lang&page=$page'));

    if (response.statusCode == 200) {
      final dados = json.decode(response.body);

      if (dados['results'] is List) {
        return (dados['results'] as List)
            .map((item) => FilmeModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Falha ao carregar filmes populares');
      }
    } else {
      throw Exception('Falha ao carregar filmes populares');
    }
  }

  Future<List<CastModel>> getCast(int idFilme) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$idFilme/credits?api_key=$_apiKey&language=$_lang'));

    if (response.statusCode == 200) {
      final dados = json.decode(response.body);

      // Retorna apenas a lista de cast
      return (dados['cast'] as List)
          .map((item) => CastModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Falha ao carregar cast');
    }
  }

  Future<FilmeDetalheModel> getFilmeDetalhe(int filmeId) async {
    final response = await http.get(
        Uri.parse('$_baseUrl/movie/$filmeId?api_key=$_apiKey&language=$_lang'));

    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      return FilmeDetalheModel.fromJson(dados);
    } else {
      throw Exception('Falha ao carregar detalhes do filme');
    }
  }
}
