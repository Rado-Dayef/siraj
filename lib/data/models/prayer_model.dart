import 'package:siraj/data/models/prayer_sunnah_model.dart';
import 'package:siraj/data/models/prayer_zekr_model.dart';

class PrayerModel {
  final String name;
  final DateTime adhan;
  final PrayerSunnahModel sunnah;
  final List<PrayerZekrModel> azkar;
  final int iqamahDelay, raakahsCount;
  final bool isNext, isCurrent, isAfter, isBefore;

  PrayerModel({required this.name, required this.adhan, required this.azkar, required this.isNext, required this.sunnah, required this.isAfter, required this.isBefore, required this.isCurrent, required this.iqamahDelay, required this.raakahsCount});
}
