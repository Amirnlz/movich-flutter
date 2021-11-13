import 'package:flutter/material.dart';
import 'package:movich/helpers/constants.dart';
import 'package:movich/model/result.dart';
import 'package:movich/model/data/media_data.dart';
import 'package:movich/widgets/lists/items/horizontal_list_item.dart';
import 'package:movich/widgets/shimmer_widget.dart';

class HorizontalList extends StatefulWidget {
  final MediaType mediaType;
  final MediaListType mediaListType;
  final int pageNumber;
  final int movieId;

  const HorizontalList({
    Key? key,
    required this.mediaType,
    required this.mediaListType,
    this.pageNumber = 1,
    this.movieId = 0,
  }) : super(key: key);

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  List<Result> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    print('isLoading: $isLoading media: ${mediaTypeList.toString()}');
    List<Result> getResult = await _getSpecificList();
    setState(() {
      isLoading = false;
      results = getResult;
    });
  }

  Future<List<Result>> _getSpecificList() async {
    return widget.mediaListType != MediaListType.recommendations
        ? MediaData().getSpecificList(
            widget.mediaType,
            widget.mediaListType,
            widget.pageNumber,
          )
        : MediaData().getRecommendedList(
            widget.mediaType,
            widget.movieId,
          );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: isLoading ? 20 : results.length,
        itemBuilder: (context, int index) {
          final result = isLoading ? null : results[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: AspectRatio(
              aspectRatio: 0.6,
              child: isLoading
                  ? const ShimmerWidget().shimmerItemHorizontal()
                  : HorizontalListItem(result: result!),
            ),
          );
        },
      ),
    );
  }
}
