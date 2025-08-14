import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/constants/translator.dart';
import 'package:siraj/core/routes/route_names.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/data/models/prayer_model.dart';
import 'package:siraj/presentation/widgets/tile_widget.dart';

class PrayerWidget extends StatelessWidget {
  final int index;
  final Color color;
  final PrayerModel prayer;

  const PrayerWidget(this.prayer, {required this.index, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color background = isDark ? AppColors.whiteColor.withAlpha(25) : AppColors.greenColor.withAlpha(25);
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AppRouteNames.prayer, arguments: prayer);
          },
          child: TileWidget(
            prayer.name,
            color: color,
            trailing: Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: prayer.isSunrise ? AppStrings.startsFrom + AppStrings.space + AppStrings.space : AppStrings.adhanTime + AppStrings.space + AppStrings.space,
                        style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic, color: color),
                      ),
                      TextSpan(
                        text: DateFormat("hh:mm").format(prayer.time).toLowerCase(),
                        style: TextStyle(color: color, fontFamily: AppFonts.number),
                      ),
                      TextSpan(
                        text: AppStrings.space + DateFormat("a").format(prayer.time).toLowerCase().languageTranslator,
                        style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic),
                      ),
                    ],
                  ),
                ),
                10.gap,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: prayer.isSunrise ? AppStrings.endsWhen + AppStrings.space + AppStrings.space : AppStrings.iqamaTime + AppStrings.space + AppStrings.space,
                        style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic, color: color),
                      ),
                      TextSpan(
                        text: prayer.isSunrise ? DateFormat("hh:mm").format(prayer.end!).toLowerCase() : DateFormat("hh:mm").format(prayer.time.add(prayer.iqamahDelay.min)).toLowerCase(),
                        style: TextStyle(color: color, fontFamily: AppFonts.number),
                      ),
                      TextSpan(
                        text: prayer.isSunrise ? AppStrings.space + DateFormat("a").format(prayer.end!).toLowerCase().languageTranslator : AppStrings.space + DateFormat("a").format(prayer.time).toLowerCase().languageTranslator,
                        style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        prayer.isCurrent || prayer.isNext
            ? Positioned(
                top: -50,
                left: -50,
                child: Transform.rotate(
                  angle: 135 * 3.1415926535 / 180,
                  child: Container(height: 55, width: 100, color: prayer.isNext ? AppColors.yellowColor.withAlpha(150) : AppColors.yellowColor),
                ),
              )
            : 0.gap,
      ],
    ).animate().scale(end: Offset(1, 1), delay: ((index + 1) * 250).milSec, begin: Offset(0, 0), duration: 250.milSec);
  }
}
