//TODO: don't push key
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '';
const apiUrl = 'https://api.themoviedb.org/3';

enum MediaType { tv, movie }
enum MediaListType { trending, top_rated, recommendations, popular, search }
enum TimeWindow { day, week }
enum OriginalLanguage { en, sv }
enum KnownForMediaType { movie, tv }
enum KnownForDepartment { acting, directing }
enum ResultMediaType { person }

const List<MediaType> mediaTypeList = [
  MediaType.movie,
  MediaType.tv,
];
const List<MediaListType> listTypeList = [
  MediaListType.trending,
  MediaListType.popular,
  MediaListType.top_rated
];

extension ParseToStringMediType on MediaType {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension ParseToStringTimeWindow on TimeWindow {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension ParseToStringMediaListType on MediaListType {
  String toShortString() {
    return toString().split('.').last;
  }
}

NeumorphicStyle kSearchNeumorphicStyle = NeumorphicStyle(
  shape: NeumorphicShape.concave,
  color: const Color(0xFF08161a),
  shadowLightColor: Colors.grey.shade700,
  shadowDarkColor: Colors.black,
  lightSource: LightSource.top,
  boxShape: NeumorphicBoxShape.roundRect(
    BorderRadius.circular(20),
  ),
);

NeumorphicStyle kButtonNeumorphicStyle = NeumorphicStyle(
  shape: NeumorphicShape.convex,
  boxShape: NeumorphicBoxShape.roundRect(
    BorderRadius.circular(12),
  ),
  color: const Color(0xFFd00000),
  depth: 8,
  surfaceIntensity: 0.9,
  lightSource: LightSource.bottomLeft,
  shadowLightColor: Colors.grey.shade800,
  shadowDarkColor: Colors.black,
);

const kloadingSpinKit = SpinKitChasingDots(
  color: Colors.white,
  size: 50.0,
);
