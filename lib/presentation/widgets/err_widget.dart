import 'package:flutter/material.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';

class ErrWidget extends StatelessWidget {
  final String message;

  const ErrWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Icon(Icons.warning_amber_rounded, color: AppColors.yellowColor, size: 50),
        ),
        10.gap,
        Align(
          alignment: Alignment.center,
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: AppFonts.h2, color: color),
          ),
        ),
      ],
    );
  }
}
