import 'package:flutter/material.dart';
import 'package:movich/model/media/genre_data.dart';
import 'package:movich/model/result.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movich/helpers/constants.dart';
import 'package:movich/widgets/lists/horizontal_list.dart';
import 'package:movich/widgets/rating_bar.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({required this.result, Key? key}) : super(key: key);
  final Result result;

  bool isTitleSame() {
    return result.title == result.originalTitle;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              AspectRatio(
                aspectRatio: 1.8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Stack(
                    children: [
                      Center(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/original/${result.backdropPath}',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const SpinKitPianoWave(
                            color: Colors.white,
                            size: 50.0,
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 50.0,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 8,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                              color: Colors.grey.shade200.withOpacity(0.3),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xFF08161a),
                              size: 27,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  result.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontFamily: 'Oxygen',
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _showOriginalTitle(),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    result.releaseDate.year.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  const Text(
                    ' \u25CF ',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    GenreData(result.mediaType)
                        .getGenreNames(result.genreIds)
                        .join(", "),
                    style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar(
                    rating: result.voteAverage,
                  ),
                ],
              ),
              description('Overview', result.overview),
              description('Original Language', result.originalLanguage),
              description('Release Date',
                  "${result.releaseDate.year}-${result.releaseDate.month}-${result.releaseDate.day}"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Recommendations :',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'OpenSans',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: HorizontalList(
                  mediaType: result.mediaType,
                  mediaListType: MediaListType.recommendations,
                  movieId: result.id,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showOriginalTitle() {
    return isTitleSame()
        ? const SizedBox()
        : Center(
            child: Text(
              result.originalTitle,
              style: TextStyle(
                fontFamily: 'Oxygen',
                color: Colors.grey.shade300,
              ),
            ),
          );
  }

  Widget description(String descriptionTitle, String description) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            '$descriptionTitle:',
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'OpenSans',
            ),
          ),
          Text(
            description,
            style: TextStyle(
              fontFamily: 'OpenSans',
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
