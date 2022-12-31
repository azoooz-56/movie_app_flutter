import 'package:http/http.dart' as http;
import 'package:movie_app/Models/CastModel.dart';
import 'package:movie_app/Models/GenreModel.dart';
import 'dart:convert' as convert;

import 'package:movie_app/Models/MovieModel.dart';

class CreditApis {
  Movie movie;

  CreditApis(this.movie);

  getCastsApis() async {
    String id = movie.id;
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=1031edf9ff286ae5fb5ee183fb176ff4&language=en-US'));

    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(response.body);
    if (response.statusCode == 200) {
      List listCredits = jsonResponse["cast"];

      for (int i = 0; i < listCredits.length; i++) {
        print('azoo');
        print(listCredits[i]['original_name'] );
        if(listCredits[i]['profile_path'] == null){
          continue;
        }
        print(listCredits.toString());
        Cast cast = Cast(
            name: listCredits[i]['name'],
            pathImage: 'https://image.tmdb.org/t/p/w500' + listCredits[i]['profile_path'] as String);
        movie.castList.add(cast);

      }

      return movie.castList;
    }
  }
}
