import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_picker/controller/filme_controller.dart';
import 'package:movie_picker/pagina_detalhes_filmes.dart';
import 'package:movie_picker/pagina_lista_filmes_assistir.dart';
import 'package:movie_picker/pagina_pesquisa.dart';
import 'package:movie_picker/widget/list_horizontal_filmes.dart';

class Paginafilmes extends StatefulWidget {
  const Paginafilmes({super.key});

  @override
  State<Paginafilmes> createState() => _PaginafilmesState();
}

class _PaginafilmesState extends State<Paginafilmes> {
  final _controller = Filmecontroller();
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    _initalize();
  }

  _initalize() async {
    isloading = true;
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
    isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Center(
            child: Image.asset(
          'assets/logo_mini.png',
          width: 300,
        )),
        actions: [
          IconButton(
            onPressed: _initalize,
            icon: const Icon(Icons.refresh_sharp),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(Colors.black87.value),
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              child: Center(
                child: Text(
                  "Menu",
                  style: GoogleFonts.bebasNeue(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: Text(
                'Início',
                style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.search_outlined,
                color: Colors.white,
              ),
              title: Text(
                'Pesquisar',
                style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  (MaterialPageRoute(
                      builder: (context) => const PaginaPesquisa())),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.list,
                color: Colors.white,
              ),
              title: Text(
                'Lista',
                style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  (MaterialPageRoute(
                      builder: (context) => const PaginaListaFilmesAssistir())),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: Text(
                'Sair',
                style: GoogleFonts.bebasNeue(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
      ),
      body: isloading
          ? Center(
              child: Container(
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png'),
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
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
                            padding: const EdgeInsets.fromLTRB(1, 10, 1, 1),
                            child: Text(
                              "Filmes Populares",
                              style: GoogleFonts.bebasNeue(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          Expanded(
                              child: listHorizontalFilmes(
                                  listFilmes: _controller.listFilmesPopulares)),
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
                            padding: const EdgeInsets.fromLTRB(1, 10, 1, 1),
                            child: Text(
                              "Filmes de Ação",
                              style: GoogleFonts.bebasNeue(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          Expanded(
                              child: listHorizontalFilmes(
                                  listFilmes: _controller.listFilmesAcao)),
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
                            padding: const EdgeInsets.fromLTRB(1, 10, 1, 1),
                            child: Text(
                              "Animações",
                              style: GoogleFonts.bebasNeue(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          Expanded(
                              child: listHorizontalFilmes(
                                  listFilmes: _controller.listFilmesAnimacao)),
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
                            padding: const EdgeInsets.fromLTRB(1, 10, 1, 1),
                            child: Text(
                              "Filmes de Aventura",
                              style: GoogleFonts.bebasNeue(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          Expanded(
                              child: listHorizontalFilmes(
                                  listFilmes: _controller.listFilmesAventura)),
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
                            padding: const EdgeInsets.fromLTRB(1, 10, 1, 1),
                            child: Text(
                              "Romances",
                              style: GoogleFonts.bebasNeue(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          Expanded(
                              child: listHorizontalFilmes(
                                  listFilmes: _controller.listFilmesRomance)),
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
                            padding: const EdgeInsets.fromLTRB(1, 10, 1, 1),
                            child: Text(
                              "Filmes de Terror",
                              style: GoogleFonts.bebasNeue(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                          Expanded(
                              child: listHorizontalFilmes(
                                  listFilmes: _controller.listFilmesTerror)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
