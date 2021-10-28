import 'package:flutter/material.dart';
import 'package:movich/model/data/media_data.dart';
import 'package:movich/model/results.dart';
import 'package:movich/utilities/constants.dart';
import 'package:movich/widgets/lists/items/vertical_list_item.dart';
import 'package:movich/widgets/shimmer_widget.dart';

class VerticalList extends StatefulWidget {
  const VerticalList({Key? key}) : super(key: key);

  @override
  _VerticalListState createState() => _VerticalListState();
}

class _VerticalListState extends State<VerticalList> {
  List<Results> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    List<Results> getResult =
        await MediaData().getTrendingList(MediaType.movie, TimeWindow.week, 1);
    setState(() {
      isLoading = false;
      results = getResult;
    });
  }

  List<VerticalListItem> getItems() {
    List<VerticalListItem> items = [];
    for (int i = 0; i < results.length; i++) {
      items.add(VerticalListItem(results: results[i]));
    }
    return items;
  }

  List<Widget> getShimmerWidgets() {
    List<Widget> items = [];
    for (int i = 0; i < 10; i++) {
      items.add(const ShimmerWidget().shimmerItemVertical());
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: isLoading ? getShimmerWidgets() : getItems(),
    );
  }
}
