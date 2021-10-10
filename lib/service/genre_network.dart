import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movich/utilities/constants.dart';

class GenreNetwork {
  final MediaType mediaType;
  final Map<int, String> _genresMap = {};

  GenreNetwork(this.mediaType);

  Future<Map<int, String>> getGenreMap() async {
    http.Response response = await _getResponse();
    if (response.statusCode == 200) {
      var genres = jsonDecode(response.body)['genres'];
      _addFromJsonToMap(genres);
    }
    return _genresMap;
  }

  Future<http.Response> _getResponse() async {
    var genreUrl =
        '$apiUrl/genre/${mediaType.toShortString()}/list?api_key=$apiKey';
    http.Response response = await http.get(Uri.parse(genreUrl));
    return response;
  }

  void _addFromJsonToMap(var genreJson) {
    for (int i = 0; i < genreJson.length; i++) {
      int genreId = genreJson[i]['id'];
      String genreName = genreJson[i]['name'];
      _genresMap[genreId] = genreName;
    }
  }
}
