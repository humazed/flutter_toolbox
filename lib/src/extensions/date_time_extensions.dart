extension DateExtension<T> on DateTime {
  int get secondsSinceEpoch => (millisecondsSinceEpoch / 1000).round();
}
