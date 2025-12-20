import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quran_kareem_change_filter_cubit.freezed.dart';
part 'quran_kareem_change_filter_state.dart';

class QuranKareemChangeFilterCubit extends Cubit<QuranKareemChangeFilterState> {
  QuranKareemChangeFilterCubit() : super(const QuranKareemChangeFilterState.surahs());

  void changeFilter() {
    if (state is surahs) {
      emit(QuranKareemChangeFilterState.juzs());
    } else {
      emit(QuranKareemChangeFilterState.surahs());
    }
  }
}
