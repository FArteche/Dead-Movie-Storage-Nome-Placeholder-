import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_picker/controller/filme_controller.dart';
import 'package:movie_picker/pagina_detalhes_filmes.dart';

class PaginaPesquisa extends StatefulWidget {
  const PaginaPesquisa({super.key});

  @override
  State<PaginaPesquisa> createState() => _PaginaPesquisaState();
}

class _PaginaPesquisaState extends State<PaginaPesquisa> {
  String query = '';
  final _controller = Filmecontroller();
  int? _idFilmeSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Pesquisar Filmes',
          style: GoogleFonts.bebasNeue(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  query = value;
                  _controller.getPesquisa(query).then(
                    (_) {
                      setState(() {}); // Atualiza a UI
                    },
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Digite o nome do filme...',
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.white10, width: 3.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: _controller.listPequisa.isEmpty
                  ? Center(
                      child: Text(
                        query.isEmpty
                            ? 'Use a barra acima para pesquisar.'
                            : 'Nenhum filme encontrado!',
                        style: GoogleFonts.bebasNeue(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : _filmeGrid(),
            ),
          ),
        ],
      ),
    );
  }

  _filmeGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _controller.listPequisa.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.67,
      ),
      itemBuilder: (context, index) {
        final filme = _controller.listPequisa[index];
        final bool isSelected = filme.id == _idFilmeSelecionado;
        final posterUrl = 'https://image.tmdb.org/t/p/w342${filme.posterPath}';
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _abrirDetalhesFilme(_idFilmeSelecionado!, filme.title);
                _idFilmeSelecionado = null;
              } else {
                _idFilmeSelecionado = filme.id;
              }
            });
          },
          child: Hero(
            tag: 'movie_${filme.id}',
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected
                      ? const Color.fromARGB(136, 255, 255, 255)
                      : Colors.white,
                  width: 1.0,
                ),
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
      },
    );
  }

  _abrirDetalhesFilme(int filmeId, String nomeFilme) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDetalhesFilme(
          filmeId: filmeId,
          filmeTitulo: nomeFilme,
        ),
      ),
    );
  }
}
