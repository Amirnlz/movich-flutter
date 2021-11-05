import 'package:movich/utilities/constants.dart';
import 'package:movich/service/network.dart';
import '../page_data.dart';
import '../results.dart';

class MediaData {
  //TODO: should save pages in map
  //TODO: in map page should save result lists and return requested result

  final Network _network = Network();

  Future<List<Results>> getSpecificList(
      MediaType mediaType, MediaListType mediaListType, int pageNumber) async {
    if (mediaListType == MediaListType.trending) {
      return await _getTrendingList(mediaType, TimeWindow.week, pageNumber);
    } else {
      return await _getTopRatedList(mediaType, pageNumber);
    }
  }

  Future<List<Results>> _getTrendingList(
      MediaType mediaType, TimeWindow timeWindow, int pageNumber) async {
    PageData pageData =
        await _network.getTrending(mediaType, timeWindow, pageNumber);

    return pageData.results;
  }

  Future<List<Results>> _getTopRatedList(
      MediaType mediaType, int pageNumber) async {
    PageData pageData = await _network.getTopRated(mediaType, pageNumber);

    return pageData.results;
  }

  Future<List<Results>> getRecommendedList(
      MediaType mediaType, int movieId) async {
    PageData pageData = await _network.getRecommendedMedia(mediaType, movieId);

    return pageData.results;
  }
}
