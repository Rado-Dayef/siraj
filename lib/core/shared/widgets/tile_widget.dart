import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';

class TileWidget extends StatelessWidget {
  final dynamic title;
  final Border? border;
  final String? subTitle;
  final Color? textColor;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final Widget? leading, trailing, bottomWidget;

  const TileWidget(this.title, {this.border, this.onTap, this.subTitle, this.leading, this.trailing, this.textColor, this.gradient, this.bottomWidget, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      onTap: onTap,
      border: border,
      gradient: gradient,
      child: Column(
        children: [
          Row(
            children: [
              leading ?? 0.squareGap,
              leading == null ? 0.squareGap : 10.horizontalGap,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title is Widget
                      ? title
                      : Text(
                          title,
                          style: TextStyle(fontSize: AppFonts.h2, color: textColor ?? AppColors.whiteColor),
                        ),
                  subTitle == null ? 0.squareGap : 5.verticalGap,
                  subTitle == null
                      ? 0.squareGap
                      : Text(
                          subTitle!,
                          style: TextStyle(fontSize: AppFonts.h4, color: textColor ?? AppColors.whiteColor.withAlpha(150)),
                        ),
                ],
              ).expanded(),
              trailing == null ? 0.squareGap : Expanded(flex: 0, child: trailing!),
            ],
          ),
          bottomWidget == null ? 0.squareGap : 10.verticalGap,
          bottomWidget ?? 0.squareGap,
        ],
      ),
    );
  }
}
