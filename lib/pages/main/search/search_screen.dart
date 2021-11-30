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

  bool isFilledText(String text, String year, String lang) {
    return text.isNotEmpty && year.isNotEmpty && lang.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.04,
                ),
                CustomTextField(
                  title: 'Title:',
                  width: size.width,
                  controller: _titleController,
                  hintText: "Search movie & TV",
                  iconData: Iconsax.filter_search4,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                      title: 'Year:',
                      width: size.width * 0.45,
                      controller: _yearController,
                      hintText: "Year",
                      keyboardType: TextInputType.number,
                    ),
                    CustomTextField(
                      title: 'Language:',
                      width: size.width * 0.45,
                      controller: _langController,
                      hintText: "Languages",
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: NeumorphicButton(
                    onPressed: () {
                      String text = _titleController.text.trim();
                      String year = _yearController.text;
                      String lang = _langController.text;
                      bool isFilled = isFilledText(text, year, lang);
                      if (isFilled) {
                        setState(() {
                          _searchListMovie = VerticalList(
                            media: MediaType.movie,
                            mediaList: MediaListType.search,
                            pageNumber: 1,
                            year: int.parse(year),
                            lang: lang,
                            query: text,
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
                      }
                    },
                    style: kButtonNeumorphicStyle,
                    child: const Text(
                      "Search",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                SizedBox(child: _searchListTV),
                SizedBox(child: _searchListMovie),
                SizedBox(
                  height: size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
