//TODO: don't push key
const apiKey = '';
const apiUrl = 'https://api.themoviedb.org/3';

enum MediaType { tv, movie }
enum MediaListType { trending, top_rated, recommendations }
enum TimeWindow { day, week }
enum OriginalLanguage { en, sv }
enum KnownForMediaType { movie, tv }
enum KnownForDepartment { acting, directing }
enum ResultMediaType { person }

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
