import 'package:flutter/material.dart';
import 'package:movich/utilities/constants.dart';
import 'package:movich/widgets/single_choice.dart';
import 'package:movich/widgets/lists/vertical_list.dart';

class FilterScreen extends StatefulWidget {
  static const String id = 'FilterScreen';
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tagChoice('Media', mediaTypeList),
                tagChoice('List', listTypeList),
                const VerticalList(),
                const SizedBox(
                  height: 20,
                ),
                const VerticalList(),
                const Center(
                  child: Text('Here will show page numbers'),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Column tagChoice(String title, List<Enum> optionList) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Select $title: ',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      SingleChoice(options: optionList),
      const SizedBox(
        height: 10,
      ),
    ],
  );
}
