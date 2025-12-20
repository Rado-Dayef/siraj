import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/route/routes.dart';
import 'package:siraj/core/shared/logic/prayers_cubit/prayers_cubit.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/shared/widgets/err_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_icons.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/context_extension.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/home/ui/widgets/home_grid_widget.dart';
import 'package:siraj/features/home/ui/widgets/home_prayer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(AppIcons.logoDark, fit: BoxFit.cover, width: 14.5.percentOf(context.screenWidth), height: 14.5.percentOf(context.screenWidth)),
            10.horizontalGap,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appName,
                  style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: AppColors.whiteColor),
                ),
                Text(
                  AppStrings.appSlogan,
                  style: TextStyle(fontSize: AppFonts.h3, fontWeight: AppFonts.bold, color: AppColors.whiteColor.withAlpha(150)),
                ),
              ],
            ).expanded(),
          ],
        ),
        25.verticalGap,
        ContainerWidget(
          onTap: () => Navigator.of(context).pushNamed(Routes.quran),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    AppStrings.quran,
                    style: TextStyle(color: AppColors.whiteColor, fontSize: AppFonts.h1),
                  ).align(alignment: Alignment.centerRight),
                  15.verticalGap,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(
                        value: 0.5,
                        minHeight: 5,
                        backgroundColor: AppColors.whiteColor.withAlpha(150),
                        valueColor: AlwaysStoppedAnimation(AppColors.whiteColor),
                        borderRadius: 5.defaultBorderRadius,
                      ).expanded(),
                      5.horizontalGap,
                      Text(
                        "50%",
                        style: TextStyle(color: AppColors.whiteColor, fontSize: AppFonts.h6, fontFamily: AppFonts.number),
                      ).align(alignment: Alignment.centerRight),
                    ],
                  ),
                ],
              ).expanded(flex: 80),
              10.horizontalGap,
              Image.asset(AppIcons.quran, color: AppColors.whiteColor).expanded(flex: 20),
            ],
          ),
        ),
        15.verticalGap,
        ContainerWidget(
          child: BlocBuilder<PrayersCubit, PrayersState>(
            builder: (context, state) {
              return state.when(
                loading: () {
                  return Column(
                    children: [
                      25.darkLoading.center(),
                      10.verticalGap,
                      Column(
                        children: [
                          Row(
                            children: [
                              HomePrayerWidget(name: AppStrings.fajr, index: 0, isLoading: true).expanded(),
                              10.horizontalGap,
                              HomePrayerWidget(name: AppStrings.sunrise, index: 1, isLoading: true).expanded(),
                            ],
                          ),
                          10.verticalGap,
                          Row(
                            children: [
                              HomePrayerWidget(name: AppStrings.dhuhr, index: 2, isLoading: true).expanded(),
                              10.horizontalGap,
                              HomePrayerWidget(name: AppStrings.asr, index: 3, isLoading: true).expanded(),
                            ],
                          ),
                          10.verticalGap,
                          Row(
                            children: [
                              HomePrayerWidget(name: AppStrings.maghrib, index: 4, isLoading: true).expanded(),
                              10.horizontalGap,
                              HomePrayerWidget(name: AppStrings.isha, index: 5, isLoading: true).expanded(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
                success: (date, nextPrayer, prayers, currentPrayer, remainingForNextPrayer) {
                  return Column(
                    children: [
                      Text(
                        context.read<PrayersCubit>().isPrayersEndedForToday ? AppStrings.todayIsPrayersAreOver : AppStrings.prayer + AppStrings.space + nextPrayer.name,
                        style: TextStyle(fontSize: AppFonts.h1, fontFamily: AppFonts.arabic, color: AppColors.whiteColor, fontWeight: AppFonts.bold),
                      ),
                      context.read<PrayersCubit>().isPrayersEndedForToday
                          ? 0.squareGap
                          : Text(
                              remainingForNextPrayer,
                              style: TextStyle(fontSize: AppFonts.h3, fontFamily: AppFonts.number, color: AppColors.whiteColor),
                            ),
                      10.verticalGap,
                      Column(
                        children: [
                          Row(
                            children: [
                              HomePrayerWidget(prayer: prayers[0], index: 0).expanded(),
                              10.horizontalGap,
                              HomePrayerWidget(prayer: prayers[1], index: 1).expanded(),
                            ],
                          ),
                          10.verticalGap,
                          Row(
                            children: [
                              HomePrayerWidget(prayer: prayers[2], index: 2).expanded(),
                              10.horizontalGap,
                              HomePrayerWidget(prayer: prayers[3], index: 3).expanded(),
                            ],
                          ),
                          10.verticalGap,
                          Row(
                            children: [
                              HomePrayerWidget(prayer: prayers[4], index: 4).expanded(),
                              10.horizontalGap,
                              HomePrayerWidget(prayer: prayers[5], index: 5).expanded(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
                failure: (message) {
                  return ErrWidget(message: message);
                },
              );
            },
          ),
        ),
        15.verticalGap,
        Row(
          children: [
            HomeGridWidget(icon: AppIcons.azkar, title: AppStrings.azkar, route: Routes.azkar),
            10.horizontalGap,
            HomeGridWidget(icon: AppIcons.qibla, title: AppStrings.qibla, route: Routes.qibla),
          ],
        ),
        10.verticalGap,
        Row(
          children: [
            HomeGridWidget(icon: AppIcons.nearestMosque, title: AppStrings.nearestMosque, route: Routes.azkar),
            10.horizontalGap,
            HomeGridWidget(icon: AppIcons.setting, title: AppStrings.settings, route: Routes.qibla),
          ],
        ),
      ],
    ).singleChildScrollView().defaultScaffold();
  }
}
