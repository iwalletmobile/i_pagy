extension ObjectExtension on Object? {
  bool get isNotNull => this != null;
  bool get isNull => this == null;
}
