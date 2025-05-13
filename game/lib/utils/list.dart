extension ListSplitExtension<T> on List<T> {
  List<List<T>> splitByPage(int pageQuantity, {bool startToEnd = true}) {
    return startToEnd
        ? _splitByPageStartToEnd(pageQuantity)
        : _splitByPageEndToStart(pageQuantity);
  }

  List<List<T>> _splitByPageStartToEnd(int pageQuantity) {
    final List<List<T>> result = [];

    for (int i = 0; i < length; i += pageQuantity) {
      result.add(sublist(i, (i + pageQuantity).clamp(0, length)));
    }

    // if (length % pageQuantity != 0) {
    //   result.add(length)
    // }

    return result;
  }

  List<List<T>> _splitByPageEndToStart(int pageQuantity) {
    final List<List<T>> result = [];

    return result;
  }
}
