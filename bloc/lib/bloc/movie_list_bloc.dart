import 'package:rxdart/rxdart.dart';
import 'package:networkapi/networkapi.dart';
import 'package:repository/repository/repository.dart';

class MovieListBloc {
  final _repository = Repository();
  final _movieFetcher = PublishSubject<Movie>();

  // Observable<List<Movie>> get allMovie => _movieFetcher.stream;
  Observable<Movie> get allMovie => _movieFetcher.stream;
  fetchAllMovie() async {
    Movie movie = await _repository.fetchAllMoview();
    _movieFetcher.sink.add(movie);
  }

  dispose() {
    _movieFetcher.close();
  }
}
