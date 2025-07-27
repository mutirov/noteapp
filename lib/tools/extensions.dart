extension ListDeepContains on List<String> {
  bool deepContains(String search) => contains(search) || any((element) => element.contains(search));
}