class EnumValues<T> {
  Map<String, T> map = {};
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse => reverseMap;
}
