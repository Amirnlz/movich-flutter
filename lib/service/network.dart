import 'package:http/http.dart' as http;
import 'package:movich/model/data/genre_data.dart';
import 'dart:convert';
import 'package:movich/utilities/constants.dart';
import 'package:movich/model/page_data.dart';
import 'package:movich/model/results.dart';

class Network {
  late final MediaType mediaType;
  late final String title;
  late final String orgTitle;
  late final String releaseDate;

  Future<PageData> getRecommendedMedia(MediaType mediaType, int mediaId) async {
    this.mediaType = mediaType;
    String url = '$apiUrl/${mediaType.toShortString()}'
        '/$mediaId'
        '/recommendations'
        '?api_key=$apiKey'
        '&page=1';
    print('recommendations: $url');

    return getRequestPage(url);
  }

  Future<PageData> getTrending(
      MediaType mediaType, TimeWindow timeWindow, int pageNumber) async {
    this.mediaType = mediaType;
    String url = '$apiUrl/trending'
        '/${mediaType.toShortString()}'
        '/${timeWindow.toShortString()}'
        '?api_key=$apiKey'
        '&page=$pageNumber';
    print('trending: $url');
    return getRequestPage(url);
  }

  Future<PageData> getTopRated(MediaType mediaType, int pageNumber) async {
    this.mediaType = mediaType;
    String url = '$apiUrl/${mediaType.toShortString()}'
        '/top_rated'
        '?api_key=$apiKey'
        '&page=$pageNumber';
    print('top_rated: $url');

    return getRequestPage(url);
  }

  Future<PageData> getRequestPage(String url) async {
    final response = await _getResponse(url);
    var decodeJson = jsonDecode(response.body);
    List<Results> results = await _getResultsList(decodeJson['results']);
    return PageData(
        page: decodeJson['page'],
        results: results,
        totalPages: decodeJson['total_pages'],
        totalResults: decodeJson['total_results']);
  }

  Future<http.Response> _getResponse(var url) async {
    http.Response response = await http.get(Uri.parse(url));
    int responseCode = response.statusCode;
    return responseCode == 200
        ? response
        : throw ('Response failed with $responseCode code}');
  }

  Future<List<Results>> _getResultsList(var resultsJson) async {
    List<Results> resultsList = [];
    _setMovieOrTvKeys();
    for (int i = 0; i < resultsJson.length; i++) {
      Results result = await _setResults(resultsJson[i]);
      resultsList.add(result);
    }
    return resultsList;
  }

  Future<Results> _setResults(var results) async {
    List<int> genreIds = results['genre_ids'].cast<int>();
    List<String> genreNames = await getGenresName(genreIds);
    String voteAverage = results['vote_average'].toStringAsFixed(1);
    return Results(
      id: results['id'],
      mediaGenre: genreNames,
      originalLanguage: results['original_language'],
      voteAverage: double.parse(voteAverage),
      posterPath: results['poster_path'],
      overview: results['overview'],
      backdropPath: results['backdrop_path'],
      mediaType: mediaType,
      originalTitle: results[orgTitle],
      releaseDate: results[releaseDate],
      title: results[title],
    );
  }

  void _setMovieOrTvKeys() {
    title = mediaType == MediaType.movie ? 'title' : 'name';
    orgTitle =
        mediaType == MediaType.movie ? 'original_title' : 'original_name';
    releaseDate =
        mediaType == MediaType.movie ? 'release_date' : 'first_air_date';
  }

  Future<List<String>> getGenresName(List<int> genreIds) async {
    GenreData genreData = GenreData(mediaType);
    List<String> genreNames = await genreData.getGenresName(genreIds);
    return genreNames;
  }
}
