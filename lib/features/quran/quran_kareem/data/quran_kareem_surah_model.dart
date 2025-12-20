class QuranKareemSurahModel {
  final String name, revelationPlace;
  final int number, pagesTo, pagesFrom, versesCount;

  const QuranKareemSurahModel({required this.name, required this.number, required this.pagesTo, required this.pagesFrom, required this.versesCount, required this.revelationPlace});

  factory QuranKareemSurahModel.fromJson(Map<String, dynamic> json) {
    return QuranKareemSurahModel(
      name: json["name"],
      number: json["number"],
      pagesTo: json["pagesTo"],
      pagesFrom: json["pagesFrom"],
      versesCount: json["versesCount"],
      revelationPlace: json["revelationPlace"],
    );
  }
}
