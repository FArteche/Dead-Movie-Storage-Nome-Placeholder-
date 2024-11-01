import 'package:flutter/material.dart';

import 'service/tmdbService.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieListScreen(),
    );
  }
}

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final TMDBService tmdbService = TMDBService();
  late Future<Map<String, dynamic>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = tmdbService.getFilmesPopulares();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes Populares'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!['results'].isEmpty) {
            return Center(child: Text('Nenhum filme encontrado.'));
          } else {
            final movies = snapshot.data!['results'] as List;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(movies[index]['title']),
                  subtitle: Text(movies[index]['release_date'] ?? 'Data não disponível'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
