import 'package:flutter/material.dart';
import 'package:movie_picker/model/filme_model.dart';
import 'package:movie_picker/pagina_detalhes_filmes.dart';

class listHorizontalFilmes extends StatefulWidget {
  final List<FilmeModel> listFilmes;

  const listHorizontalFilmes({
    super.key,
    required this.listFilmes,
  });

  @override
  State<listHorizontalFilmes> createState() => _listHorizontalFilmesState();
}

class _listHorizontalFilmesState extends State<listHorizontalFilmes> {
  int? _idFilmeSelecionado;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      scrollDirection: Axis.horizontal, 
      itemCount: widget.listFilmes.length,
      itemBuilder: (context, index) {
        if (index < widget.listFilmes.length) {
          final filme = widget.listFilmes[index];
          final bool isSelected = filme.id == _idFilmeSelecionado;
          final posterUrl =
              'https://image.tmdb.org/t/p/w342${widget.listFilmes[index].posterPath}';

          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _abrirDetalhesFilme(_idFilmeSelecionado!, filme.title);
                  _idFilmeSelecionado = null;
                } else {
                  _idFilmeSelecionado = filme.id;
                  print("$_idFilmeSelecionado - ${filme.id}");
                }
              });
            },
            child: Hero(
              tag: 'movie_${widget.listFilmes[index].id}',
              child: Container(
                width:
                    120, 
                margin: const EdgeInsets.symmetric(
                    horizontal: 4), 
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(
                          color: const Color.fromARGB(136, 255, 255, 255),
                          width: 1.0,
                        )
                      : Border.all(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        posterUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    if (isSelected)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    if (isSelected)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: Text(
                            filme.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _abrirDetalhesFilme(int filmeId, String nomeFilme) {
    Navigator.push(
      context,
      (MaterialPageRoute(
        builder: (context) => TelaDetalhesFilme(
          filmeId: filmeId,
          filmeTitulo: nomeFilme,
        ),
      )),
    );
  }
}
