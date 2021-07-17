import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:netflix/bloc/movie_bloc.dart';
import 'package:netflix/model/item.dart';
import 'package:netflix/screens/card_back_screen.dart';
import 'package:netflix/screens/card_front_screen.dart';
import 'package:netflix/style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool clicked = false;
  late ItemModel _selectedGenre;
  late ItemModel _selectedScore;
  late List<ItemModel> genres;
  late List<ItemModel> scores;
  @override
  void initState() {
    scores = [
      ItemModel(title: "Any Score", value: 0),
      ItemModel(title: "5", value: 5),
      ItemModel(title: "6", value: 6),
      ItemModel(title: "7", value: 7),
      ItemModel(title: "8", value: 8),
    ];

    genres = [
      ItemModel(title: 'All Genres', value: 19),
      ItemModel(title: "Action", value: 5),
      ItemModel(title: "Animation", value: 6),
      ItemModel(title: "Anime", value: 39),
      ItemModel(title: "Comedy", value: 9),
      ItemModel(title: "Drama", value: 3),
      ItemModel(title: "Horror", value: 19),
    ];
    _selectedGenre = genres[0];
    _selectedScore = scores[0];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text(
          "What should i watch?",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Container(
          child: FlipCard(
            front: CardFront(),
            back: CardBack(),
            key: cardKey,
            flipOnTouch: false,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        padding: EdgeInsets.all(15.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            clicked
                ? Container()
                : Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Genre",
                            style: TextStyle(
                                color: Style.Colors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5.0),
                            height: 30.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  color: Style.Colors.mainColor, width: 1.0),
                            ),
                            child: Theme(
                              data: ThemeData(canvasColor: Colors.white),
                              child: DropdownButton<ItemModel>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Style.Colors.mainColor,
                                  ),
                                  isExpanded: false,
                                  underline: Container(),
                                  hint: Text(
                                    "",
                                    style: TextStyle(),
                                  ),
                                  value: _selectedGenre,
                                  onChanged: (ItemModel? newValue) {
                                    setState(() {
                                      _selectedGenre = newValue!;
                                    });
                                  },
                                  items: genres.map((ItemModel filter) {
                                    return DropdownMenuItem<ItemModel>(
                                      value: filter,
                                      child: Row(
                                        children: [
                                          Text(
                                            filter.title,
                                            style: TextStyle(
                                                color: Style.Colors.mainColor,
                                                fontSize: 14.0),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Min Score",
                            style: TextStyle(
                                color: Style.Colors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5.0),
                            height: 30.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  color: Style.Colors.mainColor, width: 1.0),
                            ),
                            child: Theme(
                              data: ThemeData(canvasColor: Colors.white),
                              child: DropdownButton<ItemModel>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Style.Colors.mainColor,
                                  ),
                                  isExpanded: false,
                                  underline: Container(),
                                  hint: Text(
                                    "",
                                    style: TextStyle(),
                                  ),
                                  value: _selectedScore,
                                  onChanged: (ItemModel? newValue) {
                                    setState(() {
                                      _selectedScore = newValue!;
                                    });
                                  },
                                  items: scores.map((ItemModel filter) {
                                    return DropdownMenuItem<ItemModel>(
                                      value: filter,
                                      child: Row(
                                        children: [
                                          Text(
                                            filter.title,
                                            style: TextStyle(
                                                color: Style.Colors.mainColor,
                                                fontSize: 14.0),
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            clicked
                ? Container(
                    height: 40.0,
                    child: RaisedButton(
                      color: Style.Colors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: () {
                        setState(() {
                          clicked = false;
                        });
                        movieBloc..drainStream();
                        cardKey.currentState!.toggleCard();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            EvaIcons.arrowBackOutline,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 40.0,
                    child: RaisedButton(
                      color: Style.Colors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: () {
                        movieBloc
                          ..getMovie(
                              _selectedGenre.value, _selectedScore.value);
                        setState(() {
                          clicked = true;
                        });
                        cardKey.currentState!.toggleCard();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(EvaIcons.search, color: Colors.white),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Suggest',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
