import 'package:networkapi/networkapi.dart';

class Repository {
  final apiProvider = ApiProvider();
  Future<Movie> fetchAllMoview() => apiProvider.getMovieList();
}
