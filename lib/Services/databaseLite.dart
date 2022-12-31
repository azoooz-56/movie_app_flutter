import 'dart:io';

import 'package:movie_app/Models/MovieModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  static List<Movie> moviesListPub = [];

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'moviedatabase6.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies(
          id TEXT PRIMARY KEY,
          name TEXT,
          imagePathBackdrop TEXT,
          imagePathPoster TEXT,
          description TEXT,
          date TEXT,
          genresList TEXT
      )
      ''');
  }

  Future<List<Movie>> getMovies() async {
    Database db = await instance.database;
    var movies = await db.query('movies', orderBy: 'name');
    List<Movie> moviesList =
        movies.isNotEmpty ? movies.map((c) => Movie.fromMap(c)).toList() : [];
    print("ListDatabase" + moviesList.toString());
    moviesListPub = moviesList;
    return moviesList;
  }

  Future<int> add(Movie movie) async {
    Database db = await instance.database;
    return await db.insert('movies', movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> remove(String id) async {
    Database db = await instance.database;
    return await db.delete('movies', where: 'id = ?', whereArgs: [id]);
  }

  isFav(Movie movie) {
    List<Movie> moviesDB = moviesListPub;
    bool isthere = false;
    print('length' + moviesDB.length.toString());

    for (int i = 0; i < moviesDB.length; i++) {
      if (moviesDB[i].id == movie.id) {
        isthere = true;
      }
    }
    if (isthere) {
      return true;
    } else {
      return false;
    }
  }
}
