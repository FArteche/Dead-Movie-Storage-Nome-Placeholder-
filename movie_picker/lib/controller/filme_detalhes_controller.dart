import 'package:movie_picker/model/cast_model.dart';
import 'package:movie_picker/model/filme_detalhe_model.dart';
import 'package:movie_picker/service/TMDBService.dart';

class FilmeDetalhesController {
  final int filmeId;

  FilmeDetalhesController({
    required this.filmeId,
  });

  final TMDBService _tmdbService = TMDBService();

  List<CastModel> cast = [];
  FilmeDetalheModel? fdm;

  Future<void> getDados(int filmeId) async {
    var aux = await _tmdbService.getFilmeDetalhe(filmeId);
    fdm = aux;

    var aux2 = await _tmdbService.getCast(filmeId);
    cast = aux2;
  }
}
