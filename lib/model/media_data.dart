import 'package:movich/utilities/constants.dart';

import 'package:movich/service/network.dart';
import 'page_data.dart';
import 'results.dart';

class MediaData {
  Future<List<Results>> getMediaList(
      MediaType mediaType, MediaListType mediaListType) async {
    Network networking = Network(
      mediaType: mediaType,
      timeWindow: TimeWindow.week,
      mediaListType: mediaListType,
    );
    PageData pageData = await networking.getRequestPage();

    return pageData.results;
  }
}
