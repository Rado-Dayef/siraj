import 'package:flutter/material.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/presentation/widgets/container_widget.dart';

class TileWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String? leading, subTitle;
  final Widget? trailing, bottomWidget;
  final Color? textColor, containerColor;

  const TileWidget(this.title, {this.onTap, this.subTitle, this.leading, this.trailing, this.textColor, this.bottomWidget, this.containerColor, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    Color background = isDark ? AppColors.whiteColor.withAlpha(25) : AppColors.greenColor.withAlpha(25);
    Color colorWithOpacity = isDark ? AppColors.whiteColor.withAlpha(150) : AppColors.greenColor.withAlpha(150);
    return ContainerWidget(
      onTap: onTap,
      color: containerColor ?? background,
      child: Column(
        children: [
          Row(
            children: [
              leading == null ? 0.gap : Image.asset(leading!, width: 25, height: 25),
              leading == null ? 0.gap : 10.gap,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: AppFonts.h2, color: textColor ?? color),
                  ),
                  subTitle == null ? 0.gap : 5.gap,
                  subTitle == null
                      ? 0.gap
                      : Text(
                          subTitle!,
                          style: TextStyle(fontSize: AppFonts.h4, color: textColor ?? colorWithOpacity),
                        ),
                ],
              ),
              Spacer(),
              trailing == null ? 0.gap : Expanded(flex: 0, child: trailing!),
            ],
          ),
          bottomWidget == null ? 0.gap : 10.gap,
          bottomWidget ?? 0.gap,
        ],
      ),
    );
  }
}
