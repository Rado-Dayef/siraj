part of 'prayers_cubit.dart';

@freezed
class PrayersState with _$PrayersState {
  const factory PrayersState.loading() = loading;

  const factory PrayersState.success({
    required DateTime date,
    required PrayerModel nextPrayer,
    required List<PrayerModel> prayers,
    required PrayerModel currentPrayer,
    required String remainingForNextPrayer,
  }) = success;

  const factory PrayersState.failure({required String message}) = failure;
}
