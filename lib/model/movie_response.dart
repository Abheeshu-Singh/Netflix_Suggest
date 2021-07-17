import 'package:netflix/model/movie.dart';

class MovieResponse {
  final MovieModel movie;
  late final String error;

  MovieResponse(this.movie, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movie = MovieModel.fromJson(json),
        error = "";

  MovieResponse.withError(String errorValue)
      : movie = MovieModel("", "", "", "", "", "", 0, "", 0.0),
        error = errorValue;
}
