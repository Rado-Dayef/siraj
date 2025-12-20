import 'package:hive_flutter/hive_flutter.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_activity_model.dart';

class HiveServices {
  HiveServices._();

  /// Boxes
  static const String _fav = "fav";
  static const String _lastRead = "lastRead";
  static const String _bookMark = "bookMark";
  static const String _quranKareemActivity = "quranKareemActivity";

  /// Initialization
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(QuranKareemActivityModelAdapter());
    await Hive.openBox<QuranKareemActivityModel>(_quranKareemActivity);
  }

  /// Quran Kareem Handle
  static Box<QuranKareemActivityModel> get _quranKareemActivityBox => Hive.box<QuranKareemActivityModel>(_quranKareemActivity);

  static List<String> get _quranKareemActivityBoxFavKeys => _quranKareemActivityBox.keys.where((key) => key.toString().startsWith(_fav)).map((e) => e.toString()).toList();

  // Read
  static QuranKareemActivityModel? get lastRead => _quranKareemActivityBox.get(_lastRead);

  static QuranKareemActivityModel? get bookMark => _quranKareemActivityBox.get(_bookMark);

  static List<QuranKareemActivityModel> get fav => _quranKareemActivityBoxFavKeys.map((key) => _quranKareemActivityBox.get(key)!).toList();

  // Write
  static Future<void> addLastRead(QuranKareemActivityModel model) async => await _quranKareemActivityBox.put(_lastRead, model);

  static Future<void> addRemoveBookMark(QuranKareemActivityModel model) async {
    if (bookMark != null && bookMark!.page == model.page) {
      await clearBookMark();
    } else {
      await _quranKareemActivityBox.put(_bookMark, model);
    }
  }

  static Future<void> addRemoveFav(QuranKareemActivityModel model) async {
    if (_quranKareemActivityBoxFavKeys.any((key) => key.endsWith("|${model.page}"))) {
      await removeFromFav(model.page.toString());
    } else {
      if (_quranKareemActivityBoxFavKeys.length >= 15) {
        List<String> keys = List<String>.from(_quranKareemActivityBoxFavKeys);
        keys.sort((a, b) => DateTime.parse(a.split("|")[1]).compareTo(DateTime.parse(b.split("|")[1])));
        await removeFromFav(keys.first.split("|").last);
      }
      final newKey = "$_fav|${DateTime.now()}|${model.page}";
      await _quranKareemActivityBox.put(newKey, model);
    }
  }

  // Delete
  static Future<void> clearQuranActivity() async => await _quranKareemActivityBox.clear();

  static Future<void> clearLastRead() async => await _quranKareemActivityBox.delete(_lastRead);

  static Future<void> clearBookMark() async => await _quranKareemActivityBox.delete(_bookMark);

  static Future<void> clearFav() async => await _quranKareemActivityBox.deleteAll(_quranKareemActivityBoxFavKeys);

  static Future<void> removeFromFav(String id) async => await _quranKareemActivityBox.delete(_quranKareemActivityBoxFavKeys.firstWhere((key) => key.endsWith("|$id")));
}
