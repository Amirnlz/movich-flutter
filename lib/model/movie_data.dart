import 'dart:collection';
import 'package:movich/model/movie.dart';
import 'package:movich/model/networking.dart';
import 'package:movich/constants.dart';

class MovieData {
  final List<Movie> _seriesDetails = [];

  Future<void> createSeriesList() async {
    for (String movieId in popularSeries) {
      var detail = await Networking(imdbId: movieId).requestDetails();
      _seriesDetails.add(detail);
    }
  }

  UnmodifiableListView<Movie> get getSeriesList {
    return UnmodifiableListView(_seriesDetails);
  }
}
