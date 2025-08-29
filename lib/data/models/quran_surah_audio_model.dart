import 'package:siraj/data/models/quran_audio_model.dart';

class QuranSurahAudioModel {
  final int number;
  final List<QuranAudioModel> audios;

  QuranSurahAudioModel({required this.number, required this.audios});

  factory QuranSurahAudioModel.fromJson(Map<String, dynamic> json) {
    return QuranSurahAudioModel(number: json["number"], audios: List<QuranAudioModel>.from(json["audios"].map((audio) => QuranAudioModel.fromJson(audio))));
  }
}
