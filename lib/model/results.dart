import 'package:movich/utilities/constants.dart';

class Results {
  final int id;
  final List<String> mediaGenre;
  final String originalLanguage;
  final double voteAverage;
  final String posterPath;
  final String overview;
  final String? backdropPath;
  final MediaType mediaType;
  final String originalTitle;
  final String releaseDate;
  final String title;

  Results({
    required this.id,
    required this.mediaGenre,
    required this.originalLanguage,
    required this.voteAverage,
    required this.posterPath,
    required this.overview,
    required this.backdropPath,
    required this.mediaType,
    required this.originalTitle,
    required this.releaseDate,
    required this.title,
  });
}
