class ZekrModel {
  int currentCount;
  final bool isQuran;
  final int count, id;
  final String zekr, note;

  ZekrModel(this.id, {required this.zekr, required this.note, required this.count, required this.isQuran, required this.currentCount});

  factory ZekrModel.fromJson(Map<String, dynamic> json) {
    return ZekrModel(json["id"], zekr: json["zekr"], note: json["note"] ?? "", count: json["count"] ?? 1, isQuran: json["isQuran"] ?? false, currentCount: json["currentCount"] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "zekr": zekr, "note": note, "count": count, "isQuran": isQuran, "currentCount": currentCount};
  }
}
