import 'package:flutter/material.dart';
import 'package:movich/utilities/constants.dart';
import 'package:movich/widgets/lists/vertical_list.dart';
import 'package:movich/widgets/tag_choice.dart';

class ListScreen extends StatefulWidget {
  static const String id = 'FilterScreen';
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  int pageNumber = 1;
  int mediaTag = 0;
  int listTag = 0;
  MediaType selectedMedia = MediaType.movie;
  MediaListType selectedList = MediaListType.trending;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TagChoices(
                  options: mediaTypeList,
                  itemCallBack: (value) {
                    setState(() {
                      mediaTag = value!;
                      selectedMedia = mediaTypeList[mediaTag];
                    });
                  },
                  tag: mediaTag,
                ),
                TagChoices(
                  options: listTypeList,
                  itemCallBack: (value) {
                    setState(() {
                      listTag = value!;
                      selectedList = listTypeList[listTag];
                    });
                  },
                  tag: listTag,
                ),
                // const SizedBox(
                //   height: 30,
                // ),
                VerticalList(
                  media: selectedMedia,
                  mediaList: selectedList,
                  pageNumber: pageNumber,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (pageNumber >= 2) {
                          setState(() {
                            pageNumber--;
                          });
                          _scrollToTop();
                        }
                      },
                      child: const Icon(
                        Icons.navigate_before_rounded,
                        size: 35,
                      ),
                    ),
                    Text(
                      'Page number: $pageNumber',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Oxygen',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (pageNumber <= 101) {
                          setState(() {
                            pageNumber++;
                          });
                          _scrollToTop();
                        }
                      },
                      child: const Icon(
                        Icons.navigate_next_rounded,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
