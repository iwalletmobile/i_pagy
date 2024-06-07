part of 'pagy.dart';

/// A widget that conditionally renders a [ListView.builder], [GridView.builder], or [ListView.separated] based on the provided data.
class _ConditionalListView<T> extends StatelessWidget {
  const _ConditionalListView({
    required this.data,
    required this.isLoading,
    required this.loadingWidget,
    required this.emptyDataWidget,
    required this.itemBuilder,
    required this.controller,
    required this.scrollDirection,
    required this.hasError,
    required this.errorWidget,
    this.pagyType = PagyType.listView,
    this.firstLoadingItemCount = 1,
    this.padding,
    this.separatedWidget,
    this.gridDelegate,
    this.physics,
  });

  /// Data to be displayed
  final List<T>? data;

  /// Type of pagination (list view, grid view, separated list, or animated list)
  final PagyType pagyType;

  /// Whether data is currently being loaded
  final bool isLoading;

  /// Widget to display while loading
  final Widget loadingWidget;

  /// Widget to display when data is empty
  final Widget emptyDataWidget;

  /// Function to build each item in the list/grid
  final ItemBuilder itemBuilder;

  /// Controller for scroll behavior
  final ScrollController controller;

  /// Direction of scrolling (vertical or horizontal)
  final Axis scrollDirection;

  /// Padding around the list/grid
  final EdgeInsetsGeometry? padding;

  /// Number of items to display initially while loading
  final int firstLoadingItemCount;

  /// Widget to display as a separator in a separated list
  final Widget? separatedWidget;

  /// Whether an error occurred
  final bool hasError;

  /// Widget to display when an error occurs
  final Widget errorWidget;

  /// Delegate for grid layout (used only for grid view pagination)
  final SliverGridDelegate? gridDelegate;

  /// Physics of the scroll view
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    switch (pagyType) {
      case PagyType.grid:
        return hasError
            ? errorWidget
            : data.isNotNull && data!.isEmpty
                ? emptyDataWidget
                : GridView.builder(
                    key: data.isNotNull && data!.isNotEmpty ? ObjectKey(data!.first) : null,
                    controller: controller,
                    physics: physics,
                    gridDelegate: gridDelegate!,
                    itemCount: _calculateItemCount,
                    scrollDirection: scrollDirection,
                    padding: padding,
                    itemBuilder: (context, index) => _buildItem(context, index),
                  );
      case PagyType.listView:
        return hasError
            ? errorWidget
            : data.isNotNull && (data! as List).isEmpty
                ? emptyDataWidget
                : ListView.builder(
                    key: data.isNotNull && data!.isNotEmpty ? ObjectKey(data!.first) : null,
                    controller: controller,
                    physics: physics,
                    itemCount: _calculateItemCount,
                    scrollDirection: scrollDirection,
                    padding: padding,
                    itemBuilder: (context, index) => _buildItem(context, index),
                  );
      case PagyType.separated:
        return hasError
            ? errorWidget
            : data.isNotNull && data!.isEmpty
                ? emptyDataWidget
                : ListView.separated(
                    key: data.isNotNull && data!.isNotEmpty ? ObjectKey(data!.first) : null,
                    controller: controller,
                    physics: physics,
                    itemCount: _calculateItemCount,
                    scrollDirection: scrollDirection,
                    padding: padding,
                    itemBuilder: (context, index) => _buildItem(context, index),
                    separatorBuilder: (context, _) => separatedWidget ?? const Divider(),
                  );
      case PagyType.animated:
        return hasError
            ? errorWidget
            : data.isNotNull && data!.isEmpty
                ? emptyDataWidget
                : ListView.builder(
                    key: data.isNotNull && data!.isNotEmpty ? ObjectKey(data!.first) : null,
                    cacheExtent: 0,
                    controller: controller,
                    itemCount: _calculateItemCount,
                    physics: physics,
                    scrollDirection: scrollDirection,
                    padding: padding,
                    itemBuilder: (context, index) => _buildItem(context, index, animated: true),
                  );
    }
  }

  // /Build each item in the list/grid
  Widget _buildItem(BuildContext context, int index, {bool animated = false}) {
    if (data.isNull || index < (data?.length ?? 0)) {
      return data.isNull
          ? loadingWidget
          : data!.isEmpty
              ? emptyDataWidget
              : animated
                  ? AnimatedListItem(child: itemBuilder(context, index))
                  : itemBuilder(context, index);
    } else if (isLoading) {
      return loadingWidget;
    } else {
      return const SizedBox.shrink(); // if not loading and index exceeds data length
    }
  }

  /// Calculate the total item count to be displayed
  int get _calculateItemCount {
    if (data.isNull) {
      return firstLoadingItemCount;
    } else if (isLoading || data!.isEmpty) {
      return data!.length + 1; // Add 1 for loading indicator or empty data widget
    } else {
      return data!.length;
    }
  }
}
