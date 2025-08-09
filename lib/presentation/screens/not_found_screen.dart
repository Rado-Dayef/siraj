import 'package:flutter/material.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isDark ? AppAssets.backgroundDarkImage : AppAssets.backgroundLightImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: 15.edgeInsetsAll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "4 ",
                      style: TextStyle(
                        fontSize: AppFonts.max,
                        fontFamily: AppFonts.number,
                        color: isDark ? AppColors.whiteColor : AppColors.greenColor,
                      ),
                    ),
                    TextSpan(
                      text: "0",
                      style: TextStyle(
                        fontSize: AppFonts.max,
                        fontFamily: AppFonts.number,
                        color: AppColors.yellowColor,
                      ),
                    ),
                    TextSpan(
                      text: " 4",
                      style: TextStyle(
                        fontSize: AppFonts.max,
                        fontFamily: AppFonts.number,
                        color: isDark ? AppColors.whiteColor : AppColors.greenColor,
                      ),
                    ),
                  ],
                ),
              ),
              20.gap,
              Text(
                AppStrings.pageNotFound,
                style: TextStyle(
                  fontSize: AppFonts.h1,
                  color: isDark ? AppColors.whiteColor : AppColors.greenColor,
                ),
              ),
              15.gap,
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: 5.defaultBorderRadius,
                    border: Border.all(color: isDark ? AppColors.whiteColor : AppColors.greenColor),
                  ),
                  child: Text(
                    AppStrings.back,
                    style: TextStyle(
                      fontSize: AppFonts.h2,
                      color: isDark ? AppColors.whiteColor : AppColors.greenColor,
                    ),
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
