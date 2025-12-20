part of 'prayer_azkar_cubit.dart';

@freezed
class PrayerAzkarState with _$PrayerAzkarState {
  const factory PrayerAzkarState.loading() = loading;

  const factory PrayerAzkarState.success({required List<AzkarModel> azkar}) = success;

  const factory PrayerAzkarState.failure({required String message}) = failure;
}
