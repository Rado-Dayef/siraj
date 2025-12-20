import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siraj/core/services/hive_services.dart';
import 'package:siraj/core/utils/constants/quran_kareem_pages_details.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_activity_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_page_details_model.dart';

part 'quran_kareem_surah_page_details_cubit.freezed.dart';
part 'quran_kareem_surah_page_details_state.dart';

class QuranKareemSurahPageDetailsCubit extends Cubit<QuranKareemSurahPageDetailsState> {
  QuranKareemSurahPageDetailsCubit() : super(const QuranKareemSurahPageDetailsState.loading());

  void getPageDetails(int pageNumber) async {
    try {
      emit(QuranKareemSurahPageDetailsState.loading());
      QuranKareemSurahPageDetailsModel surahPageDetails = QuranKareemPagesDetails.pagesDetails.firstWhere((page) => page.page == pageNumber);
      surahPageDetails.hasBookMark = HiveServices.bookMark?.page == pageNumber;
      surahPageDetails.isFav = HiveServices.fav.any((element) => element.page == pageNumber);

      emit(QuranKareemSurahPageDetailsState.success(details: surahPageDetails));
    } catch (error) {
      emit(QuranKareemSurahPageDetailsState.failure(message: error.toString()));
    }
  }

  void changeBookMark() async {
    state.whenOrNull(
      success: (details) {
        HiveServices.addRemoveBookMark(QuranKareemActivityModel(juz: details.juz, page: details.page, surahs: details.surahs.map((surah) => surah.number).toList()));
        emit(
          QuranKareemSurahPageDetailsState.success(
            details: QuranKareemSurahPageDetailsModel(
              juz: details.juz,
              page: details.page,
              surahs: details.surahs,
              versesCount: details.versesCount,
              isFav: details.isFav,
              hasBookMark: !details.hasBookMark,
            ),
          ),
        );
      },
    );
  }

  void changeFav() async {
    state.whenOrNull(
      success: (details) {
        HiveServices.addRemoveFav(QuranKareemActivityModel(juz: details.juz, page: details.page, surahs: details.surahs.map((surah) => surah.number).toList()));
        emit(
          QuranKareemSurahPageDetailsState.success(
            details: QuranKareemSurahPageDetailsModel(
              juz: details.juz,
              page: details.page,
              surahs: details.surahs,
              versesCount: details.versesCount,
              hasBookMark: details.hasBookMark,
              isFav: !details.isFav,
            ),
          ),
        );
      },
    );
  }
}
