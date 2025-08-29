import 'package:siraj/data/models/quran_surah_verse_model.dart';

class QuranSurahModel {
  String name, revelationPlace;
  List<QuranSurahVerseModel> verses;
  int number, wordsCount, versesCount, lettersCount;

  QuranSurahModel({required this.name, required this.number, required this.verses, required this.wordsCount, required this.versesCount, required this.lettersCount, required this.revelationPlace});

  factory QuranSurahModel.fromJson(Map<String, dynamic> json) {
    return QuranSurahModel(
      name: json["name"],
      number: json["number"],
      wordsCount: json["words_count"],
      versesCount: json["verses_count"],
      lettersCount: json["letters_count"],
      revelationPlace: json["revelation_place"],
      verses: List<QuranSurahVerseModel>.from(json["verses"].map((verse) => QuranSurahVerseModel.fromJson(verse))),
    );
  }
}
