import 'package:flutter/material.dart';
import 'package:movich/utilities/constants.dart';
import 'package:movich/model/results.dart';
import 'package:movich/model/data/media_data.dart';
import 'package:movich/widgets/lists/items/horizontal_list_item.dart';
import 'package:movich/widgets/shimmer_widget.dart';

class HorizontalList extends StatefulWidget {
  final MediaType mediaType;
  final MediaListType mediaListType;
  final int mediaId;

  const HorizontalList({
    Key? key,
    required this.mediaType,
    required this.mediaListType,
    this.mediaId = 0,
  }) : super(key: key);

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
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

  //TODO: this function should be in model not here
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
