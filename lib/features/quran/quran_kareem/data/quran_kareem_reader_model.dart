import 'package:siraj/core/utils/constants/quran_kareem_readers.dart';

class QuranKareemReaderModel {
  final bool perVerse, perSurah;
  final String baseUrl, name, edition, bitrate;

  const QuranKareemReaderModel({required this.name, required this.edition, required this.bitrate, this.perVerse = false, this.perSurah = false})
    : baseUrl = "${perVerse ? QuranKareemReaders.versesBaseUrl : QuranKareemReaders.surahBaseUrl}/$bitrate/$edition";
}
