import 'package:flutter/material.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/data/models/prayer_zekr_model.dart';

class PrayerZekrWidget extends StatelessWidget {
  final String prayerName;
  final PrayerZekrModel zekr;
  final Color color, colorWithOpacity;

  const PrayerZekrWidget(this.zekr, {required this.color, required this.prayerName, required this.colorWithOpacity, super.key});

  @override
  Widget build(BuildContext context) {
    int count = prayerName == AppStrings.fajr
        ? zekr.fajrCount
        : prayerName == AppStrings.dhuhr
        ? zekr.dhuhrCount
        : prayerName == AppStrings.asr
        ? zekr.asrCount
        : prayerName == AppStrings.maghrib
        ? zekr.maghribCount
        : zekr.ishaCount;
    String numberText = count == 1
        ? "مره واحده"
        : count == 2
        ? "مرتين"
        : count >= 3 && count <= 10
        ? "مرات"
        : "مره";

    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        children: [
          TextSpan(
            text: zekr.isQuran ? "${AppStrings.basmallah}\n${zekr.zekr}" : zekr.zekr,
            style: TextStyle(color: color, fontFamily: zekr.isQuran ? AppFonts.quran : AppFonts.arabic, fontSize: AppFonts.h3),
          ),
          TextSpan(
            text: "  [ ",
            style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
          ),
          TextSpan(
            text: count == 1 || count == 2 ? "" : count.toString(),
            style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.number, color: colorWithOpacity, fontWeight: AppFonts.bold),
          ),
          TextSpan(
            text: count == 1 || count == 2 ? AppStrings.space + numberText : numberText,
            style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.arabic, color: colorWithOpacity, fontWeight: AppFonts.bold),
          ),
          TextSpan(
            text: " ]",
            style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
          ),
        ],
      ),
    );
  }
}
