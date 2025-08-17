import 'dart:async';
import 'dart:convert';

import 'package:adhan/adhan.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
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

  Timer? timer;
  bool isPrayersEndedForToday = false;

  Future<void> getPrayers() async {
    try {
      dynamic location = await LocationServices.getCurrentLocation();
      if (location is LocationData) {
        DateTime now = DateTime.now();
        List<PrayerZekrModel> prayerAzkar = await loadPrayerAzkar();
        final params = CalculationMethod.muslim_world_league.getParameters();
        final coordinates = Coordinates(location.latitude!, location.longitude!);
        PrayerTimes prayerTimes = PrayerTimes.today(coordinates, params);
        List<PrayerModel> prayers = [
          PrayerModel(
            iqamahDelay: 20,
            raakahsCount: 2,
            name: AppStrings.fajr,
            adhan: prayerTimes.timeForPrayer(Prayer.fajr)!,
            isNext: prayerTimes.nextPrayer() == Prayer.fajr,
            isCurrent: prayerTimes.currentPrayer() == Prayer.fajr,
            sunnah: PrayerSunnahModel(after: "", before: "2"),
            azkar: prayerAzkar.where((zekr) => zekr.forFajr == true).toList(),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.dhuhr)!),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.fajr)!),
          ),
          PrayerModel(
            raakahsCount: 4,
            iqamahDelay: 15,
            name: AppStrings.dhuhr,
            adhan: prayerTimes.timeForPrayer(Prayer.dhuhr)!,
            isCurrent: prayerTimes.currentPrayer() == Prayer.dhuhr,
            sunnah: PrayerSunnahModel(after: "2", before: "2 + 2"),
            azkar: prayerAzkar.where((zekr) => zekr.forDhuhr == true).toList(),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.asr)!),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.dhuhr)!),
            isNext: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.fajr)!) && DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.dhuhr)!),
          ),
          PrayerModel(
            raakahsCount: 4,
            iqamahDelay: 10,
            name: AppStrings.asr,
            adhan: prayerTimes.timeForPrayer(Prayer.asr)!,
            isNext: prayerTimes.nextPrayer() == Prayer.asr,
            isCurrent: prayerTimes.currentPrayer() == Prayer.asr,
            sunnah: PrayerSunnahModel(after: "", before: ""),
            azkar: prayerAzkar.where((zekr) => zekr.forAsr == true).toList(),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.asr)!),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.maghrib)!),
          ),
          PrayerModel(
            iqamahDelay: 5,
            raakahsCount: 3,
            name: AppStrings.maghrib,
            adhan: prayerTimes.timeForPrayer(Prayer.maghrib)!,
            isNext: prayerTimes.nextPrayer() == Prayer.maghrib,
            sunnah: PrayerSunnahModel(after: "2", before: ""),
            isCurrent: prayerTimes.currentPrayer() == Prayer.maghrib,
            azkar: prayerAzkar.where((zekr) => zekr.forMaghrib == true).toList(),
            isBefore: DateTime.now().isBefore(prayerTimes.timeForPrayer(Prayer.isha)!),
            isAfter: DateTime.now().isAfter(prayerTimes.timeForPrayer(Prayer.maghrib)!),
          ),
          PrayerModel(
            isAfter: false,
            raakahsCount: 4,
            iqamahDelay: 15,
            name: AppStrings.isha,
            adhan: prayerTimes.timeForPrayer(Prayer.isha)!,
            isNext: prayerTimes.nextPrayer() == Prayer.isha,
            isCurrent: prayerTimes.currentPrayer() == Prayer.isha,
            sunnah: PrayerSunnahModel(after: "2", before: ""),
            azkar: prayerAzkar.where((zekr) => zekr.forIsha == true).toList(),
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
    Duration remaining = nextPrayer.adhan.difference(now);
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

  Future<List<PrayerZekrModel>> loadPrayerAzkar() async {
    final String response = await rootBundle.loadString(AppJsons.prayerAzkar);
    final Map<String, dynamic> jsonData = jsonDecode(response);
    final List<dynamic> data = jsonData["prayersAzkar"];
    return data.map((zekr) => PrayerZekrModel.fromJson(zekr)).toList();
  }

  void restartPrayers() {
    timer?.cancel();
    getPrayers();
  }
}
