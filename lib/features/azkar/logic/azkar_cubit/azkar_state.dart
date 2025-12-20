part of 'azkar_cubit.dart';

@freezed
class AzkarState with _$AzkarState {
  const factory AzkarState.loading() = loading;

  const factory AzkarState.success({required List<AzkarModel> azkar}) = success;

  const factory AzkarState.failure({required String message}) = failure;
}
