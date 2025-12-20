part of 'quran_kareem_surah_page_details_cubit.dart';

@freezed
class QuranKareemSurahPageDetailsState with _$QuranKareemSurahPageDetailsState {
  const factory QuranKareemSurahPageDetailsState.loading() = loading;

  const factory QuranKareemSurahPageDetailsState.success({required QuranKareemSurahPageDetailsModel details}) = success;

  const factory QuranKareemSurahPageDetailsState.failure({required String message}) = failure;
}
