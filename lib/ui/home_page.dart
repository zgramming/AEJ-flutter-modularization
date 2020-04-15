import 'package:flutter/material.dart';
import 'package:networkapi/model/movie.dart';
import 'package:networkapi/network/api_provider.dart';
import 'package:flutter_modularization/ui/detail_page.dart';
import 'package:flutter_modularization/widget/card_list_movie.dart';
import 'package:flutter_modularization/widget/chip_genre_movie.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(58, 66, 86, 1.0)),
        ),
      ),
      body: getListMovie(),
    );
  }

  getListMovie() {
    return Container(
      child: Center(
        child: FutureBuilder(
          future: ApiProvider().getMovieList(),
          builder: (context, AsyncSnapshot<Movie> snapshot) {
            if (snapshot.hasData) {
              return showListMovie(snapshot);
            } else if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: TextStyle(color: Color.fromRGBO(58, 66, 86, 1.0)),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(58, 66, 86, 1.0)),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget showListMovie(AsyncSnapshot<Movie> snapshot) => ListView.builder(
        itemCount: snapshot == null ? 0 : snapshot.data.results.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: CardListMovies(
              image:
                  'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
              title: snapshot.data.results[index].title,
              vote: snapshot.data.results[index].voteAverage,
              releaseDate: snapshot.data.results[index].releaseDate,
              overview: snapshot.data.results[index].overview,
              genre: snapshot.data.results[index].genreIds
                  .take(3)
                  .map(buildGenreChip)
                  .toList(),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 777),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return DetailPage(
                        title: snapshot.data.results[index].title,
                        imagePoster:
                            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
                        rating: double.parse(
                            snapshot.data.results[index].voteAverage),
                        imageBanner:
                            'https://image.tmdb.org/t/p/original${snapshot.data.results[index].backdropPath}',
                        genre: snapshot.data.results[index].genreIds
                            .take(3)
                            .map(buildGenreChip)
                            .toList(),
                        overview: snapshot.data.results[index].overview,
                      );
                    }),
              );
            },
          );
        },
      );
}
