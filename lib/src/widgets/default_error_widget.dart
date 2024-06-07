import 'package:flutter/material.dart';
import 'package:ipagy/src/utils/constants/pagy_constants.dart';
import 'package:ipagy/src/widgets/default_empty_widget.dart';

class DefaultErrorWidget extends DefaultEmptyWidget {
  const DefaultErrorWidget({
    Key? key,
  }) : super(
          key: key,
          icon: Icons.error,
          text: PagyConstants.errorText,
        );
}
