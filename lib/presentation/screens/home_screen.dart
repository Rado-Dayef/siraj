import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/data/models/prayer_model.dart';
import 'package:siraj/logic/cubits/prayers_cubit/prayers_cubit.dart';
import 'package:siraj/presentation/widgets/container_widget.dart';
import 'package:siraj/presentation/widgets/err_widget.dart';
import 'package:siraj/presentation/widgets/prayer_widget.dart';
import 'package:siraj/presentation/widgets/qibla_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    Color colorWithOpacity = isDark ? AppColors.whiteColor.withAlpha(150) : AppColors.greenColor.withAlpha(150);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(isDark ? AppAssets.backgroundDark : AppAssets.backgroundLight), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              padding: 10.edgeInsetsAll,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        isDark ? AppAssets.logoDark : AppAssets.logoLight,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.width / 7,
                      ).animate().scale(end: Offset(1.25, 1.25), duration: 1000.milSec, begin: Offset(0, 0)).scale(delay: 1000.milSec, begin: Offset(1, 1), duration: 500.milSec, end: Offset(0.8, 0.8)),
                      10.gap,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.appName,
                              style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: color),
                            ).animate().scale(end: Offset(1, 1), delay: 1000.milSec, begin: Offset(0, 0), duration: 500.milSec),
                            Text(
                              AppStrings.appSlogan,
                              style: TextStyle(fontSize: AppFonts.h3, fontWeight: AppFonts.bold, color: colorWithOpacity),
                            ).animate().scale(end: Offset(1, 1), delay: 1000.milSec, begin: Offset(0, 0), duration: 500.milSec),
                          ],
                        ),
                      ),
                    ],
                  ),
                  25.gap,
                  ContainerWidget(
                    child: BlocBuilder<PrayersCubit, PrayersState>(
                      builder: (context, state) {
                        if (state is PrayersLoading) {
                          return Center(child: isDark ? 25.darkLoading : 25.lightLoading);
                        } else if (state is PrayersSuccess) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        context.read<PrayersCubit>().isPrayersEndedForToday ? AppStrings.todayIsPrayersAreOver : AppStrings.prayer + AppStrings.space + state.nextPrayer.name,
                                        style: TextStyle(fontSize: AppFonts.h1, fontFamily: AppFonts.arabic, color: color, fontWeight: AppFonts.bold),
                                      ),
                                      context.read<PrayersCubit>().isPrayersEndedForToday
                                          ? 0.gap
                                          : Text(
                                              state.remainingForNextPrayer,
                                              style: TextStyle(fontSize: AppFonts.h3, fontFamily: AppFonts.number, color: isDark ? AppColors.whiteColor : AppColors.greenColor),
                                            ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Align(alignment: Alignment.centerLeft, child: QiblaWidget()),
                                  ),
                                ],
                              ),
                              10.gap,
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.prayers.length,
                                itemBuilder: (_, int index) {
                                  PrayerModel prayer = state.prayers[index];
                                  return PrayerWidget(prayer, index: index, color: color);
                                },
                                separatorBuilder: (_, __) {
                                  return 10.gap;
                                },
                              ),
                            ],
                          );
                        } else if (state is PrayersFailure) {
                          return ErrWidget(message: state.message);
                        } else {
                          return ErrWidget(message: AppStrings.somethingWentWrong);
                        }
                      },
                    ),
                  ).animate().scale(end: Offset(1, 1), delay: 1500.milSec, begin: Offset(0, 0), duration: 500.milSec),
                  10.gap,
                  ContainerWidget(
                    child: Row(
                      children: [
                        Expanded(child: Image.asset(isDark ? AppAssets.mosqueDark : AppAssets.mosqueLight)),
                        10.gap,
                        Expanded(
                          flex: 10,
                          child: Text(
                            AppStrings.findNearestMosque,
                            style: TextStyle(color: color, fontSize: AppFonts.h1),
                          ),
                        ),
                        Expanded(flex: 0, child: Icon(Icons.arrow_forward_ios_rounded, color: color)),
                      ],
                    ),
                  ).animate().scale(end: Offset(1, 1), delay: 1500.milSec, begin: Offset(0, 0), duration: 500.milSec),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
