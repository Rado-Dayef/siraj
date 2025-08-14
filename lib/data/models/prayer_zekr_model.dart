class PrayerZekrModel {
  final String zekr;
  final bool forAsr, isQuran, forIsha, forFajr, forDhuhr, forMaghrib;
  final int asrCount, ishaCount, fajrCount, dhuhrCount, maghribCount;

  PrayerZekrModel({
    required this.zekr,
    required this.forAsr,
    required this.forIsha,
    required this.isQuran,
    required this.forFajr,
    required this.asrCount,
    required this.forDhuhr,
    required this.ishaCount,
    required this.fajrCount,
    required this.dhuhrCount,
    required this.forMaghrib,
    required this.maghribCount,
  });

  factory PrayerZekrModel.fromJson(Map<String, dynamic> json) {
    return PrayerZekrModel(
      zekr: json["zekr"],
      forAsr: json["forAsr"] ?? false,
      asrCount: json["asrCount"] ?? 0,
      ishaCount: json["ishaCount"] ?? 0,
      fajrCount: json["fajrCount"] ?? 0,
      forIsha: json["forIsha"] ?? false,
      forFajr: json["forFajr"] ?? false,
      isQuran: json["isQuran"] ?? false,
      forDhuhr: json["forDhuhr"] ?? false,
      dhuhrCount: json["dhuhrCount"] ?? 0,
      maghribCount: json["maghribCount"] ?? 0,
      forMaghrib: json["forMaghrib"] ?? false,
    );
  }
}
