import 'package:flutter/material.dart';
import 'package:movie_picker/controller/filme_controller.dart';
import 'package:movie_picker/pagina_detalhes_filmes.dart';

class Paginafilmes extends StatefulWidget {
  const Paginafilmes({super.key});

  @override
  State<Paginafilmes> createState() => _PaginafilmesState();
}

class _PaginafilmesState extends State<Paginafilmes> {
  final _controller = Filmecontroller();
  final _scrollController = ScrollController();
  int? _idFilmeSelecionado;
  int ultimaPag = 1;

  @override
  void initState() {
    super.initState();
    _initScrollListener();
    _initalize();
  }

  _initScrollListener() {
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        if (_controller.pagina == ultimaPag) {
          ultimaPag++;
          await _controller.getProxPagina();
          setState(() {});
        }
      }
    });
  }

  _initalize() async {
    _controller.pagina = 0;
    ultimaPag = 1;
    await _controller.getProxPagina();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CINE ME',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: _initalize,
            icon: const Icon(Icons.refresh_sharp),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: _filmeGrid(),
      ),
    );
  }

  _filmeGrid() {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(8.0),
      itemCount: _controller.resultadosTotais,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.67),
      itemBuilder: (context, index) {
        if (index < _controller.listFilmes.length) {
          final filme = _controller.listFilmes[index];
          final bool isSelected = filme.id == _idFilmeSelecionado;
          final posterUrl =
              'https://image.tmdb.org/t/p/w342${_controller.listFilmes[index].posterPath}';
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
              tag: 'movie_${_controller.listFilmes[index].id}',
              child: Container(
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border.all(
                          color: const Color.fromARGB(136, 255, 255, 255),
                          width: 1.0)
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
