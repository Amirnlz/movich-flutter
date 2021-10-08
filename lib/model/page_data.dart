import 'dart:collection';

import 'results.dart';

class PageData {
  final int page;
  final List<Results> _results;
  final int totalPages;
  final int totalResults;

  PageData({
    required this.page,
    required List<Results> results,
    required this.totalPages,
    required this.totalResults,
  }) : _results = results;

  UnmodifiableListView<Results> get results => UnmodifiableListView(_results);
}
