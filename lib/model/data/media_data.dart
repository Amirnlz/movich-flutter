import 'package:movich/helpers/constants.dart';
import 'package:movich/service/network.dart';
import '../page_data.dart';
import '../result.dart';

class MediaData {
  //TODO: should save pages in map
  //TODO: in map page should save result lists and return requested result

  final Network _network = Network();

  Future<List<Result>> getSpecificList(
      MediaType mediaType, MediaListType mediaListType, int page) async {
    if (mediaListType == MediaListType.trending) {
      return await _getTrendingList(mediaType, TimeWindow.week, page);
    } else {
      return await _getTopRatedList(mediaType, page);
    }
  }

  Future<List<Result>> _getTrendingList(
      MediaType mediaType, TimeWindow timeWindow, int page) async {
    PageData pageData = await _network.getTrending(mediaType, timeWindow, page);

    return pageData.results;
  }

  Future<List<Result>> _getTopRatedList(MediaType mediaType, int page) async {
    PageData pageData = await _network.getTopRated(mediaType, page);

    return pageData.results;
  }

  Future<List<Result>> getRecommendedList(
      MediaType mediaType, int movieId) async {
    PageData pageData = await _network.getRecommendedMedia(mediaType, movieId);

    return pageData.results;
  }

  Future<List<Result>> getSearchQuery(
      MediaType mediaType, String query, String lang, int year) async {
    PageData pageData =
        await _network.getSearchQuery(mediaType, query, lang, year);

    return pageData.results;
  }
}
