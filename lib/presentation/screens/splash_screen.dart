import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/routes/route_names.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/logic/cubits/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocProvider(
      create: (context) => SplashCubit()..startSplash(context),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashFinished) {
            Navigator.of(context).pushReplacementNamed(AppRouteNames.home);
          }
        },
        child: Directionality(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Container(
                        padding: 10.edgeInsetsAll,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.whiteColor : AppColors.greenColor,
                          borderRadius: 25.borderRadiusAll,
                        ),
                        child: Image.asset(
                          isDark ? AppAssets.logoDark : AppAssets.logoLight,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.width / 2,
                        ),
                      )
                      .animate()
                      .scale(end: Offset(1.25, 1.25), duration: 1000.milSec, begin: Offset(0, 0))
                      .scale(
                        delay: 1000.milSec,
                        begin: Offset(1, 1),
                        duration: 500.milSec,
                        end: Offset(0.8, 0.8),
                      ),
                  20.gap,
                  Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: AppFonts.max,
                      fontWeight: AppFonts.bold,
                      color: isDark ? AppColors.whiteColor : AppColors.greenColor,
                    ),
                  ).animate().scale(
                    end: Offset(1, 1),
                    delay: 1000.milSec,
                    begin: Offset(0, 0),
                    duration: 500.milSec,
                  ),
                  Text(
                    AppStrings.appSlogan,
                    style: TextStyle(
                      fontSize: AppFonts.h2,
                      fontWeight: AppFonts.bold,
                      color: isDark
                          ? AppColors.whiteColor.withAlpha(150)
                          : AppColors.greenColor.withAlpha(150),
                    ),
                  ).animate().scale(
                    end: Offset(1, 1),
                    delay: 1000.milSec,
                    begin: Offset(0, 0),
                    duration: 500.milSec,
                  ),
                  Spacer(),
                  isDark
                      ? 25.darkLoading.animate().scale(
                          end: Offset(1, 1),
                          delay: 1000.milSec,
                          begin: Offset(0, 0),
                          duration: 500.milSec,
                        )
                      : 25.lightLoading.animate().scale(
                          end: Offset(1, 1),
                          delay: 1000.milSec,
                          begin: Offset(0, 0),
                          duration: 500.milSec,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
