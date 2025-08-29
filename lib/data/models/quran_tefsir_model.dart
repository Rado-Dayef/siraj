import 'package:siraj/data/models/quran_surah_tafsir_model.dart';

class QuranTafsirModel {
  String name;
  List<QuranSurahTafsirModel> surahs;

  QuranTafsirModel({required this.name, required this.surahs});

  factory QuranTafsirModel.fromJson(Map<String, dynamic> json) {
    return QuranTafsirModel(name: json["name"], surahs: List<QuranSurahTafsirModel>.from(json["surahs"].map((surah) => QuranSurahTafsirModel.fromJson(surah))));
  }
}
