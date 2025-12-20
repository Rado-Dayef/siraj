class QuranReadingsModel {
  String name;

  QuranReadingsModel({required this.name});

  factory QuranReadingsModel.fromJson(Map<String, dynamic> json) {
    return QuranReadingsModel(name: json["name"]);
  }
}
