import 'package:movich/helpers/constants.dart';
import 'package:movich/helpers/genres_list.dart';

class GenreData {
  GenreData(this.mediaType);

  final MediaType mediaType;
  final List<String> genreNames = [];

  List<String> getGenreNames(List<int> genreIds) {
    for (int i = 0; i < genreIds.length; i++) {
      String name = _getName(genreIds[i])!;
      genreNames.add(name);
    }
    return genreNames;
  }

  String? _getName(int id) =>
      mediaType == MediaType.movie ? _getMovieGenre(id) : _getTVGenre(id);

  String? _getMovieGenre(int id) => movieGenres[id];

  String? _getTVGenre(int id) => tvGenres[id];
}
