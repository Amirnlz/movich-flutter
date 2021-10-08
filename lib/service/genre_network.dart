import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movich/utilities/constants.dart';

class GenreNetwork {
  final MediaType mediaType;

  GenreNetwork(this.mediaType);

  Future<List<String>> getGenreListName(List<int> genreIds) async {
    List<String> genreNames = [];
    for (int i = 0; i < genreIds.length; i++) {
      genreNames.add(await _searchOnGenreJson(genreIds[i]));
    }
    return genreNames;
  }

  Future<String> _searchOnGenreJson(int id) async {
    Map<int, String> genres = await _getGenreMap();

    return genres[id]!;
  }

  Future<Map<int, String>> _getGenreMap() async {
    Map<int, String> genreMap = {};
    var genreUrl =
        '$apiUrl/genre/${mediaType.toShortString()}/list?api_key=$apiKey';
    print('genreUrl: $genreUrl');
    final response = await _getResponse(genreUrl);
    print('genre: ${response.statusCode}');
    if (response.statusCode == 200) {
      var genres = jsonDecode(response.body)['genres'];
      for (int i = 0; i < genres.length; i++) {
        int genreId = genres[i]['id'];
        String genreName = genres[i]['name'];
        genreMap[genreId] = genreName;
      }
    }
    return genreMap;
  }

  Future<http.Response> _getResponse(var url) async {
    http.Response response = await http.get(Uri.parse(url));
    int responseCode = response.statusCode;
    return responseCode == 200
        ? response
        : throw ('Response failed with $responseCode code}');
  }
}
