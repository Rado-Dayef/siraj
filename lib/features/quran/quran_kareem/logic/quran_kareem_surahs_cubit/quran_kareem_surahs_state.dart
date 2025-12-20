part of 'quran_kareem_surahs_cubit.dart';

@freezed
class QuranKareemSurahsState with _$QuranKareemSurahsState {
  const factory QuranKareemSurahsState.loading() = loading;

  const factory QuranKareemSurahsState.success({required List<QuranKareemSurahModel> surahs}) = success;

  const factory QuranKareemSurahsState.failure({required String message}) = failure;
}
