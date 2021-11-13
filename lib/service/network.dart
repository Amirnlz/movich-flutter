import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movich/helpers/constants.dart';
import 'package:movich/model/page_data.dart';

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
      MediaType mediaType, TimeWindow timeWindow, int page) async {
    this.mediaType = mediaType;
    String url = '$apiUrl/trending'
        '/${mediaType.toShortString()}'
        '/${timeWindow.toShortString()}'
        '?api_key=$apiKey'
        '&page=$page';
    print('trending: $url');
    return getRequestPage(url);
  }

  Future<PageData> getTopRated(MediaType mediaType, int page) async {
    this.mediaType = mediaType;
    String url = '$apiUrl/${mediaType.toShortString()}'
        '/top_rated'
        '?api_key=$apiKey'
        '&page=$page';
    print('top_rated: $url');
    return getRequestPage(url);
  }

  Future<PageData> getSearchQuery(
      MediaType mediaType, String query, String lang, int year) async {
    this.mediaType = mediaType;
    String url = '$apiUrl/search/${mediaType.toShortString()}'
        '/?api_key=$apiKey'
        '&language=$lang&query=$query&page=1&year=$year';
    print('search: $url');
    return getRequestPage(url);
  }

  Future<PageData> getRequestPage(String url) async {
    final response = await _getResponse(url);
    var decodeJson = jsonDecode(response.body);
    return PageData.fromJson(decodeJson);
  }

  Future<http.Response> _getResponse(var url) async {
    http.Response response = await http.get(Uri.parse(url));
    int responseCode = response.statusCode;
    print(responseCode);
    return responseCode == 200
        ? response
        : throw ('Response failed with $responseCode code}');
  }
}
