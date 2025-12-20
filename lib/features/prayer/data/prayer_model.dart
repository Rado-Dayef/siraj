import 'package:siraj/features/prayer/data/prayer_sunnah_model.dart';

class PrayerModel {
  final DateTime adhan;
  final String name, azkarTable;
  final PrayerSunnahModel sunnah;
  final int iqamahDelay, raakahsCount;
  final bool isNext, isCurrent, isAfter, isBefore;

  PrayerModel({
    required this.name,
    required this.adhan,
    required this.isNext,
    required this.sunnah,
    required this.isAfter,
    required this.isBefore,
    required this.isCurrent,
    required this.azkarTable,
    required this.iqamahDelay,
    required this.raakahsCount,
  });
}
