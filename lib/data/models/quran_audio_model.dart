class QuranAudioModel {
  final int id;
  final String link, rewaya, reciter;

  QuranAudioModel({required this.id, required this.link, required this.rewaya, required this.reciter});

  factory QuranAudioModel.fromJson(Map<String, dynamic> json) {
    return QuranAudioModel(id: json["id"], link: json["link"], rewaya: json["rewaya"], reciter: json["reciter"]);
  }
}
