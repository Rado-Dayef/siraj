class QuranSurahTafsirVerseModel {
  int verse;
  String text;

  QuranSurahTafsirVerseModel({required this.text, required this.verse});

  factory QuranSurahTafsirVerseModel.fromJson(Map<String, dynamic> json) {
    return QuranSurahTafsirVerseModel(text: json["text"], verse: json["verse"]);
  }
}
