part of 'quran_kareem_juzs_cubit.dart';

@freezed
class QuranKareemJuzsState with _$QuranKareemJuzsState {
  const factory QuranKareemJuzsState.loading() = loading;

  const factory QuranKareemJuzsState.success({required List<QuranKareemJuzModel> juzs}) = success;

  const factory QuranKareemJuzsState.failure({required String message}) = failure;
}
