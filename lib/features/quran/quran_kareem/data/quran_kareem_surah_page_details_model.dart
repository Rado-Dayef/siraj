import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_page_details_surah_model.dart';

class QuranKareemSurahPageDetailsModel {
  bool isFav, hasBookMark;
  final int juz, page, versesCount;
  final List<QuranKareemSurahPageDetailsSurahModel> surahs;

  QuranKareemSurahPageDetailsModel({required this.juz, required this.page, required this.surahs, this.isFav = false, required this.versesCount, this.hasBookMark = false});

  factory QuranKareemSurahPageDetailsModel.fromJson(Map<String, dynamic> json, {required bool isFav, required bool hasBookMark}) {
    return QuranKareemSurahPageDetailsModel(
      isFav: isFav,
      juz: json["juz"],
      page: json["page"],
      hasBookMark: hasBookMark,
      versesCount: json["versesCount"],
      surahs: (json["surahs"] as List).map((surah) => QuranKareemSurahPageDetailsSurahModel.fromJson(surah)).toList(),
    );
  }
}
