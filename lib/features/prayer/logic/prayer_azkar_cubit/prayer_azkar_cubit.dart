import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siraj/core/services/local_database_services.dart';
import 'package:siraj/core/shared/models/azkar_model.dart';
import 'package:siraj/core/shared/models/zekr_model.dart';
import 'package:siraj/core/utils/constants/app_jsons.dart';
import 'package:siraj/core/utils/extensions/string_extension.dart';

part 'prayer_azkar_cubit.freezed.dart';
part 'prayer_azkar_state.dart';

class PrayerAzkarCubit extends Cubit<PrayerAzkarState> {
  PrayerAzkarCubit() : super(const PrayerAzkarState.loading()) {
    getPrayerAzkar();
  }

  Future<void> getPrayerAzkar() async {
    try {
      List<AzkarModel> azkar = [];
      final prefs = await SharedPreferences.getInstance();
      final lastUploadPrayerAzkarDate = prefs.getString("lastUploadPrayerAzkarDate");
      final today = DateTime.now().toIso8601String().substring(0, 10);
      if (lastUploadPrayerAzkarDate == today) {
        List<String> prayerAzkarTables = [
          LocalDatabaseServices.asrTable,
          LocalDatabaseServices.fajrTable,
          LocalDatabaseServices.ishaTable,
          LocalDatabaseServices.dhuhrTable,
          LocalDatabaseServices.sunriseTable,
          LocalDatabaseServices.maghribTable,
        ];
        for (String table in prayerAzkarTables) {
          final List<AzkarModel> data = await LocalDatabaseServices.getAll(table);
          azkar.addAll(data);
        }
      } else {
        azkar = await loadPrayerAzkarFromJson();
        await resetDatabase(azkar);
        await prefs.setString("lastUploadPrayerAzkarDate", today);
      }
      Future.delayed(1.sec, () => emit(PrayerAzkarState.success(azkar: azkar)));
    } catch (error) {
      error.toString().showToast;
      Future.delayed(1.sec, () => emit(PrayerAzkarState.failure(message: error.toString())));
    }
  }

  Future<List<AzkarModel>> loadPrayerAzkarFromJson() async {
    List<String> azkarCategories = ["asrAzkar", "fajrAzkar", "ishaAzkar", "dhuhrAzkar", "sunriseAzkar", "maghribAzkar"];

    final String response = await rootBundle.loadString(AppJsons.azkar);
    final Map<String, dynamic> jsonData = jsonDecode(response);

    List<AzkarModel> azkar = [];
    for (String type in azkarCategories) {
      final section = jsonData[type];
      azkar.add(AzkarModel.fromJson(section));
    }
    return azkar;
  }

  Future<void> resetDatabase(List<AzkarModel> azkar) async {
    final tables = [
      LocalDatabaseServices.asrTable,
      LocalDatabaseServices.fajrTable,
      LocalDatabaseServices.ishaTable,
      LocalDatabaseServices.dhuhrTable,
      LocalDatabaseServices.sunriseTable,
      LocalDatabaseServices.maghribTable,
    ];

    for (int i = 0; i < tables.length; i++) {
      await LocalDatabaseServices.deleteAll(tables[i]);
      await LocalDatabaseServices.insert(tables[i], azkar[i]);
    }
  }

  Future<void> updatePrayerZekr({required String action, required String table, required ZekrModel zekr}) async {
    try {
      if (zekr.currentCount <= zekr.count) {
        if (action == "dec" && zekr.currentCount < zekr.count) {
          zekr.currentCount++;
        } else if (action == "inc" && zekr.currentCount > 0) {
          zekr.currentCount--;
        } else if (action == "reset") {
          zekr.currentCount = 0;
        } else {
          return;
        }
        List<ZekrModel> updateZekrList(List<ZekrModel> azkarList) {
          return azkarList.map((z) {
            if (z.id == zekr.id) {
              return ZekrModel(z.id, zekr: z.zekr, note: z.note, count: z.count, currentCount: zekr.currentCount, isQuran: z.isQuran);
            }
            return z;
          }).toList();
        }

        List<AzkarModel> azkar = await LocalDatabaseServices.getAll(table);
        AzkarModel zekrFromAzkar = azkar.firstWhere((firstZekr) => firstZekr.azkar.any((newZekr) => newZekr.id == zekr.id));
        AzkarModel updatedModel = AzkarModel(
          count: zekrFromAzkar.count,
          title: zekrFromAzkar.title,
          subTitle: zekrFromAzkar.subTitle,
          azkar: updateZekrList(zekrFromAzkar.azkar),
          tableName: zekrFromAzkar.tableName,
        );
        await LocalDatabaseServices.update(table, updatedModel);
        if (state is success) {
          state.whenOrNull(
            success: (azkar) {
              List<AzkarModel> updatedAzkar = azkar.map((azkarModel) {
                if (azkarModel.tableName == table) {
                  return AzkarModel(count: azkarModel.count, title: azkarModel.title, subTitle: azkarModel.subTitle, azkar: updateZekrList(azkarModel.azkar), tableName: azkarModel.tableName);
                }
                return azkarModel;
              }).toList();
              emit(PrayerAzkarState.success(azkar: updatedAzkar));
            },
          );
        }
      }
    } catch (error) {
      error.toString().showToast;
      emit(PrayerAzkarState.failure(message: error.toString()));
    }
  }
}
