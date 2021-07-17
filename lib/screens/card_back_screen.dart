import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix/bloc/movie_bloc.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/model/movie_response.dart';
import 'package:netflix/style/theme.dart' as Style;

class CardBack extends StatefulWidget {
  const CardBack({Key? key}) : super(key: key);

  @override
  _CardBackState createState() => _CardBackState();
}

class _CardBackState extends State<CardBack> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: movieBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
            return Center(
              child: Text(
                snapshot.data!.error,
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            );
          }
          return _buildMovieWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(""),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.grey[400]),
          );
        }
      },
    );
  }

  Widget _buildMovieWidget(MovieResponse data) {
    MovieModel movie = data.movie;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            color: Colors.grey[400],
            image: DecorationImage(
                image: NetworkImage("https://img.reelgood.com/content/movie/" +
                    movie.id +
                    "/poster-780.webp"),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.9),
                Colors.black.withOpacity(0.0)
              ],
              stops: [0.0, 0.5],
            ),
          ),
        ),
        Positioned(
            top: 10.0,
            right: 10.0,
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  color: Colors.black45),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.imdb,
                    color: Style.Colors.imdbColor,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    movie.imdbRate.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  )
                ],
              ),
            )),
        Positioned(
          bottom: 50.0,
          left: 10.0,
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  movie.overview,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          EvaIcons.clockOutline,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          movie.duration.toString() + "min",
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          EvaIcons.calendarOutline,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          movie.releaseDate.substring(0, 10),
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
