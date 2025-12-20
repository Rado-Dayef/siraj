import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siraj/core/utils/constants/quran_kareem_juzs.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_juz_model.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_lazy_load_cubit.dart';

part 'quran_kareem_juzs_cubit.freezed.dart';
part 'quran_kareem_juzs_state.dart';

class QuranKareemJuzsCubit extends QuranKareemLazyLoadCubit<QuranKareemJuzModel, QuranKareemJuzsState> {
  QuranKareemJuzsCubit() : super(QuranKareemJuzsState.loading());

  @override
  List<QuranKareemJuzModel> get allItems => QuranKareemJuzs.juzs;

  @override
  QuranKareemJuzModel fromJson(Map<String, dynamic> json) => QuranKareemJuzModel.fromJson(json);

  @override
  QuranKareemJuzsState successState(List<QuranKareemJuzModel> items) => QuranKareemJuzsState.success(juzs: items);

  @override
  QuranKareemJuzsState failureState(String message) => QuranKareemJuzsState.failure(message: message);
}
