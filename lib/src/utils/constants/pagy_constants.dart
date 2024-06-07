import 'package:flutter/foundation.dart' show immutable;

@immutable
class PagyConstants {
  const PagyConstants._();

  static const String errorText = 'Something went wrong!';
  static const String emptyText = 'This place look empty.';

  static const String gridAssert = 'gridDelegate must be provided when listType is PagyType.grid.';
}
