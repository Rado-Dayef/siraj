part of 'prayers_cubit.dart';

abstract class PrayersState {}

final class PrayersLoading extends PrayersState {
  @override
  String toString() => "Loading";
}

final class PrayersSuccess extends PrayersState {
  final DateTime date;
  final List<PrayerModel> prayers;
  final String remainingForNextPrayer;
  final PrayerModel nextPrayer, currentPrayer;

  PrayersSuccess({required this.date, required this.prayers, required this.nextPrayer, required this.currentPrayer, required this.remainingForNextPrayer});

  PrayersSuccess copyWith({DateTime? date, PrayerModel? nextPrayer, PrayerModel? currentPrayer, List<PrayerModel>? prayers, String? remainingForNextPrayer}) {
    return PrayersSuccess(
      date: date ?? this.date,
      prayers: prayers ?? this.prayers,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      currentPrayer: currentPrayer ?? this.currentPrayer,
      remainingForNextPrayer: remainingForNextPrayer ?? this.remainingForNextPrayer,
    );
  }

  @override
  String toString() => "Success";
}

final class PrayersFailure extends PrayersState {
  final String message;

  PrayersFailure({required this.message});

  @override
  String toString() => "Failure";
}
