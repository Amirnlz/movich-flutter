import 'package:http/http.dart' as http;
import 'package:movich/model/genre_data.dart';
import 'dart:convert';
import 'package:movich/utilities/constants.dart';
import 'package:movich/model/page_data.dart';
import 'package:movich/model/results.dart';

class Network {
  final MediaType mediaType;
  final MediaListType mediaListType;
  late final String title;
  late final String orgTitle;
  late final String releaseDate;
  int pageNumber;
  TimeWindow timeWindow;

  Network({
    required this.mediaType,
    this.timeWindow = TimeWindow.week,
    required this.mediaListType,
    this.pageNumber = 1,
  });

  Future<PageData> getRequestPage() async {
    var trendUrl = _getUrl();
    final response = await _getResponse(trendUrl);
    print('trend: ${response.statusCode}');
    var decodeJson = jsonDecode(response.body);
    List<Results> results = await _setResults(decodeJson['results']);
    return PageData(
        page: decodeJson['page'],
        results: results,
        totalPages: decodeJson['total_pages'],
        totalResults: decodeJson['total_results']);
  }

  String _getUrl() {
    if (mediaListType == MediaListType.trending) {
      return '$apiUrl/${mediaListType.toShortString()}/${mediaType.toShortString()}'
          '/${timeWindow.toShortString()}'
          '?api_key=$apiKey&page=$pageNumber';
    } else {
      return '$apiUrl/${mediaType.toShortString()}/${mediaListType.toShortString()}'
          '?api_key=$apiKey&page=$pageNumber';
    }
  }

  Future<http.Response> _getResponse(var url) async {
    http.Response response = await http.get(Uri.parse(url));
    int responseCode = response.statusCode;
    return responseCode == 200
        ? response
        : throw ('Response failed with $responseCode code}');
  }

  Future<List<Results>> _setResults(var resultsJson) async {
    List<Results> results = [];
    _setMovieOrTvKeys();
    for (int i = 0; i < resultsJson.length; i++) {
      List<int> genreIds = resultsJson[i]['genre_ids'].cast<int>();
      List<String> genreNames = await getGenresName(genreIds);
      results.add(
        Results(
          id: resultsJson[i]['id'],
          mediaGenre: genreNames,
          originalLanguage: resultsJson[i]['original_language'],
          voteAverage: resultsJson[i]['vote_average'].toDouble(),
          posterPath: resultsJson[i]['poster_path'],
          overview: resultsJson[i]['overview'],
          backdropPath: resultsJson[i]['backdrop_path'],
          mediaType: mediaType,
          originalTitle: resultsJson[i][orgTitle],
          releaseDate: resultsJson[i][releaseDate],
          title: resultsJson[i][title],
        ),
      );
    }
    return results;
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
