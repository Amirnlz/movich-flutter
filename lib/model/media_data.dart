import 'package:movich/utilities/constants.dart';
import 'package:movich/service/network.dart';
import 'page_data.dart';
import 'results.dart';

class MediaData {
  //TODO: should save pages in map
  //TODO: in map page should save result list and return requested result

  Future<List<Results>> getMediaList(
      MediaType mediaType, MediaListType mediaListType) async {
    Network networking = Network(
      mediaType: mediaType,
      timeWindow: TimeWindow.week,
      mediaListType: mediaListType,
      pageNumber: 1,
    );
    PageData pageData = await networking.getRequestPage();

    return pageData.results;
  }
}
