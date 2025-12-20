import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siraj/core/utils/constants/quran_kareem_juzs.dart';
import 'package:siraj/core/utils/constants/quran_kareem_surahs.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_juz_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_model.dart';

part 'quran_kareem_search_cubit.freezed.dart';
part 'quran_kareem_search_state.dart';

class QuranKareemSearchCubit extends Cubit<QuranKareemSearchState> {
  QuranKareemSearchCubit() : super(const QuranKareemSearchState.initial());

  TextEditingController searchController = TextEditingController();

  void searchSurahsByName(String category) async {
    if (searchController.text.isEmpty) {
      emit(QuranKareemSearchState.initial());
    } else {
      try {
        emit(QuranKareemSearchState.loading());
        if (category == "juzs") {
          List<QuranKareemJuzModel> results = QuranKareemJuzs.juzs.where((juz) {
            String name = juz.name;
            return name.contains(searchController.text);
          }).toList();
          emit(QuranKareemSearchState.success(juzs: results.take(10).toList()));
        } else {
          List<QuranKareemSurahModel> results = QuranKareemSurahs.surahs.where((surah) {
            String name = surah.name;
            return name.contains(searchController.text);
          }).toList();
          emit(QuranKareemSearchState.success(surahs: results.take(10).toList()));
        }
      } catch (error) {
        emit(QuranKareemSearchState.failure(message: error.toString()));
      }
    }
  }
}
