import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/theme/colors.dart';

class ContainerWidget extends StatelessWidget {
  final Color? color;
  final Widget child;
  final double padding;
  final VoidCallback? onTap;

  const ContainerWidget({this.onTap, this.color, required this.child, this.padding = 10, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color background = isDark ? AppColors.whiteColor.withAlpha(50) : AppColors.greenColor.withAlpha(25);
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: 5.defaultBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: padding.edgeInsetsAll,
            decoration: BoxDecoration(color: color ?? background, borderRadius: 5.defaultBorderRadius),
            child: child,
          ),
        ),
      ),
    );
  }
}
