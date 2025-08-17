import 'package:siraj/data/models/zekr_model.dart';

class AzkarModel {
  final int count;
  final List<ZekrModel> azkar;
  final String title, subTitle, tableName;

  AzkarModel({required this.azkar, required this.count, required this.title, required this.subTitle, required this.tableName});

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(count: json["count"], title: json["title"], subTitle: json["subTitle"], tableName: json["tableName"] ?? "null", azkar: json["azkar"].map<ZekrModel>((zekr) => ZekrModel.fromJson(zekr)).toList());
  }
}
