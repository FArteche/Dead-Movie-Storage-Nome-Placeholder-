import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_picker/controller/filme_detalhes_controller.dart';
import 'package:movie_picker/db/filme_lista_assistirDAO.dart';
import 'package:movie_picker/model/filme_lista_assistir_model.dart';
import 'package:movie_picker/widget/chip_date.dart';
import 'package:movie_picker/widget/list_horizontal_atores.dart';
import 'package:movie_picker/widget/rate.dart';

class TelaDetalhesFilme extends StatefulWidget {
  final int filmeId;
  final String filmeTitulo;

  const TelaDetalhesFilme({
    super.key,
    required this.filmeId,
    required this.filmeTitulo,
  });

  @override
  _TelaDetalhesFilmeState createState() => _TelaDetalhesFilmeState();
}

class _TelaDetalhesFilmeState extends State<TelaDetalhesFilme> {
  bool isAssistido = false;

  Future<void> _isAssistidoInit() async {
    var aux = await FilmeListaAssistirDAO().isFilmeExistente(widget.filmeId);
    isAssistido = aux;
  }

  @override
  void initState() {
    super.initState();
    _isAssistidoInit();
  }

  Future<FilmeDetalhesController> _inicializar(int filmeId) async {
    try {
      final controller = FilmeDetalhesController(filmeId: filmeId);
      await controller.getDados(filmeId);
      return controller;
    } catch (e) {
      throw Exception('Erro ao inicializar o FilmeDetalheController: $e');
    }
  }

  final formatadorMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          widget.filmeTitulo,
          style: TextStyle(
            color: Color(Colors.white.value),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<FilmeDetalhesController>(
          future: _inicializar(widget.filmeId),
          builder: (BuildContext context,
              AsyncSnapshot<FilmeDetalhesController> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              );
            }
            // Erro
            else if (snapshot.hasError) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 50),
                    Text('Erro ao carregar detalhes do filme',
                        style: TextStyle(fontSize: 18, color: Colors.red)),
                  ],
                ),
              );
            }
            // Sucesso
            if (snapshot.hasData) {
              var filme = snapshot.data!;

              return Container(
                //IMAGEM DE FUNDO
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        filme.fdm?.backdropPath != null &&
                                filme.fdm!.backdropPath!.isNotEmpty
                            ? 'https://image.tmdb.org/t/p/w1280${filme.fdm!.backdropPath}'
                            : 'https://upload.wikimedia.org/wikipedia/commons/c/c8/Very_Black_screen.jpg',
                      ),
                      opacity: 100,
                      fit: BoxFit.fitHeight),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    //CONTEUDO DA PAGINA
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.2), // Cor da sombra
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset:
                                  const Offset(4, 5), // Deslocamento da sombra
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    //POSTER DO FILME
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 4)),
                                    child: Image(
                                      image: NetworkImage(
                                        filme.fdm?.posterPath != null &&
                                                filme
                                                    .fdm!.posterPath!.isNotEmpty
                                            ? 'https://image.tmdb.org/t/p/w342${filme.fdm!.posterPath}'
                                            : 'https://freesvg.org/img/matt-icons_image-missing.png',
                                        scale: 2,
                                      ),
                                    ),
                                  ),
                                  Rate(value: filme.fdm!.voteAverage),
                                  ChipDate(
                                    date: filme.fdm!.releaseDate ??
                                        DateTime(0, 0, 0),
                                  ),
                                  //Adicionar à lista de filmes
                                  botaoAddRm(filme)
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              //INFORMAÇÕES DO FILME (LADO DA IMAGEM)
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //TITULO
                                  Text(
                                    filme.fdm!.originalTitle,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    filme.fdm!.title,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  //GÊNERO
                                  const Text(
                                    'Gênero: ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    filme.fdm!.genres!.join(' - '),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  //TEMPO DE DURAÇÃO
                                  const Text(
                                    'Tempo de duração: ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    "${filme.fdm?.runtime ?? 0} Minutos",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  //BUDGET
                                  const Text(
                                    'Custo: ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    formatadorMoeda.format(filme.fdm!.budget),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  //LUCRO
                                  const Text(
                                    'Lucro: ',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    formatadorMoeda.format(filme.fdm!.revenue),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Sinopse',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            shadows: [
                              Shadow(
                                offset:
                                    Offset(2.0, 2.0), // Deslocamento da sombra
                                blurRadius: 4.0, // Nível de desfoque
                                color: Colors.black, // Cor da sombra
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(4, 5),
                            ),
                          ],
                        ),
                        child: Text(
                          filme.fdm?.overview ?? 'Sem overview disponível',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Center(
                        child: Text(
                          'Elenco',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            shadows: [
                              Shadow(
                                offset:
                                    Offset(2.0, 2.0), // Deslocamento da sombra
                                blurRadius: 4.0, // Nível de desfoque
                                color: Colors.black, // Cor da sombra
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                          height: 200,
                          child: listHorizontalCast(listCast: filme.cast)),
                    ],
                  ),
                ),
              );
            }
            //Nenhum Dado Encontrado
            return const Center(child: Text('Nenhum dado encontrado'));
          },
        ),
      ),
    );
  }

  adicionarFilmeLista(FilmeListaAssistirModel filme) async {
    try {
      await FilmeListaAssistirDAO().insertFilme(filme);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Filme '${filme.nomeFilme}' adicionado com sucesso!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao adicionar filme: $e")),
      );
    }
  }

  removerFilmeLista(FilmeListaAssistirModel filme) async {
    try {
      await FilmeListaAssistirDAO().deleteFilme(filme.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("'${filme.nomeFilme}' removido da lista")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao remover filme: $e")),
      );
    }
  }

  botaoAddRm(FilmeDetalhesController filme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: 160,
          height: 40,
          child: isAssistido
              ? FloatingActionButton(
                  onPressed: () {
                    removerFilmeLista(
                      FilmeListaAssistirModel(
                          id: filme.fdm!.id,
                          nomeFilme: filme.fdm!.title,
                          posterPath:
                              'https://image.tmdb.org/t/p/w342${filme.fdm!.posterPath}',
                          isAssistido: 0),
                    );
                    setState(() {
                      isAssistido = false;
                    });
                  },
                  backgroundColor: Color(Colors.black.value),
                  foregroundColor: Color(Colors.white.value),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add), Text('Remover da lista')],
                  ),
                )
              : FloatingActionButton(
                  onPressed: () {
                    adicionarFilmeLista(
                      FilmeListaAssistirModel(
                          id: filme.fdm!.id,
                          nomeFilme: filme.fdm!.title,
                          posterPath:
                              'https://image.tmdb.org/t/p/w342${filme.fdm!.posterPath}',
                          isAssistido: 0),
                    );
                    setState(() {
                      isAssistido = true;
                    });
                  },
                  foregroundColor: Color(Colors.black.value),
                  backgroundColor: Color(Colors.white.value),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add), Text('Adicionar à lista')],
                  ),
                )),
    );
  }
}
