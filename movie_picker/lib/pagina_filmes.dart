import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_picker/controller/filme_controller.dart';
import 'package:movie_picker/pagina_detalhes_filmes.dart';
import 'package:movie_picker/widget/list_horizontal_filmes.dart';

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
    _initalize();
  }

  _initalize() async {
    await _controller.getFilmesPopulares();
    print("ok");
    await _controller.getFilmesAcao();
    print("ok");
    await _controller.getFilmesAnimacao();
    print("ok");
    await _controller.getFilmesAventura();
    print("ok");
    await _controller.getFilmesRomance();
    print("ok");
    await _controller.getFilmesTerror();
    print("ok");
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(color: Colors.black),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(1,10,1,1),
                          child: Text(
                                        "Filmes Populares",
                                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                        )),
                    Expanded(
                        child:
                            listHorizontalFilmes(listFilmes: _controller.listFilmesPopulares)),
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(color: Colors.blueGrey),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(1,10,1,1),
                          child: Text(
                                        "Filmes de Ação",
                                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                        )),
                    Expanded(
                        child:
                            listHorizontalFilmes(listFilmes: _controller.listFilmesAcao)),
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(color: Colors.black),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(1,10,1,1),
                          child: Text(
                                        "Animações",
                                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                        )),
                    Expanded(
                        child:
                            listHorizontalFilmes(listFilmes: _controller.listFilmesAnimacao)),
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(color: Colors.blueGrey),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(1,10,1,1),
                          child: Text(
                                        "Filmes de Aventura",
                                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                        )),
                    Expanded(
                        child:
                            listHorizontalFilmes(listFilmes: _controller.listFilmesAventura)),
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(color: Colors.black),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(1,10,1,1),
                          child: Text(
                                        "Romances",
                                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                        )),
                    Expanded(
                        child:
                            listHorizontalFilmes(listFilmes: _controller.listFilmesRomance)),
                  ],
                ),
              ),
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(color: Colors.blueGrey),
              child: Container(
                child: Column(
                  children: [
                    Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(1,10,1,1),
                          child: Text(
                                        "Filmes de Terror",
                                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.bold),
                                        ),
                                      ),
                        )),
                    Expanded(
                        child:
                            listHorizontalFilmes(listFilmes: _controller.listFilmesTerror)),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        if (index < _controller.listFilmesPopulares.length) {
          final filme = _controller.listFilmesPopulares[index];
          final bool isSelected = filme.id == _idFilmeSelecionado;
          final posterUrl =
              'https://image.tmdb.org/t/p/w342${_controller.listFilmesPopulares[index].posterPath}';
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
              tag: 'movie_${_controller.listFilmesPopulares[index].id}',
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
