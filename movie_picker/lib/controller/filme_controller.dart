import 'dart:math';

import 'package:movie_picker/model/filme_model.dart';
import 'package:movie_picker/service/TMDBService.dart';

class Filmecontroller {
  final _tmdbService = TMDBService();
  List<FilmeModel> listFilmesPopulares = [];
  List<FilmeModel> listFilmesAcao = [];
  List<FilmeModel> listFilmesRomance = [];
  List<FilmeModel> listFilmesAventura = [];
  List<FilmeModel> listFilmesTerror = [];
  List<FilmeModel> listFilmesAnimacao = [];
  int pagina = 0;
  int resultadosTotais = 0;

  Future<void> getFilmesPopulares() async {
    var aux = await _tmdbService.getFilmesPopulares(1);
    listFilmesPopulares = aux;
  }

  Future<void> getFilmesAcao() async {
    var aux = await _tmdbService.getFilmesPorGenero(28, _gerarNumeroAleatorio(1, 3));
    listFilmesAcao = aux;
  }

  Future<void> getFilmesTerror() async {
    var aux = await _tmdbService.getFilmesPorGenero(27, _gerarNumeroAleatorio(1, 3));
    listFilmesTerror = aux;
  }

  Future<void> getFilmesAnimacao() async {
    var aux = await _tmdbService.getFilmesPorGenero(16, _gerarNumeroAleatorio(1, 3));
    listFilmesAnimacao = aux;
  }

  Future<void> getFilmesAventura() async {
    pagina++;
    var aux = await _tmdbService.getFilmesPorGenero(12, _gerarNumeroAleatorio(1, 3));
    listFilmesAventura = aux;
  }

  Future<void> getFilmesRomance() async {
    pagina++;
    var aux = await _tmdbService.getFilmesPorGenero(10749, _gerarNumeroAleatorio(1, 3));
    listFilmesRomance = aux;
  }

  int _gerarNumeroAleatorio(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }
}
