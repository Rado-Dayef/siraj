import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/theme/colors.dart';

class ContainerWidget extends StatelessWidget {
  final Widget child;

  const ContainerWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color background = isDark ? AppColors.whiteColor.withAlpha(25) : AppColors.greenColor.withAlpha(25);
    return ClipRRect(
      borderRadius: 5.defaultBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: double.infinity,
          padding: 10.edgeInsetsAll,
          decoration: BoxDecoration(color: background, borderRadius: 5.defaultBorderRadius),
          child: child,
        ),
      ),
    );
  }
}
