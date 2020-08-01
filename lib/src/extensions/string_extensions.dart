extension StringExtension on String {
  bool containsIgnoreCase(String other) {
    if (other == null) return false;
    return this.toLowerCase().contains(other.toLowerCase());
  }
}
