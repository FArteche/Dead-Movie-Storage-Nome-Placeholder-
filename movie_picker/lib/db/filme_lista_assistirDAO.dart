import 'dart:async';
import 'package:movie_picker/db/DatabaseHelper.dart';
import 'package:movie_picker/model/filme_lista_assistir_model.dart';
import 'package:sqflite/sqflite.dart';

class FilmeListaAssistirDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Stream<List<FilmeListaAssistirModel>> getFilmeStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 300));
      yield await selectFilme();
    }
  }

  Future<void> insertFilme(FilmeListaAssistirModel filme) async {
    final db = await _dbHelper.database;
    await db.insert('filme', filme.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateFilme(FilmeListaAssistirModel filme) async {
    final db = await _dbHelper.database;
    await db
        .update('filme', filme.toMap(), where: 'id = ?', whereArgs: [filme.id]);
  }

  Future<void> deleteFilme(int idDel) async {
    final db = await _dbHelper.database;
    await db.delete(
      'filme',
      where: 'id = ?',
      whereArgs: [idDel],
    );
  }

  Future<List<FilmeListaAssistirModel>> selectFilme() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('filme');
    print("Dados retornados: $tipoJSON");
    return List.generate(
      tipoJSON.length,
      (i) {
        return FilmeListaAssistirModel.fromMap(tipoJSON[i]);
      },
    );
  }

  Future<bool> isFilmeExistente(int filmeId) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'filme',
      where: 'id = ?',
      whereArgs: [filmeId],
    );

    return result.isNotEmpty;
  }
}
