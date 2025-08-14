import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:prayers_times/prayers_times.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/services/location_services.dart';
import 'package:siraj/core/theme/jsons.dart';
import 'package:siraj/data/models/prayer_model.dart';
import 'package:siraj/data/models/prayer_sunnah_model.dart';
import 'package:siraj/data/models/prayer_zekr_model.dart';

part 'prayers_state.dart';

class PrayersCubit extends Cubit<PrayersState> {
  PrayersCubit() : super(PrayersLoading()) {
    getPrayers();
  }

  Timer? _timer;
  bool isPrayersEndedForToday = false;

  Future<void> getPrayers() async {
    try {
      dynamic location = await LocationService.getCurrentLocation();
      if (location is Position) {
        DateTime now = DateTime.now();
        PrayerTimes prayerTimes = PrayerTimes(dateTime: now, locationName: "Africa/Cairo", calculationParameters: PrayerCalculationMethod.egyptian(), coordinates: Coordinates(location.latitude, location.longitude));
        List<PrayerZekrModel> prayerAzkar = await loadPrayerAzkar();
        List<PrayerModel> prayers = [
          PrayerModel(
            iqamahDelay: 20,
            raakahsCount: 2,
            name: AppStrings.fajr,
            time: prayerTimes.timeForPrayer("fajr")!,
            isNext: prayerTimes.nextPrayer() == "fajr",
            isCurrent: prayerTimes.currentPrayer() == "fajr",
            sunnah: PrayerSunnahModel(after: "", before: "2"),
            azkar: prayerAzkar.where((zekr) => zekr.forFajr == true).toList(),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer("fajr")!),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer("sunrise")!),
            description: "",
          ),
          PrayerModel(
            azkar: [],
            iqamahDelay: 0,
            isSunrise: true,
            raakahsCount: 2,
            name: AppStrings.sunrise,
            time: prayerTimes.timeForPrayer("sunrise")!,
            isNext: prayerTimes.nextPrayer() == "sunrise",
            sunnah: PrayerSunnahModel(after: "", before: ""),
            isCurrent: prayerTimes.currentPrayer() == "sunrise",
            end: (prayerTimes.timeForPrayer("dhuhr")!).subtract(15.min),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer("dhuhr")!),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer("sunrise")!),
            description: "",
          ),
          PrayerModel(
            raakahsCount: 4,
            iqamahDelay: 15,
            name: AppStrings.dhuhr,
            time: prayerTimes.timeForPrayer("dhuhr")!,
            isNext: prayerTimes.nextPrayer() == "dhuhr",
            isCurrent: prayerTimes.currentPrayer() == "dhuhr",
            sunnah: PrayerSunnahModel(after: "2", before: "2 + 2"),
            azkar: prayerAzkar.where((zekr) => zekr.forDhuhr == true).toList(),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer("asr")!),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer("dhuhr")!),
            description: "",
          ),
          PrayerModel(
            raakahsCount: 4,
            iqamahDelay: 10,
            name: AppStrings.asr,
            time: prayerTimes.timeForPrayer("asr")!,
            isNext: prayerTimes.nextPrayer() == "asr",
            isCurrent: prayerTimes.currentPrayer() == "asr",
            sunnah: PrayerSunnahModel(after: "", before: ""),
            azkar: prayerAzkar.where((zekr) => zekr.forAsr == true).toList(),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer("asr")!),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer("maghrib")!),
            description: "",
          ),
          PrayerModel(
            iqamahDelay: 5,
            raakahsCount: 3,
            name: AppStrings.maghrib,
            time: prayerTimes.timeForPrayer("maghrib")!,
            isNext: prayerTimes.nextPrayer() == "maghrib",
            sunnah: PrayerSunnahModel(after: "2", before: ""),
            isCurrent: prayerTimes.currentPrayer() == "maghrib",
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer("isha")!),
            azkar: prayerAzkar.where((zekr) => zekr.forMaghrib == true).toList(),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer("maghrib")!),
            description: "",
          ),
          PrayerModel(
            isAfter: false,
            raakahsCount: 4,
            iqamahDelay: 15,
            name: AppStrings.isha,
            time: prayerTimes.timeForPrayer("isha")!,
            isNext: prayerTimes.nextPrayer() == "isha",
            isCurrent: prayerTimes.currentPrayer() == "isha",
            sunnah: PrayerSunnahModel(after: "2", before: ""),
            azkar: prayerAzkar.where((zekr) => zekr.forIsha == true).toList(),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer("isha")!),
            description: "",
          ),
        ];
        List<PrayerModel> nextPrayer = prayers.where((prayer) => prayer.isNext).toList();
        PrayerModel currentPrayer = prayers.firstWhere((prayer) => prayer.isCurrent, orElse: () => prayers.last);
        if (nextPrayer.isNotEmpty) {
          emitWithRemaining(now, prayers, nextPrayer.first, currentPrayer);
          _timer = Timer.periodic(1.sec, (_) {
            emitWithRemaining(DateTime.now(), prayers, nextPrayer.first, currentPrayer);
          });
        } else {
          isPrayersEndedForToday = true;
          emitWithRemaining(now, prayers, prayers.first, currentPrayer);
          _timer = Timer.periodic(15.sec, (_) {
            if (nextPrayer.isEmpty && DateTime.now().isAfter(DateTime(now.year, now.month, now.day, 24, 0, 0))) {
              isPrayersEndedForToday = false;
              restartPrayers();
            }
          });
        }
      } else {
        location.toString().showToast;
        PrayersFailure failureState = PrayersFailure(message: location.toString());
        emit(failureState);
      }
    } catch (error) {
      error.toString().showToast;
      PrayersFailure failureState = PrayersFailure(message: error.toString());
      emit(failureState);
    }
  }

  void emitWithRemaining(DateTime now, List<PrayerModel> prayers, PrayerModel nextPrayer, PrayerModel currentPrayer) {
    Duration remaining = nextPrayer.time.difference(now);
    if (remaining.isNegative && !isPrayersEndedForToday) {
      restartPrayers();
    }
    PrayersSuccess successState = PrayersSuccess(date: now, prayers: prayers, nextPrayer: nextPrayer, remainingForNextPrayer: formatDuration(remaining), currentPrayer: currentPrayer);
    emit(successState);
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
    _timer?.cancel();
    getPrayers();
  }

  Future<List<PrayerZekrModel>> loadPrayerAzkar() async {
    final String response = await rootBundle.loadString(AppJsons.prayerAzkar);
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData["prayersAzkar"];
    return data.map((zekr) => PrayerZekrModel.fromJson(zekr)).toList();
  }
}
