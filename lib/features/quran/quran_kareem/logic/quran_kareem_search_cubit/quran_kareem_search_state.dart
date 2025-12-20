part of 'quran_kareem_search_cubit.dart';

@freezed
class QuranKareemSearchState with _$QuranKareemSearchState {
  const factory QuranKareemSearchState.initial() = initial;

  const factory QuranKareemSearchState.loading() = loading;

  const factory QuranKareemSearchState.success({List<QuranKareemJuzModel>? juzs, List<QuranKareemSurahModel>? surahs}) = success;

  const factory QuranKareemSearchState.failure({required String message}) = failure;
}
