import 'package:ipagy/src/list/pagy.dart';

/// Type enums of list.
enum PagyType {
  /// [grid], creates a `GridView.builder` in [Pagy].
  grid,

  /// [listView], creates a `ListView.builder` in [Pagy].
  listView,

  /// [separated], creates a `ListView.separated` in [Pagy].
  separated,

  /// [animated], creates a `AnimatedListView` in [Pagy].
  animated,
}
