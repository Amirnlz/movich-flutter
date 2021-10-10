import 'package:movich/service/genre_network.dart';
import 'package:movich/utilities/constants.dart';

class GenreData {
  MediaType mediaType;

  GenreData(this.mediaType);

  Future<List<String>> getGenresName(List<int> genreIds) async {
    List<String> names = await _searchOnList(genreIds);

    return names;
  }

  Future<List<String>> _searchOnList(List<int> genreIds) async {
    List<String> genreNames = [];
    for (int i = 0; i < genreIds.length; i++) {
      int genreId = genreIds[i];
      genreNames.add(await _whatIsGenreName(genreId));
    }
    return genreNames;
  }

  Future<String> _whatIsGenreName(int id) async {
    Map<int, String> genres = await GenreNetwork(mediaType).getGenreMap();
    return genres[id]!;
  }
}
