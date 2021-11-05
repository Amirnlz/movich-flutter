//TODO: don't push key
const apiKey = '';
const apiUrl = 'https://api.themoviedb.org/3';

enum MediaType { tv, movie }
enum MediaListType { trending, top_rated, recommendations, popular }
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
