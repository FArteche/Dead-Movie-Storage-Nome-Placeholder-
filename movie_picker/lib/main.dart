import 'package:flutter/material.dart';
import 'package:movie_picker/pagina_filmes.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Paginafilmes(),
    );
  }
}
