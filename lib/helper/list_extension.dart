extension ListExtension on List {
  List<R> mapNotNull<T, R>(R Function(T e) toElement) {
    List<R> result = [];
    for (final item in this) {
      if (item == null) continue;
      result.add(toElement(item));
    }
    return result;
  }
}