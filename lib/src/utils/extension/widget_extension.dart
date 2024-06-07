import 'package:flutter/material.dart';
import 'package:ipagy/src/utils/extension/object_extension.dart';

/// Extension method to add padding to a widget if the padding is not null
extension WidgetExtension on Widget {
  Widget? setPadding(EdgeInsetsGeometry? padding) =>
      // Check if padding is not null
      padding.isNotNull
          // If padding is not null, wrap the widget with Padding widget
          ? Padding(padding: padding!, child: this)
          // If padding is null, return the original widget
          : this;
}
