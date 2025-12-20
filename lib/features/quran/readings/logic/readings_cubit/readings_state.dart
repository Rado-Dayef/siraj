part of 'readings_cubit.dart';

@freezed
class ReadingsState with _$ReadingsState {
  const factory ReadingsState.loading() = loading;

  const factory ReadingsState.success({required List<QuranReadingsModel> tafsirs}) = success;

  const factory ReadingsState.failure({required String message}) = failure;
}
