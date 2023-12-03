extension ListHelpers on List<num> {
  int findMax() {
    if (isEmpty) {
      throw ArgumentError("The list cannot be empty");
    }

    return reduce((currentMax, next) =>
        currentMax > next ? currentMax.toInt() : next.toInt()).toInt();
  }

  List<int> averagedList({required int pointsToAverage}) {
    final List<int> averages = [];

    for (int i = 0; i < (length / pointsToAverage); i++) {
      int startIndex = i * pointsToAverage;
      List<num> subset = skip(startIndex).take(pointsToAverage).toList();
      final test = subset.reduce((a, b) => a.toDouble() + b.toDouble());
      int average = test ~/ subset.length;
      averages.add(average);
    }

    return averages;
  }
}

extension ListExtension<E> on List<E> {
  void replaceWhere(bool Function(E) test, E newValue) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = newValue;
      }
    }
  }
}
