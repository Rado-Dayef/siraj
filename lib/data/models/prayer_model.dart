import 'package:siraj/data/models/prayer_sunnah_model.dart';
import 'package:siraj/data/models/prayer_zekr_model.dart';

class PrayerModel {
  final DateTime time;
  final DateTime? end;
  final PrayerSunnahModel sunnah;
  final String name, description;
  final List<PrayerZekrModel> azkar;
  final int iqamahDelay, raakahsCount;
  final bool isNext, isCurrent, isSunrise, isAfter, isBefore;

  PrayerModel({
    this.end,
    required this.name,
    required this.time,
    required this.azkar,
    required this.isNext,
    required this.sunnah,
    required this.isAfter,
    required this.isBefore,
    this.isSunrise = false,
    required this.isCurrent,
    required this.iqamahDelay,
    required this.description,
    required this.raakahsCount,
  });
}
