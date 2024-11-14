import 'package:flutter/material.dart';
import 'package:movie_picker/model/filme_detalhe_model.dart';
import 'package:movie_picker/service/TMDBService.dart';
import 'package:movie_picker/widget/chip_date.dart';
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
  final TMDBService _tmdbService = TMDBService();

  Future<FilmeDetalheModel> _inicializar(int filmeId) async {
    try {
      final filmeDetalhe = await _tmdbService.getFilmeDetalhe(filmeId);
      return filmeDetalhe;
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filmeTitulo),
        actions: const [
          //TODO ADICIONAR FUNCIONALIDADE NO BOTÃO DE ADICIONAR A LISTA
          IconButton(onPressed: null, icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<FilmeDetalheModel>(
        future: _inicializar(widget.filmeId),
        builder:
            (BuildContext context, AsyncSnapshot<FilmeDetalheModel> snapshot) {
          //Carregando Informações
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Erro
          if (snapshot.hasError) {
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
            var filmeDetalhe = snapshot.data!;

            return Container(
              //IMAGEM DE FUNDO
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      filmeDetalhe.backdropPath != null &&
                              filmeDetalhe.backdropPath!.isNotEmpty
                          ? 'https://image.tmdb.org/t/p/w1280${filmeDetalhe.backdropPath}'
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
                            color:
                                Colors.black.withOpacity(0.2), // Cor da sombra
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
                                        filmeDetalhe.posterPath != null &&
                                                filmeDetalhe
                                                    .posterPath!.isNotEmpty
                                            ? 'https://image.tmdb.org/t/p/w342${filmeDetalhe.posterPath}'
                                            : 'https://freesvg.org/img/matt-icons_image-missing.png', // Imagem padrão
                                        scale: 2),
                                  ),
                                ),
                                Rate(value: filmeDetalhe.voteAverage),
                                ChipDate(
                                  date: filmeDetalhe.releaseDate ??
                                      DateTime(0, 0, 0),
                                ),
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
                                  filmeDetalhe.originalTitle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  filmeDetalhe.title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //GÊNERO
                                Text(
                                  'Gênero: ',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  filmeDetalhe.genres!.join(' - '),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //TEMPO DE DURAÇÃO
                                Text(
                                  'Tempo de duração: ',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  "${filmeDetalhe.runtime!} Minutos",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //BUDGET
                                Text(
                                  'Custo: ',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  "${filmeDetalhe.budget!.toDouble()} \$",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                //LUCRO
                                Text(
                                  'Lucro: ',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  "${filmeDetalhe.revenue!} \$",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(
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
                            color:
                                Colors.black.withOpacity(0.2), // Cor da sombra
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset:
                                const Offset(4, 5), // Deslocamento da sombra
                          ),
                        ],
                      ),
                      child: Text(
                        filmeDetalhe.overview ?? 'Sem overview disponível',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // ListView(
                    //   scrollDirection: Axis
                    //       .horizontal, // Definindo a rolagem para horizontal
                    //   children: List.generate(10, (index) {
                    //     return Container(
                    //       width: 100, // Largura fixa para cada container
                    //       margin: EdgeInsets.symmetric(
                    //           horizontal: 8), // Espaçamento entre os containers
                    //       color: Colors.blueAccent,
                    //       child: Center(
                    //         child: Text(
                    //           'Item $index',
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //       ),
                    //     );
                    //   }),
                    // ),
                  ],
                ),
              ),
            );
          }
          //Nenhum Dado Encontrado
          return const Center(child: Text('Nenhum dado encontrado'));
        },
      ),
    );
  }
}
