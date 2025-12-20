import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_juz_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_model.dart';

class QuranKareemSurahScreenArgsModel {
  int? initialPage;
  QuranKareemJuzModel? juz;
  QuranKareemSurahModel? surah;

  QuranKareemSurahScreenArgsModel({this.juz, this.surah, this.initialPage});
}
