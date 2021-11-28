import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:iconsax/iconsax.dart';
import 'package:movich/helpers/constants.dart';
import 'package:movich/widgets/custom_text_field.dart';
import 'package:movich/widgets/lists/vertical_list.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'SearchScreen';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _yearController = TextEditingController();

  final TextEditingController _langController = TextEditingController();
  Widget _searchListMovie = const SizedBox();
  Widget _searchListTV = const SizedBox();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                CustomTextField(
                  widthSize: screenSize.width,
                  controller: _titleController,
                  hintText: "Search movie & TV",
                  iconData: Iconsax.filter_search4,
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                      widthSize: screenSize.width * 0.45,
                      controller: _yearController,
                      hintText: "Year",
                      keyboardType: TextInputType.number,
                    ),
                    CustomTextField(
                      widthSize: screenSize.width * 0.45,
                      controller: _langController,
                      hintText: "Languages",
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                SizedBox(
                  width: screenSize.width * 0.6,
                  child: NeumorphicButton(
                    onPressed: () {
                      setState(() {
                        _searchListMovie = VerticalList(
                          media: MediaType.movie,
                          mediaList: MediaListType.search,
                          pageNumber: 1,
                          year: int.parse(_yearController.text),
                          lang: _langController.text,
                          query: _titleController.text.trim(),
                        );
                        _searchListTV = VerticalList(
                          media: MediaType.tv,
                          mediaList: MediaListType.search,
                          pageNumber: 1,
                          year: int.parse(_yearController.text),
                          lang: _langController.text,
                          query: _titleController.text.trim(),
                        );
                      });
                      // print(_titleController.text);
                      // _titleController.clear();
                      // _yearController.clear();
                      // _langController.clear();
                    },
                    style: kButtonNeumorphicStyle,
                    child: const Text(
                      "Search",
                      style: TextStyle(
                        fontFamily: 'Oxygen',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.04,
                ),
                SizedBox(child: _searchListTV),
                SizedBox(child: _searchListMovie),
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
