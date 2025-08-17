import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/services/local_database_services.dart';
import 'package:siraj/core/theme/jsons.dart';
import 'package:siraj/data/models/azkar_activity_model.dart';
import 'package:siraj/data/models/azkar_model.dart';
import 'package:siraj/data/models/zekr_model.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarLoading()) {
    getAzkar();
  }

  Future<void> getAzkar() async {
    try {
      List<AzkarModel> azkar = [];
      final prefs = await SharedPreferences.getInstance();
      final lastUploadDate = prefs.getString("lastUploadDate");
      final today = DateTime.now().toIso8601String().substring(0, 10);
      if (lastUploadDate == today) {
        List<String> azkarTables = [LocalDatabaseServices.wakingUpTable, LocalDatabaseServices.morningTable, LocalDatabaseServices.eveningTable, LocalDatabaseServices.sleepingTable];
        for (String table in azkarTables) {
          final List<AzkarModel> data = await LocalDatabaseServices.getAll(table);
          azkar.addAll(data);
        }
      } else {
        azkar = await loadAzkarFromJson();
        await resetDatabase(azkar);
        await prefs.setString("lastUploadDate", today);
      }
      AzkarSuccess successState = AzkarSuccess(azkar: azkar);
      emit(successState);
    } catch (error) {
      error.toString().showToast;
      AzkarFailure failureState = AzkarFailure(message: error.toString());
      emit(failureState);
    }
  }

  Future<List<AzkarModel>> loadAzkarFromJson() async {
    List<String> azkarCategories = ["wakingUpAzkar", "morningAzkar", "eveningAzkar", "sleepingAzkar"];

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
    final tables = [LocalDatabaseServices.wakingUpTable, LocalDatabaseServices.morningTable, LocalDatabaseServices.eveningTable, LocalDatabaseServices.sleepingTable];

    for (int i = 0; i < tables.length; i++) {
      await LocalDatabaseServices.deleteAll(tables[i]);
      await LocalDatabaseServices.insert(tables[i], azkar[i]);
    }
  }

  Future<void> updateZekr({required String action, required String table, required ZekrModel zekr}) async {
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
        AzkarModel updatedModel = AzkarModel(count: zekrFromAzkar.count, title: zekrFromAzkar.title, subTitle: zekrFromAzkar.subTitle, azkar: updateZekrList(zekrFromAzkar.azkar), tableName: zekrFromAzkar.tableName);
        await LocalDatabaseServices.update(table, updatedModel);
        if (state is AzkarSuccess) {
          AzkarSuccess currentState = state as AzkarSuccess;
          List<AzkarModel> updatedAzkar = currentState.azkar.map((azkarModel) {
            if (azkarModel.tableName == table) {
              return AzkarModel(count: azkarModel.count, title: azkarModel.title, subTitle: azkarModel.subTitle, azkar: updateZekrList(azkarModel.azkar), tableName: azkarModel.tableName);
            }
            return azkarModel;
          }).toList();
          AzkarSuccess successState = AzkarSuccess(azkar: updatedAzkar);
          emit(successState);
        }
      }
    } catch (error) {
      error.toString().showToast;
      AzkarFailure failureState = AzkarFailure(message: error.toString());
      emit(failureState);
    }
  }

  AzkarActivityModel getTodayIsAzkarActivity(AzkarModel azkar) {
    int totalAzkar = azkar.count;
    int doneAzkar = azkar.azkar.where((zekr) => zekr.currentCount == zekr.count).toList().length;
    int notDoneAzkar = azkar.azkar.where((zekr) => zekr.currentCount != zekr.count).toList().length;
    AzkarActivityModel azkarActivity = AzkarActivityModel(doneAzkar: doneAzkar, totalAzkar: totalAzkar, notDoneAzkar: notDoneAzkar);
    return azkarActivity;
  }
}
