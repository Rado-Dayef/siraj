import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';
import 'package:siraj/core/services/location_services.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/string_extension.dart';
import 'package:siraj/features/prayer/data/prayer_model.dart';
import 'package:siraj/features/prayer/data/prayer_sunnah_model.dart';

part 'prayers_cubit.freezed.dart';
part 'prayers_state.dart';

class PrayersCubit extends Cubit<PrayersState> {
  PrayersCubit() : super(const PrayersState.loading()) {
    getPrayers();
  }

  Timer? timer;
  bool isPrayersEndedForToday = false;

  Future<void> getPrayers() async {
    try {
      dynamic location = await LocationServices.getCurrentLocation();
      if (location is LocationData) {
        DateTime now = DateTime.now();
        final params = CalculationMethod.muslim_world_league.getParameters();
        final coordinates = Coordinates(location.latitude!, location.longitude!);
        PrayerTimes prayerTimes = PrayerTimes.today(coordinates, params);
        List<PrayerModel> prayers = [
          PrayerModel(
            iqamahDelay: 20,
            raakahsCount: 2,
            name: AppStrings.fajr,
            azkarTable: "fajrAzkar",
            adhan: prayerTimes.timeForPrayer(Prayer.fajr)!,
            isNext: prayerTimes.nextPrayer() == Prayer.fajr,
            isCurrent: prayerTimes.currentPrayer() == Prayer.fajr,
            sunnah: PrayerSunnahModel(after: AppStrings.nothing, before: "2"),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.dhuhr)!),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.fajr)!),
          ),
          PrayerModel(
            iqamahDelay: 0,
            raakahsCount: 2,
            name: AppStrings.sunrise,
            azkarTable: "sunriseAzkar",
            adhan: prayerTimes.timeForPrayer(Prayer.sunrise)!,
            isNext: prayerTimes.nextPrayer() == Prayer.sunrise,
            isCurrent: prayerTimes.currentPrayer() == Prayer.sunrise,
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.fajr)!),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.dhuhr)!),
            sunnah: PrayerSunnahModel(after: AppStrings.nothing, before: AppStrings.nothing),
          ),
          PrayerModel(
            raakahsCount: 4,
            iqamahDelay: 15,
            name: AppStrings.dhuhr,
            azkarTable: "dhuhrAzkar",
            adhan: prayerTimes.timeForPrayer(Prayer.dhuhr)!,
            isCurrent: prayerTimes.currentPrayer() == Prayer.dhuhr,
            sunnah: PrayerSunnahModel(after: "2", before: "2 + 2"),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.asr)!),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.dhuhr)!),
            isNext: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.fajr)!) && DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.dhuhr)!),
          ),
          PrayerModel(
            raakahsCount: 4,
            iqamahDelay: 10,
            name: AppStrings.asr,
            azkarTable: "asrAzkar",
            adhan: prayerTimes.timeForPrayer(Prayer.asr)!,
            isNext: prayerTimes.nextPrayer() == Prayer.asr,
            isCurrent: prayerTimes.currentPrayer() == Prayer.asr,
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.asr)!),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.maghrib)!),
            sunnah: PrayerSunnahModel(after: AppStrings.nothing, before: AppStrings.nothing),
          ),
          PrayerModel(
            iqamahDelay: 5,
            raakahsCount: 3,
            name: AppStrings.maghrib,
            azkarTable: "maghribAzkar",
            adhan: prayerTimes.timeForPrayer(Prayer.maghrib)!,
            isNext: prayerTimes.nextPrayer() == Prayer.maghrib,
            isCurrent: prayerTimes.currentPrayer() == Prayer.maghrib,
            sunnah: PrayerSunnahModel(after: "2", before: AppStrings.nothing),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.isha)!),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.maghrib)!),
          ),
          PrayerModel(
            isAfter: false,
            raakahsCount: 4,
            iqamahDelay: 15,
            name: AppStrings.isha,
            azkarTable: "ishaAzkar",
            adhan: prayerTimes.timeForPrayer(Prayer.isha)!,
            isNext: prayerTimes.nextPrayer() == Prayer.isha,
            isCurrent: prayerTimes.currentPrayer() == Prayer.isha,
            sunnah: PrayerSunnahModel(after: "2", before: AppStrings.nothing),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.isha)!),
          ),
        ];
        List<PrayerModel> nextPrayer = prayers.where((prayer) => prayer.isNext).toList();
        PrayerModel currentPrayer = prayers.firstWhere((prayer) => prayer.isCurrent, orElse: () => prayers.last);
        if (nextPrayer.isNotEmpty) {
          emitWithRemaining(now, prayers, nextPrayer.first, currentPrayer);
          timer = Timer.periodic(1.sec, (_) {
            emitWithRemaining(DateTime.now(), prayers, nextPrayer.first, currentPrayer);
          });
        } else {
          isPrayersEndedForToday = true;
          emitWithRemaining(now, prayers, prayers.first, currentPrayer);
          timer = Timer.periodic(15.sec, (_) {
            if (nextPrayer.isEmpty && DateTime.now().isAfter(DateTime(now.year, now.month, now.day, 24, 0, 0))) {
              isPrayersEndedForToday = false;
              restartPrayers();
            }
          });
        }
      } else {
        location.toString().showToast;
        Future.delayed(1.sec, () => emit(PrayersState.failure(message: location.toString())));
      }
    } catch (error) {
      error.toString().showToast;
      Future.delayed(1.sec, () => emit(PrayersState.failure(message: error.toString())));
    }
  }

  void emitWithRemaining(DateTime now, List<PrayerModel> prayers, PrayerModel nextPrayer, PrayerModel currentPrayer) {
    Duration remaining = nextPrayer.adhan.difference(now);
    if (remaining.isNegative && !isPrayersEndedForToday) {
      restartPrayers();
    }
    emit(PrayersState.success(date: now, prayers: prayers, nextPrayer: nextPrayer, remainingForNextPrayer: formatDuration(remaining), currentPrayer: currentPrayer));
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return "${hours.toString().padLeft(2, "0")}:"
        "${minutes.toString().padLeft(2, "0")}:"
        "${seconds.toString().padLeft(2, "0")}";
  }

  void restartPrayers() {
    timer?.cancel();
    getPrayers();
  }
}
