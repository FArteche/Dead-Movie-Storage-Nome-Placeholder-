import 'package:flutter/material.dart';
import 'package:movie_picker/model/cast_model.dart';
import 'package:movie_picker/pagina_detalhes_filmes.dart';

class listHorizontalCast extends StatefulWidget {
  final List<CastModel> listCast;

  const listHorizontalCast({
    super.key,
    required this.listCast,
  });

  @override
  State<listHorizontalCast> createState() => _listHorizontalCastState();
}

// ignore: camel_case_types
class _listHorizontalCastState extends State<listHorizontalCast> {
  int? _idFilmeSelecionado;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      scrollDirection: Axis.horizontal, 
      itemCount: widget.listCast.length,
      itemBuilder: (context, index) {
        if (index < widget.listCast.length) {
          final ator = widget.listCast[index];
          final bool isSelected = ator.id == _idFilmeSelecionado;
          final posterUrl =
              'https://image.tmdb.org/t/p/w342${widget.listCast[index].profilePath}';

          return GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  //TODO SE DER TEMPO COLOCAR PAGINA DE DETALHES DOS ATORES
                  _idFilmeSelecionado = null;
                } else {
                  _idFilmeSelecionado = ator.id;
                }
              });
            },
            child: Hero(
              tag: 'movie_${widget.listCast[index].id}',
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
                            "${ator.name} como ${ator.character}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
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
