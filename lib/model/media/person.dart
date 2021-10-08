import 'package:movich/utilities/constants.dart';

class Person {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  Person({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });
}

class Result {
  final bool adult;
  final int gender;
  final String name;
  final int id;
  final List<KnownFor> knownFor;
  final KnownForDepartment knownForDepartment;
  final String profilePath;
  final double popularity;
  final ResultMediaType mediaType;

  Result({
    required this.adult,
    required this.gender,
    required this.name,
    required this.id,
    required this.knownFor,
    required this.knownForDepartment,
    required this.profilePath,
    required this.popularity,
    required this.mediaType,
  });
}

class KnownFor {
  final String backdropPath;
  final List<double> genreIds;
  final OriginalLanguage originalLanguage;
  final String originalTitle;
  final String posterPath;
  final bool video;
  final double voteAverage;
  final String title;
  final String overview;
  final double id;
  final double voteCount;
  final String releaseDate;
  final bool adult;
  final double popularity;
  final KnownForMediaType mediaType;
  final String originalName;
  final List<String> originCountry;
  final String firstAirDate;
  final String name;

  KnownFor({
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.posterPath,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.overview,
    required this.id,
    required this.voteCount,
    required this.releaseDate,
    required this.adult,
    required this.popularity,
    required this.mediaType,
    required this.originalName,
    required this.originCountry,
    required this.firstAirDate,
    required this.name,
  });
}
