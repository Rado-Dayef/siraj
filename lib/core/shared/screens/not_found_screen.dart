import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_images.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(isDark ? AppImages.backgroundDark : AppImages.backgroundLight), fit: BoxFit.cover),
          ),
          padding: 10.allEdgeInsets,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "4 ",
                      style: TextStyle(fontSize: AppFonts.max, fontFamily: AppFonts.number, color: color),
                    ),
                    TextSpan(
                      text: "0",
                      style: TextStyle(fontSize: AppFonts.max, fontFamily: AppFonts.number, color: AppColors.yellowColor),
                    ),
                    TextSpan(
                      text: " 4",
                      style: TextStyle(fontSize: AppFonts.max, fontFamily: AppFonts.number, color: color),
                    ),
                  ],
                ),
              ),
              20.verticalGap,
              Text(
                AppStrings.pageNotFound,
                style: TextStyle(fontSize: AppFonts.h1, color: color),
              ),
              10.verticalGap,
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: 5.defaultBorderRadius,
                    border: Border.all(color: color),
                  ),
                  child: Text(
                    AppStrings.back,
                    style: TextStyle(fontSize: AppFonts.h2, color: color),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
