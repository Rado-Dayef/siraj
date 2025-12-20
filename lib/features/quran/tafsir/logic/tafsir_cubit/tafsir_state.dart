part of 'tafsir_cubit.dart';

@freezed
class TafsirState with _$TafsirState {
  const factory TafsirState.loading() = loading;

  const factory TafsirState.success({required List<QuranTafsirModel> tafsirs}) = success;

  const factory TafsirState.failure({required String message}) = failure;
}
