import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_icons.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/context_extension.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Container(
          padding: 10.allEdgeInsets,
          decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: 25.allBorderRadius),
          child: Image.asset(AppIcons.logoDark, fit: BoxFit.cover, width: 50.percentOf(context.screenWidth), height: 50.percentOf(context.screenWidth)),
        ),
        20.verticalGap,
        Text(
          AppStrings.appName,
          style: TextStyle(fontSize: AppFonts.max, fontWeight: AppFonts.bold, color: AppColors.whiteColor),
        ),
        Text(
          AppStrings.appSlogan,
          style: TextStyle(fontSize: AppFonts.h2, fontWeight: AppFonts.bold, color: AppColors.whiteColor.withAlpha(150)),
        ),
        Spacer(),
        25.darkLoading,
        10.verticalGap,
      ],
    ).defaultScaffold();
  }
}
