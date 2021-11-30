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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              AspectRatio(
                aspectRatio: 1.8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Stack(
                    children: [
                      Hero(
                        tag: result.id,
                        child: Center(
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
              SizedBox(height: size.height * 0.01),
              Center(
                child: Text(
                  result.title,
                  style: const TextStyle(
                    fontSize: 26,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _showOriginalTitle(),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    result.releaseDate.year.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    ' \u25CF ',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      GenreData(result.mediaType)
                          .getGenreNames(result.genreIds)
                          .join(", "),
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
              SizedBox(height: size.height * 0.01),
              description('Overview:', result.overview),
              SizedBox(height: size.height * 0.01),
              description('Original Language:', result.originalLanguage),
              SizedBox(height: size.height * 0.01),
              description('Release Date:',
                  "${result.releaseDate.year}-${result.releaseDate.month}-${result.releaseDate.day}"),
              SizedBox(height: size.height * 0.01),
              const Text(
                'Recommendations:',
                style: TextStyle(
                  fontSize: 15,
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
              SizedBox(height: size.height * 0.08),
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
          Text(
            descriptionTitle,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
