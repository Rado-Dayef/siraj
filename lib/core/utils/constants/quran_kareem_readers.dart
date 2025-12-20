import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_reader_model.dart';

class QuranKareemReaders {
  QuranKareemReaders._();

  static const String versesBaseUrl = "https://cdn.islamic.network/quran/audio";
  static const String surahBaseUrl = "https://cdn.islamic.network/quran/audio-surah";

  static const List readersPerVerse = [
    QuranKareemReaderModel(name: "الحذيفى", edition: "ar.hudhaify", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "هاني رفاعي", edition: "ar.hanirifai", bitrate: "192", perVerse: true),
    QuranKareemReaderModel(name: "محمود خليل الحصري", edition: "ar.husary", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "أبو بكر الشاطري", edition: "ar.shaatree", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "محمد أيوب", edition: "ar.muhammadayyoub", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "مشاري راشد العفاسي", edition: "ar.alafasy", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "إبراهيم الأخضر", edition: "ar.ibrahimakhbar", bitrate: "32", perVerse: true),
    QuranKareemReaderModel(name: "ماهر المعيقلي", edition: "ar.mahermuaiqly", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "محمد جبريل", edition: "ar.muhammadjibreel", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "محمد صديق المنشاوي", edition: "ar.minshawi", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "عبد الله بصفر", edition: "ar.abdullahbasfar", bitrate: "192", perVerse: true),
    QuranKareemReaderModel(name: "أحمد بن علي العجمي", edition: "ar.ahmedajamy", bitrate: "128", perVerse: true),
    QuranKareemReaderModel(name: "عبد الباسط (مرتل)", edition: "ar.abdulbasitmurattal", bitrate: "192", perVerse: true),
    QuranKareemReaderModel(name: "عبد الرحمن السديس", edition: "ar.abdurrahmaansudais", bitrate: "192", perVerse: true),
    QuranKareemReaderModel(name: "محمود خليل الحصري (مجوّد)", edition: "ar.husarymujawwad", bitrate: "128", perVerse: true),
  ];

  static const List readersPerSurah = [
    QuranKareemReaderModel(name: "مشاري راشد العفاسي", edition: "ar.alafasy", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الله بصفر", edition: "ar.abdullahbasfar", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الله الخياط", edition: "ar.abdullahkhayat", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "محمد الحيدان", edition: "ar.muhammadalluhaidan", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الله الخليفي", edition: "ar.abdullahkhulaifi", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الله المطرود", edition: "ar.abdullahalmatrood", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الباسط (مجوّد)", edition: "ar.abdulbasitmujawwad", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الباسط (مرتل)", edition: "ar.abdulbasitmurattal", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الكريم الحازمي", edition: "ar.abdulkareemalhazmi", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد المحسن الحارثي", edition: "ar.abdulmohsenalharthy", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد العزيز الزهراني", edition: "ar.abdulazizazzahrani", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الباري الثبيتي", edition: "ar.abdulbariaththubaity", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبد الله عوض الجهني", edition: "ar.abdullahawadaljuhani", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "عبدالمنعم عبد المبدي", edition: "ar.abdulmunimabdulmubdi", bitrate: "128", perSurah: true),
    QuranKareemReaderModel(name: "محمد صديق المنشاوي (مجوّد)", edition: "ar.muhammadsiddiqalminshawimujawwad", bitrate: "128", perSurah: true),
  ];
}
