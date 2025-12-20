import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';

class ContainerWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double padding;
  final BoxBorder? border;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final Alignment? alignment;
  final BorderRadius? borderRadius;

  const ContainerWidget({this.onTap, this.alignment = Alignment.center, required this.child, this.border, this.gradient, this.padding = 12, this.width, this.borderRadius, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        width: width,
        duration: 250.milSec,
        alignment: alignment,
        padding: padding.allEdgeInsets,
        decoration: BoxDecoration(
          gradient:
              gradient ??
              LinearGradient(
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.bottomRight,
                colors: [AppColors.transparentColor.withAlpha(100), AppColors.greenColor.withAlpha(150), AppColors.transparentColor.withAlpha(100)],
              ),
          borderRadius: borderRadius ?? 5.defaultBorderRadius,
          border: border ?? Border.all(color: AppColors.whiteColor),
        ),
        child: child,
      ).clipRRect(borderRadius: borderRadius),
    );
  }
}
