import 'package:movich/helpers/constants.dart';
import 'package:movich/helpers/enum_values.dart';

class Result {
  final int id;
  final List<int> genreIds;
  final String originalLanguage;
  final double voteAverage;
  final String? posterPath;
  final String overview;
  final String? backdropPath;
  final MediaType mediaType;
  final String originalTitle;
  final DateTime releaseDate;
  final String title;

  Result({
    required this.id,
    required this.genreIds,
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json['title'] ?? json['name'],
        overview: json['overview'],
        releaseDate: json['release_date'] == null
            ? DateTime.parse(json['first_air_date'])
            : DateTime.parse(json['release_date']),
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'] ?? json['original_name'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average'].toDouble(),
        mediaType: json['title'] == null ? MediaType.tv : MediaType.movie,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'overview': overview,
        'release_date':
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        'backdrop_path': backdropPath,
        'genre_ids': List<dynamic>.from(genreIds.map((x) => x)),
        'id': id,
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'poster_path': posterPath,
        'vote_average': voteAverage,
        'media_type': mediaTypeValues.reverse[mediaType],
      };
}

final mediaTypeValues = EnumValues({
  'movie': MediaType.movie,
  'tv': MediaType.tv,
});
