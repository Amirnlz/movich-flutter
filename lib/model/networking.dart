import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';

const apiKey = '110a1b0c';
const siteUrl = 'https://www.omdbapi.com/';

class Networking {
  final String imdbId;

  Networking({required this.imdbId});

  Future<Movie> requestDetails() async {
    var requestURL = Uri.parse('$siteUrl?apikey=$apiKey&i=$imdbId');
    http.Response response = await http.get(requestURL);
    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
      print(decodeJson['Title']);
      return Movie(
        decodeJson['Poster'],
        decodeJson['Title'],
        decodeJson['Plot'],
        decodeJson['imdbRating'],
        decodeJson['Genre'],
        decodeJson['Released'],
        decodeJson['Runtime'],
      );
    } else {
      throw 'Problem with get request with ${response.statusCode} code';
    }
  }
}
