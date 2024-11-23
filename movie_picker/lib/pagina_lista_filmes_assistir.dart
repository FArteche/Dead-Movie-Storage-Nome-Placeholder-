import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_picker/db/filme_lista_assistirDAO.dart';
import 'package:movie_picker/model/filme_lista_assistir_model.dart';
import 'package:movie_picker/pagina_detalhes_filmes.dart';

class PaginaListaFilmesAssistir extends StatefulWidget {
  const PaginaListaFilmesAssistir({super.key});

  @override
  State<PaginaListaFilmesAssistir> createState() => _ListaFilmesAssistirState();
}

class _ListaFilmesAssistirState extends State<PaginaListaFilmesAssistir> {
  final FilmeListaAssistirDAO _filmeListaAssistirDAO = FilmeListaAssistirDAO();

  @override
  void initState() {
    super.initState();
    _listarFilmes();
  }

  List<FilmeListaAssistirModel> listFilme = [];

  Future<void> _listarFilmes() async {
    var aux = await _filmeListaAssistirDAO.selectFilme();
    setState(() {
      listFilme = aux;
    });
  }

  void _removerFilme(int idDel) {
    _filmeListaAssistirDAO.deleteFilme(idDel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: _listarFilmes,
            icon: const Icon(Icons.refresh_sharp),
          ),
        ],
        title: Text(
          'Lista de Filmes',
          style: GoogleFonts.bebasNeue(
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Center(
          child: SizedBox(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: listFilme.length,
                      itemBuilder: (context, index) {
                        initBool(listFilme[index]);
                        return cardFilme(listFilme[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  cardFilme(FilmeListaAssistirModel filme) {
    return SizedBox(
      height: 130,
      child: Card(
        color: Colors.blueGrey[400],
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 2)),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: filme.isAssistidoBool!
                      ? FloatingActionButton(
                          onPressed: () async {
                            setState(() {
                              filme.isAssistido = 0;
                              filme.isAssistidoBool = false;
                            });
                            await _filmeListaAssistirDAO.updateFilme(filme);
                          },
                          backgroundColor: Color(Colors.black.value),
                          foregroundColor: Color(Colors.white.value),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.check)],
                          ),
                        )
                      : FloatingActionButton(
                          onPressed: () async {
                            setState(() {
                              filme.isAssistido = 1;
                              filme.isAssistidoBool = true;
                            });
                            await _filmeListaAssistirDAO.updateFilme(filme);
                          },
                          foregroundColor: Color(Colors.black.value),
                          backgroundColor: Color(Colors.white.value),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.check_box_outline_blank)],
                          ),
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2)),
                  child: Image(
                    image: NetworkImage(
                        'https://image.tmdb.org/t/p/w1280${filme.posterPath}'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                width: 185,
                child: GestureDetector(
                  onTap: () => _abrirDetalhesFilme(filme.id, filme.nomeFilme),
                  child: Text(
                    filme.nomeFilme,
                    style: GoogleFonts.bebasNeue(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {
                  setState(() {
                    _filmeListaAssistirDAO.deleteFilme(filme.id);
                    _listarFilmes();
                  });
                },
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }

  initBool(FilmeListaAssistirModel filme) {
    if (filme.isAssistido == 1) {
      filme.isAssistidoBool = true;
      print('boolean - ${filme.isAssistidoBool}');
    } else {
      filme.isAssistidoBool = false;
      print('boolean - ${filme.isAssistidoBool}');
    }
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
