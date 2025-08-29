class QuranSurahVerseModel {
  final String text;
  final int juz, page, sajda;

  QuranSurahVerseModel({required this.juz, required this.text, required this.page, required this.sajda});

  factory QuranSurahVerseModel.fromJson(Map<String, dynamic> json) {
    return QuranSurahVerseModel(juz: json["juz"], text: json["text"], page: json["page"], sajda: json["sajda"]);
  }
}
