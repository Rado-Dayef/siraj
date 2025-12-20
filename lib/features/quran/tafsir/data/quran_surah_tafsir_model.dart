import 'package:siraj/features/quran/tafsir/data/quran_surah_tafsir_verse_model.dart';

class QuranSurahTafsirModel {
  int number;
  List<QuranSurahTafsirVerseModel> tafsir;

  QuranSurahTafsirModel({required this.number, required this.tafsir});

  factory QuranSurahTafsirModel.fromJson(Map<String, dynamic> json) {
    return QuranSurahTafsirModel(number: json["number"], tafsir: List<QuranSurahTafsirVerseModel>.from(json["tafsir"].map((tafsir) => QuranSurahTafsirVerseModel.fromJson(tafsir))));
  }
}
