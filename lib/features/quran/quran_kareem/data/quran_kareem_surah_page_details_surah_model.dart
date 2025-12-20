import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_page_details_surah_verse_model.dart';

class QuranKareemSurahPageDetailsSurahModel {
  final String revelationPlace;
  final int number, versesCount;
  final List<QuranKareemSurahPageDetailsSurahVerseModel> verses;

  const QuranKareemSurahPageDetailsSurahModel({required this.number, required this.verses, required this.versesCount, required this.revelationPlace});

  factory QuranKareemSurahPageDetailsSurahModel.fromJson(Map<String, dynamic> json) {
    return QuranKareemSurahPageDetailsSurahModel(
      number: json["number"],
      versesCount: json["versesCount"],
      revelationPlace: json["revelationPlace"],
      verses: (json["verses"] as List).map((verse) => QuranKareemSurahPageDetailsSurahVerseModel.fromJson(verse)).toList(),
    );
  }
}
