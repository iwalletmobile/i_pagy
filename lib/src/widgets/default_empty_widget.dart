import 'package:flutter/material.dart';
import 'package:ipagy/src/utils/constants/pagy_constants.dart';

class DefaultEmptyWidget extends StatelessWidget {
  const DefaultEmptyWidget({
    Key? key,
    this.text = PagyConstants.emptyText,
    this.icon,
  }) : super(key: key);

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon ?? Icons.folder, size: 40),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              text,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
