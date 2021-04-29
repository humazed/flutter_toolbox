extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E e) f) {
    var index = 0;
    return map((e) => f(index++, e));
  }

  void forEachIndexed<T>(T Function(int index, E e) f) {
    var index = 0;
    return forEach((e) => f(index++, e));
  }
}
