class QuranKareemJuzModel {
  final String name;
  final int number, pagesTo, pagesFrom;

  const QuranKareemJuzModel({required this.name, required this.number, required this.pagesTo, required this.pagesFrom});

  factory QuranKareemJuzModel.fromJson(Map<String, dynamic> json) {
    return QuranKareemJuzModel(name: json["name"], number: json["number"], pagesTo: json["pagesTo"], pagesFrom: json["pagesFrom"]);
  }
}
