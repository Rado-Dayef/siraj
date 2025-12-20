import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:siraj/core/shared/logic/prayers_cubit/prayers_cubit.dart';
import 'package:siraj/core/shared/models/zekr_model.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/shared/widgets/err_widget.dart';
import 'package:siraj/core/shared/widgets/tile_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/constants/app_translator.dart';
import 'package:siraj/core/utils/extensions/context_extension.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/prayer/data/prayer_model.dart';
import 'package:siraj/features/prayer/logic/prayer_azkar_cubit/prayer_azkar_cubit.dart';
import 'package:siraj/features/prayer/ui/widgets/prayer_zekr_widget.dart';

class PrayerScreen extends StatelessWidget {
  final PrayerModel prayer;

  const PrayerScreen(this.prayer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContainerWidget(
          child: BlocBuilder<PrayersCubit, PrayersState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return 0.squareGap;
                },
                success: (date, nextPrayer, prayers, currentPrayer, remainingForNextPrayer) {
                  PrayerModel prayerFromState = prayers.firstWhere((prayerFromState) => prayerFromState.name == prayer.name);
                  return prayerFromState.isNext
                      ? Text(
                          remainingForNextPrayer,
                          style: TextStyle(fontSize: AppFonts.h2, fontFamily: AppFonts.number, color: AppColors.whiteColor, fontWeight: AppFonts.bold),
                        )
                      : prayerFromState.isCurrent || prayerFromState.isBefore || prayerFromState.isAfter
                      ? Text(
                          "${prayerFromState.isCurrent
                              ? AppStrings.prayerTimeNow
                              : prayerFromState.isBefore
                              ? AppStrings.prayerNotTime
                              : AppStrings.prayerTimeEnd} ${prayer.name}",
                          style: TextStyle(fontSize: AppFonts.h1, fontFamily: AppFonts.arabic, color: AppColors.whiteColor, fontWeight: AppFonts.bold),
                        )
                      : 0.squareGap;
                },
              );
            },
          ),
        ),
        10.verticalGap,
        Row(
          children: [
            TileWidget(
              AppStrings.adhanTime,
              trailing: prayer.name == AppStrings.sunrise
                  ? Text(
                      AppStrings.nothing,
                      style: TextStyle(fontSize: AppFonts.h4, color: AppColors.whiteColor),
                    )
                  : RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: intl.DateFormat("hh:mm").format(prayer.adhan).toLowerCase(),
                            style: TextStyle(color: AppColors.whiteColor, fontFamily: AppFonts.number),
                          ),
                          TextSpan(
                            text: AppStrings.space + intl.DateFormat("a").format(prayer.adhan).toLowerCase().languageTranslator,
                            style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic),
                          ),
                        ],
                      ),
                    ),
            ).expanded(),
            10.horizontalGap,
            TileWidget(
              AppStrings.iqamaTime,
              trailing: prayer.name == AppStrings.sunrise
                  ? Text(
                      AppStrings.nothing,
                      style: TextStyle(fontSize: AppFonts.h4, color: AppColors.whiteColor),
                    )
                  : RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: intl.DateFormat("hh:mm").format(prayer.adhan.add(prayer.iqamahDelay.min)).toLowerCase(),
                            style: TextStyle(color: AppColors.whiteColor, fontFamily: AppFonts.number),
                          ),
                          TextSpan(
                            text: AppStrings.space + intl.DateFormat("a").format(prayer.adhan).toLowerCase().languageTranslator,
                            style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic),
                          ),
                        ],
                      ),
                    ),
            ).expanded(),
          ],
        ),
        Divider(height: 50, color: AppColors.whiteColor.withAlpha(150), indent: 25.percentOf(context.screenWidth - 60), endIndent: 25.percentOf(context.screenWidth - 60)),
        Text(
          AppStrings.sunnahsAndRaakahs,
          style: TextStyle(fontSize: AppFonts.h2, color: AppColors.whiteColor, fontWeight: AppFonts.bold),
        ).align(alignment: Alignment.centerRight),
        10.verticalGap,
        TileWidget(
          AppStrings.raakahsCount,
          trailing: Text(
            prayer.raakahsCount.toString(),
            style: TextStyle(fontFamily: AppFonts.number, color: AppColors.whiteColor),
          ),
        ),
        10.verticalGap,
        Row(
          children: [
            TileWidget(
              AppStrings.sunnahsBefore,
              trailing: Text(
                prayer.sunnah.before.toString(),
                style: TextStyle(fontFamily: prayer.sunnah.before == AppStrings.nothing ? AppFonts.arabic : AppFonts.number, color: AppColors.whiteColor),
              ),
            ).expanded(),
            10.horizontalGap,
            TileWidget(
              AppStrings.sunnahsAfter,
              trailing: Text(
                prayer.sunnah.after.toString(),
                style: TextStyle(fontFamily: prayer.sunnah.after == AppStrings.nothing ? AppFonts.arabic : AppFonts.number, color: AppColors.whiteColor),
              ),
            ).expanded(),
          ],
        ),
        prayer.name == AppStrings.sunrise
            ? 0.squareGap
            : Divider(height: 50, color: AppColors.whiteColor.withAlpha(150), indent: 25.percentOf(context.screenWidth - 60), endIndent: 25.percentOf(context.screenWidth - 60)),
        prayer.name == AppStrings.sunrise
            ? 0.squareGap
            : Text(
                AppStrings.azkarAfterPrayer,
                style: TextStyle(fontSize: AppFonts.h2, color: AppColors.whiteColor, fontWeight: AppFonts.bold),
              ).align(alignment: Alignment.centerRight),
        prayer.name == AppStrings.sunrise ? 0.squareGap : 10.verticalGap,
        BlocBuilder<PrayerAzkarCubit, PrayerAzkarState>(
          builder: (context, state) {
            return state.when(
              loading: () {
                return SizedBox(width: double.infinity, child: 25.darkLoading);
              },
              success: (azkar) {
                List<ZekrModel> currentPrayerAzkar = azkar.where((azkar) => azkar.tableName == prayer.azkarTable).first.azkar;
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: currentPrayerAzkar.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, int index) {
                    ZekrModel zekr = currentPrayerAzkar[index];
                    return PrayerZekrWidget(zekr, index: index, table: prayer.azkarTable);
                  },
                  separatorBuilder: (_, __) {
                    return 10.verticalGap;
                  },
                );
              },
              failure: (message) {
                return ErrWidget(message: message);
              },
            );
          },
        ),
      ],
    ).defaultScaffold(title: AppStrings.prayer + AppStrings.space + prayer.name);
  }
}
