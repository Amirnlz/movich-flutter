import 'dart:convert';
import 'result.dart';

PageData pageDataFromJson(String str) => PageData.fromJson(json.decode(str));

String pageDataToJson(PageData data) => json.encode(data.toJson());

class PageData {
  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  PageData({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PageData.fromJson(Map<String, dynamic> json) => PageData(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
