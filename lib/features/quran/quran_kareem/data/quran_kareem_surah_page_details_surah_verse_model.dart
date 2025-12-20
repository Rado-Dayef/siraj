class QuranKareemSurahPageDetailsSurahVerseModel {
  final bool sajda;
  final String text;
  final int number, numberInAll;

  const QuranKareemSurahPageDetailsSurahVerseModel({required this.text, required this.sajda, required this.number, required this.numberInAll});

  factory QuranKareemSurahPageDetailsSurahVerseModel.fromJson(Map<String, dynamic> json) {
    return QuranKareemSurahPageDetailsSurahVerseModel(text: json["text"], sajda: json["sajda"], number: json["number"], numberInAll: 1);
  }
}
