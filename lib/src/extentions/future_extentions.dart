extension FutureExtension<T> on Iterable<Future<T>> {
  Future<List<T>> wait() {
    return Future.wait(this);
  }
}
