import 'package:movie_picker/model/filme_model.dart';
import 'package:movie_picker/service/TMDBService.dart';

class Filmecontroller {
  final _tmdbService = TMDBService();
  List<FilmeModel> listFilmes = [];
  int pagina = 0;
  int resultadosTotais = 0;

  Future<void> getProxPagina() async {
    pagina++;
    var aux = await _tmdbService.getFilmesPopulares(pagina);
    listFilmes += aux;
    resultadosTotais = listFilmes.length;
  }
}