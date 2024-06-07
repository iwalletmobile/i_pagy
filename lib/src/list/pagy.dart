import 'dart:async';

import 'package:flutter/foundation.dart' show AsyncCallback, Key;
import 'package:flutter/material.dart';
import 'package:ipagy/ipagy.dart';
import 'package:ipagy/src/utils/constants/pagy_constants.dart';
import 'package:ipagy/src/utils/extension/object_extension.dart';
import 'package:ipagy/src/utils/extension/widget_extension.dart';
import 'package:ipagy/src/widgets/animated_list_item.dart';
import 'package:ipagy/src/widgets/default_empty_widget.dart';
import 'package:ipagy/src/widgets/default_error_widget.dart';
import 'package:ipagy/src/widgets/default_loading_widget.dart';

part 'conditional_list_view.dart';
part 'mixin/pagy_list_mixin.dart';

/// [ItemBuilder] defines a function signature for building widgets based on data.
typedef ItemBuilder = Widget Function(BuildContext context, int index);

/// [Pagy] widget for managing paginated lists.
///
/// ```dart
/// Pagy<Post>(
///   items = _posts,
///   loadMoreItems = _loadPosts,
///   listType = PagyType.listView,
///   itemBuilder = (BuildContext context, int index) => Card(
///     child: ListTile(
///       leading: Text(posts![index].id.toString()),
///       title: Text(posts![index].title ?? ''),
///       subtitle: Text(posts![index].body ?? ''),
///     ),
///   ),
/// ),
/// ```
class Pagy<T> extends StatefulWidget {
  const Pagy({
    Key? key,
    this.scrollController,
    required this.items,
    required this.loadMoreItems,
    required this.itemBuilder,
    this.hasError = false,
    this.loadingWidget = const DefaultLoadingWidget(),
    this.emptyWidget = const DefaultEmptyWidget(),
    this.scrollDirection = Axis.vertical,
    this.margin,
    this.listType = PagyType.listView,
    this.separatedWidget,
    this.errorWidget = const DefaultErrorWidget(),
    this.firstLoadingItemCount = 1,
    this.gridDelegate,
    this.physics,
    this.itemPadding,
  })  : assert(
          listType != PagyType.grid || gridDelegate != null,
          PagyConstants.gridAssert,
        ),
        super(key: key);

  /// To control ListView scroll .
  final ScrollController? scrollController;

  /// List of items to display.
  final List<T>? items;

  /// Callback for loading more items.
  final AsyncCallback loadMoreItems;

  /// Builder for each data item widget.
  final ItemBuilder itemBuilder;

  /// Indicates if there's an error.
  final bool hasError;

  /// Widget to display when loading.
  final Widget loadingWidget;

  /// Widget to display when list is empty.
  final Widget emptyWidget;

  /// Scroll direction of the list.
  final Axis scrollDirection;

  /// Padding of the list.
  final EdgeInsetsGeometry? margin;

  /// Type of list.
  ///
  /// * [PagyType.grid], creates a `GridView.builder`.
  /// * [PagyType.listView], creates a `ListView.builder`.
  /// * [PagyType.separated], creates a `ListView.separated`.
  /// * [PagyType.animated], creates a `AnimatedListView`.
  final PagyType listType;

  /// Required if type is [PagyType.separated].
  final Widget? separatedWidget;

  /// The number of loading widgets to be displayed on first load.
  ///
  /// In some [Shimmer] uses, it may be desired to be displayed more than once.
  final int firstLoadingItemCount;

  /// Widget to display when there's an error.
  final Widget errorWidget;

  /// Grid delegate for [GridView.builder].
  final SliverGridDelegate? gridDelegate;

  /// Creates a scrollable, linear array of widgets that are created on demand.
  final ScrollPhysics? physics;

  /// Padding of each item created by [Pagy]
  final EdgeInsetsGeometry? itemPadding;

  @override
  State<Pagy<T>> createState() => _PagyState<T>();
}

class _PagyState<T> extends State<Pagy<T>> with _PagyMixin<T> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showLoadingNotifier,
      builder: (context, isLoading, _) => _ConditionalListView<T>(
        controller: scrollController,
        data: widget.items,
        hasError: widget.hasError,
        scrollDirection: widget.scrollDirection,
        pagyType: widget.listType,
        isLoading: isLoading,
        margin: widget.margin,
        gridDelegate: widget.gridDelegate,
        errorWidget: widget.errorWidget,
        loadingWidget: widget.loadingWidget,
        firstLoadingItemCount: widget.firstLoadingItemCount,
        emptyDataWidget: widget.emptyWidget,
        itemBuilder: widget.itemBuilder,
        separatedWidget: widget.separatedWidget,
        physics: widget.physics,
        itemPadding: widget.itemPadding,
      ),
    );
  }
}
