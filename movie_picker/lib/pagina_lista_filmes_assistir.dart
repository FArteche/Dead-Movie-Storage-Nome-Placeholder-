import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_picker/db/filme_lista_assistirDAO.dart';
import 'package:movie_picker/model/filme_lista_assistir_model.dart';

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
    listFilme = aux;
  }

  void _removerFilme(int idDel) {
    _filmeListaAssistirDAO.deleteFilme(idDel);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      print('AAAAAAAAAAAAAAAAAAAAAAAAA${listFilme[index].isAssistidoBool}');
                      return cardFilme(listFilme[index]);
                    },
                  ),
                ),
              ],
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
              Text(
                filme.nomeFilme,
                style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
