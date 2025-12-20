import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';

class ErrWidget extends StatelessWidget {
  final double size;
  final bool onlyIcon;
  final String message;

  const ErrWidget({required this.message, this.onlyIcon = false, this.size = 50, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.warning_amber_rounded, color: AppColors.yellowColor, size: size).center(),
        onlyIcon ? 0.squareGap : 10.verticalGap,
        onlyIcon
            ? 0.squareGap
            : Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: AppFonts.h2, color: AppColors.whiteColor),
              ).center(),
      ],
    );
  }
}
