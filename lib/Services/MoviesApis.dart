import 'package:http/http.dart' as http;
import 'package:movie_app/Models/GenreModel.dart';
import 'dart:convert' as convert;

import 'package:movie_app/Models/MovieModel.dart';

class MovieApis {
  static List<Movie> moviesNow = [];
  static List<Movie> moviesPopular = [];
  static List<Movie> moviesSoon = [];
  static List<Genre> genresMovie = [];

  static List<Movie> moviesType = [];


  getNowMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=1031edf9ff286ae5fb5ee183fb176ff4&language=en-US&page=1'));

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      List ListMovies = jsonResponse["results"];
      for (int i = 0; i < ListMovies.length; i++) {
        List<String> genres = [];
        List<int> listgenreMovieId = List<int>.from(ListMovies[i]['genre_ids']);

        for (int i = 0; i < listgenreMovieId.length; i++) {
          for (int j = 0; j < genresMovie.length; j++) {
            if (listgenreMovieId[i].toString() == genresMovie[j].id) {
              genres.add(genresMovie[j].name);
              break;
            }
          }
        }

        Movie m = Movie(
            ListMovies[i]['title'] as String,
            'https://image.tmdb.org/t/p/w500' + ListMovies[i]['backdrop_path']
                as String,
            'https://image.tmdb.org/t/p/w500' + ListMovies[i]['poster_path']
                as String,
            ListMovies[i]['overview'] as String,
            genres,
            ListMovies[i]['release_date'] as String,
            ListMovies[i]['id'].toString());

        moviesNow.add(m);
      }
    }
    await getPopularMovies();
    await getSoonMovies();

    return moviesNow;
  }

  getPopularMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=1031edf9ff286ae5fb5ee183fb176ff4&language=en-US&page=1'));

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    print('what');
    if (response.statusCode == 200) {
      List ListMovies = jsonResponse["results"];
      for (int i = 0; i < ListMovies.length; i++) {
        List<String> genres = [];
        List<int> listgenreMovieId = List<int>.from(ListMovies[i]['genre_ids']);

        for (int i = 0; i < listgenreMovieId.length; i++) {
          for (int j = 0; j < genresMovie.length; j++) {
            if (listgenreMovieId[i].toString() == genresMovie[j].id) {
              genres.add(genresMovie[j].name);
              break;
            }
          }
        }

        Movie m = Movie(
            ListMovies[i]['title'] as String,
            'https://image.tmdb.org/t/p/w500' + ListMovies[i]['backdrop_path']
                as String,
            'https://image.tmdb.org/t/p/w500' + ListMovies[i]['poster_path']
                as String,
            ListMovies[i]['overview'] as String,
            genres,
            ListMovies[i]['release_date'] as String,
            ListMovies[i]['id'].toString());

        moviesPopular.add(m);
      }
    }

    return moviesPopular;
  }

  getSoonMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=1031edf9ff286ae5fb5ee183fb176ff4&language=en-US&page=1'));

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    print('what');
    if (response.statusCode == 200) {
      List ListMovies = jsonResponse["results"];
      for (int i = 0; i < ListMovies.length; i++) {
        List<String> genres = [];
        List<int> listgenreMovieId = List<int>.from(ListMovies[i]['genre_ids']);

        for (int i = 0; i < listgenreMovieId.length; i++) {
          for (int j = 0; j < genresMovie.length; j++) {
            if (listgenreMovieId[i].toString() == genresMovie[j].id) {
              genres.add(genresMovie[j].name);
              break;
            }
          }
        }

        Movie m = Movie(
            ListMovies[i]['title'] as String,
            'https://image.tmdb.org/t/p/w500' + ListMovies[i]['backdrop_path']
                as String,
            'https://image.tmdb.org/t/p/w500' + ListMovies[i]['poster_path']
                as String,
            ListMovies[i]['overview'] as String,
            genres,
            ListMovies[i]['release_date'] as String,
            ListMovies[i]['id'].toString());

        moviesSoon.add(m);
      }
    }

    return moviesSoon;
  }

  getGenre() async {
    genresMovie.clear();
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=1031edf9ff286ae5fb5ee183fb176ff4&language=en-US'));

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    print('what');
    if (response.statusCode == 200) {
      List ListGenre = jsonResponse["genres"];
      Genre g = Genre('', 'All');
      genresMovie.add(g);
      for (int i = 0; i < ListGenre.length; i++) {
        Genre g = Genre(
            ListGenre[i]['id'].toString(), ListGenre[i]['name'] as String);

        genresMovie.add(g);
      }
    }
  }

  getDiscoverMovies(String id) async {
    moviesType.clear();
    String idGenre = 'with_genres=25&';
    int itrater = 5;
    if (!id.isEmpty) {
      id = 'with_genres=$id &';
    }

    for(int x = 1; x<itrater;x++) {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?api_key=1031edf9ff286ae5fb5ee183fb176ff4&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=$x&$id with_watch_monetization_types=flatrate'));

      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        List ListMovies = jsonResponse["results"];
        for (int i = 0; i < ListMovies.length; i++) {
          List<String> genres = [];
          List<int> listgenreMovieId = List<int>.from(
              ListMovies[i]['genre_ids']);

          for (int i = 0; i < listgenreMovieId.length; i++) {
            for (int j = 0; j < genresMovie.length; j++) {
              if (listgenreMovieId[i].toString() == genresMovie[j].id) {
                genres.add(genresMovie[j].name);
                break;
              }
            }
          }

          Movie m = Movie(
              ListMovies[i]['title'] as String,
              'https://image.tmdb.org/t/p/w500' + ListMovies[i]['backdrop_path'].toString()
              as String,
              'https://image.tmdb.org/t/p/w500' + ListMovies[i]['poster_path']
              as String,
              ListMovies[i]['overview'] as String,
              genres,
              ListMovies[i]['release_date'] as String,
              ListMovies[i]['id'].toString());


          moviesType.add(m);
        }
      }
    }
    return moviesType;
  }
}
//https://image.tmdb.org/t/p/w500
