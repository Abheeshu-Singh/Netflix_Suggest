import 'package:flutter/material.dart';
import 'package:netflix/model/movie_response.dart';
import 'package:netflix/repositories/repository.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:rxdart/subjects.dart';

class MovieBloc {
  final UserRepository _repository = UserRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovie(int genre, int miniImdb) async {
    MovieResponse response = await _repository.getMovie(genre, miniImdb);
    _subject.sink.add(response);
  }

  void drainStream() {}

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final movieBloc = MovieBloc();
