extension type IList<T>(List<T> list) implements Iterable<T> {
  T operator [](int index) => list[index];
}

extension ListX<T> on List<T> {
  IList<T> get lock => IList(this);
}

extension SetX<T> on Set<T> {
  IList<T> toIList() => IList(toList());
}

extension IterableX<T> on Iterable<T> {
  IList<T> toIList() => IList(toList());
}
