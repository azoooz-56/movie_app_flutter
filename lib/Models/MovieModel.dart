import 'package:movie_app/Models/CastModel.dart';
import 'package:movie_app/Models/GenreModel.dart';

class Movie{

  String id;
  String name;
  String imagePathBackdrop;
  String imagePathPoster;
  String description;
  List<String> genresList;
  String date;
  List<Cast> castList = [];

  Movie(this.name, this.imagePathBackdrop, this.imagePathPoster,
      this.description, this.genresList, this.date,this.id);

  getGenre(){
    String gen  = '';
    for(int i = 0; i < genresList.length; i++){
      if(i == genresList.length-1){
        gen += genresList[i];
      }else{
        gen += genresList[i]+', ';

      }
    }
    return gen;
  }

  getDate(){
    String year = '';

    for(int i = 0; i<4;i++){
      year+=date[i];
    }

    return year;
  }

  Map<String, dynamic> toMap(){
    return {
      'name':name,
      'imagePathBackdrop':imagePathBackdrop,
      'imagePathPoster':imagePathPoster,
      'description':description,
      'genresList':genresList.join(','),
      'date':date,
      'id':id,


    };
  }

  factory Movie.fromMap(Map<String, dynamic> json) => new Movie(
    json['name'],
    json['imagePathBackdrop'],
    json['imagePathPoster'],
    json['description'],
    json['genresList'].split(','),
    json['date'],
    json['id'],
  );

  @override
  String toString() {
    return 'Movie{name: $name, imagePathBackdrop: $imagePathBackdrop, imagePathPoster: $imagePathPoster, description: $description, genresList: $genresList, date: $date}';
  }
}