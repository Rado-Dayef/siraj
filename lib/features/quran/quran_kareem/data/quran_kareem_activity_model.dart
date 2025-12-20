import 'package:hive/hive.dart';

part 'quran_kareem_activity_model.g.dart';

@HiveType(typeId: 0)
class QuranKareemActivityModel {
  @HiveField(0)
  final int juz;

  @HiveField(1)
  final int page;

  @HiveField(2)
  final List<int> surahs;

  QuranKareemActivityModel({required this.juz, required this.page, required this.surahs});
}
