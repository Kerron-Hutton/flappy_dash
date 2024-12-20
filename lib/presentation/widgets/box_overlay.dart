import 'package:flutter/material.dart';

import '../app_styles.dart';

class BoxOverlay extends StatelessWidget {
  const BoxOverlay({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.boxBgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 8.0,
      ),
      child: child,
    );
  }
}
