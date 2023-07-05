dynamic deepCopy(dynamic origin) {
  /// Map のとき
  if (origin is Map) {
    final copiedMap = {};
    for (final key in origin.keys) {
      final value = origin[key];
      copiedMap[key] = deepCopy(value);
    }
    return copiedMap;
  }

  /// List のとき
  if (origin is List) {
    final copiedList = [];
    for (final element in origin) {
      copiedList.add(deepCopy(element));
    }
    return copiedList;
  }

  /// それ以外のとき
  return origin;
}
