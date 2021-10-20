import 'package:flutter/material.dart';
import 'package:movich/screens/media_screen.dart';
import 'package:movich/utilities/constants.dart';
import 'package:movich/model/results.dart';
import 'package:movich/model/media_data.dart';
import 'package:movich/widgets/rating_bar.dart';
import 'package:movich/widgets/shimmer_widget.dart';

class CarouselList extends StatefulWidget {
  final MediaType mediaType;
  final MediaListType mediaListType;
  final int mediaId;

  const CarouselList({
    Key? key,
    required this.mediaType,
    required this.mediaListType,
    this.mediaId = 0,
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
    _loadData();
  }

  Future _loadData() async {
    List<Results> getResult = await _getSpecificList();
    setState(() {
      isLoading = false;
      results = getResult;
    });
  }

  Future<List<Results>> _getSpecificList() async {
    if (widget.mediaListType == MediaListType.trending) {
      return await MediaData()
          .getTrendingList(widget.mediaType, TimeWindow.week, 1);
    } else if (widget.mediaListType == MediaListType.top_rated) {
      return await MediaData().getTopRatedList(widget.mediaType, 1);
    } else {
      return await MediaData()
          .getRecommendedList(widget.mediaType, widget.mediaId);
    }
  }

  bool _isListEmpty() {
    return results.isEmpty;
  }

  bool _isRecommendedListEmpty() {
    return _isListEmpty() &&
        isLoading == false &&
        MediaListType.recommendations == widget.mediaListType;
  }

  @override
  Widget build(BuildContext context) {
    return _isRecommendedListEmpty()
        ? SizedBox(
            height: 100,
            child: Text(
              'There is no Recommended media.',
              style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.grey.shade400,
              ),
            ),
          )
        : AspectRatio(
            aspectRatio: 6 / 5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: isLoading ? 20 : results.length,
              itemBuilder: (context, int index) {
                final result = isLoading ? null : results[index];
                return AspectRatio(
                  aspectRatio: 0.57,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 5.0, 15.0, 0.0),
                    child: isLoading ? shimmerColumn() : buildItems(result!),
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
        GestureDetector(
          onTap: () {
            print(result.title);
            print('id: ${result.id}');
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MediaScreen(results: result)),
            );
          },
          child: AspectRatio(
            aspectRatio: 8 / 11,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://image.tmdb.org/t/p/w200${result.posterPath}',
                fit: BoxFit.fill,
              ),
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
