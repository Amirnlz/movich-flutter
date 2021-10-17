import 'package:flutter/material.dart';
import 'package:movich/utilities/constants.dart';
import 'package:movich/model/results.dart';
import 'package:movich/model/media_data.dart';
import 'package:movich/widgets/rating_bar.dart';
import 'package:movich/widgets/shimmer_widget.dart';

class CarouselList extends StatefulWidget {
  final MediaType mediaType;
  final MediaListType mediaListType;

  const CarouselList({
    Key? key,
    required this.mediaType,
    required this.mediaListType,
  }) : super(key: key);

  @override
  State<CarouselList> createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList> {
  List<Results> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    print('is empty: ${results.isEmpty}');
    List<Results> getResult = await MediaData().getMediaList(
      widget.mediaType,
      widget.mediaListType,
    );
    setState(() {
      isLoading = false;
      results = getResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6 / 5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: isLoading ? 20 : results.length,
        itemBuilder: (context, int index) {
          return AspectRatio(
            aspectRatio: 0.57,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0.0, 5.0, 15.0, 0.0),
              child: isLoading ? shimmerColumn() : buildItems(results[index]),
            ),
          );
        },
      ),
    );
  }

  Widget shimmerColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ShimmerWidget(
          height: 220,
        ),
        SizedBox(
          height: 8,
        ),
        ShimmerWidget(
          height: 10,
          width: 100,
        ),
        SizedBox(
          height: 5,
        ),
        ShimmerWidget(
          height: 10,
          width: 150,
        ),
      ],
    );
  }

  Widget buildItems(Results result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 8 / 11,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://image.tmdb.org/t/p/w200${result.posterPath}',
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          result.title,
          style: const TextStyle(
            fontSize: 15,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          result.mediaGenre.join(', '),
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: 3,
        ),
        RatingBar(rating: result.voteAverage),
      ],
    );
  }
}
