/// Extension on List<num> to provide additional helper methods.
extension ListHelpers on List<num> {
  /// Finds the maximum value in the list.
  ///
  /// Returns:
  ///   The maximum value as an integer.
  ///
  /// Throws:
  ///   ArgumentError if the list is empty.
  int findMax() {
    if (isEmpty) {
      throw ArgumentError("The list cannot be empty");
    }

    // Reduce the list to find the maximum value.
    return reduce((currentMax, next) =>
        currentMax > next ? currentMax.toInt() : next.toInt()).toInt();
  }

  /// Generates a list of averaged values by averaging a specified number of points.
  ///
  /// Parameters:
  ///   pointsToAverage: The number of points to average.
  ///
  /// Returns:
  ///   A list of integers representing the averaged values.
  List<int> averagedList({required int pointsToAverage}) {
    final List<int> averages = [];

    for (int i = 0; i < (length / pointsToAverage); i++) {
      int startIndex = i * pointsToAverage;
      // Create a subset of the list with the specified number of points.
      List<num> subset = skip(startIndex).take(pointsToAverage).toList();
      // Calculate the sum of the subset.
      final test = subset.reduce((a, b) => a.toDouble() + b.toDouble());
      // Calculate the average and add it to the averages list.
      int average = test ~/ subset.length;
      averages.add(average);
    }

    return averages;
  }
}

/// Extension on List<E> to provide additional functionality.
extension ListExtension<E> on List<E> {
  /// Replaces elements in the list that match a specified condition with a new value.
  ///
  /// Parameters:
  ///   test: A function that tests each element for a condition.
  ///   newValue: The value to replace the matching elements with.
  void replaceWhere(bool Function(E) test, E newValue) {
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        this[i] = newValue;
      }
    }
  }
}
