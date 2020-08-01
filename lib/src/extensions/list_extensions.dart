extension ListExtension<E> on List<E> {
  E elementAtOrNull(int index) {
    return getOrNull(index);
  }

  E getOrNull(int index) {
    return (index >= 0 && length > index) ? elementAt(index) : null;
  }
}
