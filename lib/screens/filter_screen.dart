import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  static const String id = 'FilterScreen';
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('Filter'),
        ),
      ),
    );
  }
}
