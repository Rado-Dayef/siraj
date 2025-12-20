import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siraj/core/utils/constants/quran_kareem_surahs.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_model.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_lazy_load_cubit.dart';

part 'quran_kareem_surahs_cubit.freezed.dart';
part 'quran_kareem_surahs_state.dart';

class QuranKareemSurahsCubit extends QuranKareemLazyLoadCubit<QuranKareemSurahModel, QuranKareemSurahsState> {
  QuranKareemSurahsCubit() : super(QuranKareemSurahsState.loading());

  @override
  List<QuranKareemSurahModel> get allItems => QuranKareemSurahs.surahs;

  @override
  QuranKareemSurahModel fromJson(Map<String, dynamic> json) => QuranKareemSurahModel.fromJson(json);

  @override
  QuranKareemSurahsState successState(List<QuranKareemSurahModel> items) {
    print(items);
    return QuranKareemSurahsState.success(surahs: items);
  }

  @override
  QuranKareemSurahsState failureState(String message) => QuranKareemSurahsState.failure(message: message);
}
