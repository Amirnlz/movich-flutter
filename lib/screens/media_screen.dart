import 'package:flutter/material.dart';
import 'package:movich/model/results.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movich/utilities/constants.dart';
import 'package:movich/widgets/carousel_list.dart';
import 'package:movich/widgets/rating_bar.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({required this.results, Key? key}) : super(key: key);
  final Results results;

  bool isTitleSame() {
    return results.title == results.originalTitle;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${results.backdropPath}',
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
                    Positioned(
                      top: 5,
                      left: 8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey.shade400,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  results.title,
                  style: const TextStyle(
                    fontSize: 26,
                    fontFamily: 'Oxygen',
                    letterSpacing: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Center(
                child: Text(
                  isTitleSame() ? "" : results.originalTitle,
                  style: TextStyle(
                    fontFamily: 'Oxygen',
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    results.releaseDate.split("-").first,
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
                    " ${results.mediaGenre.join(", ")}",
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
                    rating: results.voteAverage,
                  ),
                ],
              ),
              description('Overview', results.overview),
              description('Original Language', results.originalLanguage),
              description('Release Date', results.releaseDate),
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
              CarouselList(
                mediaType: results.mediaType,
                mediaListType: MediaListType.recommendations,
                mediaId: results.id,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget description(String descriptionTitle, String description) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
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
