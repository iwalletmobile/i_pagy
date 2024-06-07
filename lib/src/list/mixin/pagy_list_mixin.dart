part of '../pagy.dart';

/// A mixin that provides pagination functionality to the [Pagy] widget.
mixin _PagyMixin<T> on State<Pagy<T>> {
  late ScrollController scrollController; // Scroll controller for tracking scroll position
  ValueNotifier<bool> showLoadingNotifier = ValueNotifier<bool>(false); // Notifier to control loading indicator visibility

  /// Sets the loading state and triggers loading more items.
  Future<void> _setLoading(bool isLoading) async {
    showLoadingNotifier.value = isLoading;
    if (showLoadingNotifier.value) {
      await widget.loadMoreItems(); // Load more items when loading is triggered
      showLoadingNotifier.value = false; // Reset loading indicator
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController = (widget.scrollController ?? ScrollController())
      ..addListener(() {
        if ((scrollController.position.pixels >= scrollController.position.maxScrollExtent && !(showLoadingNotifier.value)) && widget.items != null) {
          _setLoading(true);
        }
      });
  }

  @override
  void didUpdateWidget(Pagy<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if new items are loaded and reset loading state
    if (widget.items.isNotNull && widget.items!.isNotEmpty && (oldWidget.items?.isNotEmpty ?? false) && widget.items?.first != oldWidget.items?.first) {
      _setLoading(false);
    }
  }

  @override
  void dispose() {
    scrollController.dispose(); // Dispose the scroll controller when the widget is disposed
    super.dispose();
  }
}
