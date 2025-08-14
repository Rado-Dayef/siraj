import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/constants/translator.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/data/models/prayer_model.dart';
import 'package:siraj/data/models/prayer_zekr_model.dart';
import 'package:siraj/logic/cubits/prayers_cubit/prayers_cubit.dart';
import 'package:siraj/presentation/widgets/container_widget.dart';
import 'package:siraj/presentation/widgets/prayer_zekr_widget.dart';
import 'package:siraj/presentation/widgets/tile_widget.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PrayerModel prayer = ModalRoute.of(context)!.settings.arguments as PrayerModel;
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.prayer + AppStrings.space + prayer.name,
                    style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: color),
                  ).animate().scale(end: Offset(1, 1), begin: Offset(0, 0), duration: 500.milSec),
                  20.gap,
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "﴿ فَإِذَا قَضَيْتُمُ الصَّلَاةَ فَاذْكُرُوا اللَّهَ قِيَامًا وَقُعُودًا وَعَلَىٰ جُنُوبِكُمْ ۚ فَإِذَا اطْمَأْنَنتُمْ فَأَقِيمُوا الصَّلَاةَ ۚ إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَّوْقُوتًا ﴾",
                          style: TextStyle(color: color, fontFamily: AppFonts.quran, fontSize: AppFonts.h3),
                        ),
                        TextSpan(
                          text: "  [ ",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                        TextSpan(
                          text: "النساء",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.arabic, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                        TextSpan(
                          text: " : ",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                        TextSpan(
                          text: "103",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.number, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                        TextSpan(
                          text: " ]",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                      ],
                    ),
                  ).animate().scale(end: Offset(1, 1), delay: 500.milSec, begin: Offset(0, 0), duration: 500.milSec),
                  10.gap,
                  ContainerWidget(
                    child: Column(
                      children: [
                        BlocBuilder<PrayersCubit, PrayersState>(
                          builder: (context, state) {
                            if (state is PrayersSuccess) {
                              PrayerModel prayerFromState = state.prayers.firstWhere((prayerFromState) => prayerFromState.name == prayer.name);
                              return prayerFromState.isNext
                                  ? Text(
                                      state.remainingForNextPrayer,
                                      style: TextStyle(fontSize: AppFonts.h2, fontFamily: AppFonts.number, color: color, fontWeight: AppFonts.bold),
                                    )
                                  : prayerFromState.isCurrent || prayerFromState.isBefore || prayerFromState.isAfter
                                  ? Text(
                                      "${prayerFromState.isCurrent
                                          ? AppStrings.prayerTimeNow
                                          : prayerFromState.isBefore
                                          ? AppStrings.prayerNotTime
                                          : AppStrings.prayerTimeEnd} ${prayer.name}",
                                      style: TextStyle(fontSize: AppFonts.h1, fontFamily: AppFonts.arabic, color: color, fontWeight: AppFonts.bold),
                                    )
                                  : 0.gap;
                            } else {
                              return 0.gap;
                            }
                          },
                        ),
                        10.gap,
                        Row(
                          children: [
                            Expanded(
                              child: TileWidget(
                                AppStrings.adhanTime,
                                color: color,
                                trailing: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: intl.DateFormat("hh:mm").format(prayer.adhan).toLowerCase(),
                                        style: TextStyle(color: color, fontFamily: AppFonts.number),
                                      ),
                                      TextSpan(
                                        text: AppStrings.space + intl.DateFormat("a").format(prayer.adhan).toLowerCase().languageTranslator,
                                        style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            10.gap,
                            Expanded(
                              child: TileWidget(
                                AppStrings.iqamaTime,
                                color: color,
                                trailing: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: intl.DateFormat("hh:mm").format(prayer.adhan.add(prayer.iqamahDelay.min)).toLowerCase(),
                                        style: TextStyle(color: color, fontFamily: AppFonts.number),
                                      ),
                                      TextSpan(
                                        text: AppStrings.space + intl.DateFormat("a").format(prayer.adhan).toLowerCase().languageTranslator,
                                        style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().scale(end: Offset(1, 1), delay: 500.milSec, begin: Offset(0, 0), duration: 500.milSec),
                  10.gap,
                  ContainerWidget(
                    child: Column(
                      children: [
                        Text(
                          AppStrings.sunnahsAndRaakahs,
                          style: TextStyle(fontSize: AppFonts.h1, fontFamily: AppFonts.arabic, color: color, fontWeight: AppFonts.bold),
                        ),
                        10.gap,
                        TileWidget(
                          AppStrings.raakahsCount,
                          color: color,
                          trailing: Text(
                            prayer.raakahsCount.toString(),
                            style: TextStyle(fontFamily: AppFonts.number, color: color),
                          ),
                        ),
                        10.gap,
                        Row(
                          children: [
                            Expanded(
                              child: TileWidget(
                                AppStrings.sunnahsBefore,
                                color: color,
                                trailing: prayer.sunnah.before.isNotEmpty
                                    ? Text(
                                        prayer.sunnah.before.toString(),
                                        style: TextStyle(fontFamily: AppFonts.number, color: color),
                                      )
                                    : Text(
                                        AppStrings.nothing,
                                        style: TextStyle(fontSize: AppFonts.h4, color: color),
                                      ),
                              ),
                            ),
                            10.gap,
                            Expanded(
                              child: TileWidget(
                                AppStrings.sunnahsAfter,
                                color: color,
                                trailing: prayer.sunnah.after.isNotEmpty
                                    ? Text(
                                        prayer.sunnah.after.toString(),
                                        style: TextStyle(fontFamily: AppFonts.number, color: color),
                                      )
                                    : Text(
                                        AppStrings.nothing,
                                        style: TextStyle(fontSize: AppFonts.h4, color: color),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        10.gap,
                      ],
                    ),
                  ).animate().scale(end: Offset(1, 1), delay: 500.milSec, begin: Offset(0, 0), duration: 500.milSec),
                  10.gap,
                  ContainerWidget(
                    child: Column(
                      children: [
                        Text(
                          AppStrings.azkar,
                          style: TextStyle(fontSize: AppFonts.h1, fontFamily: AppFonts.arabic, color: color, fontWeight: AppFonts.bold),
                        ),
                        10.gap,
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: prayer.azkar.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (_, int index) {
                            PrayerZekrModel zekr = prayer.azkar[index];
                            return PrayerZekrWidget(zekr, color: color, prayerName: prayer.name, colorWithOpacity: colorWithOpacity);
                          },
                          separatorBuilder: (_, __) {
                            return Divider(height: 50, color: colorWithOpacity, indent: (MediaQuery.of(context).size.width - 60) / 4, endIndent: (MediaQuery.of(context).size.width - 60) / 4);
                          },
                        ),
                      ],
                    ),
                  ).animate().scale(end: Offset(1, 1), delay: 500.milSec, begin: Offset(0, 0), duration: 500.milSec),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
