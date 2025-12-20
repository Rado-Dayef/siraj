import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siraj/features/quran/tafsir/data/quran_tefsir_model.dart';

part 'tafsir_cubit.freezed.dart';
part 'tafsir_state.dart';

class TafsirCubit extends Cubit<TafsirState> {
  TafsirCubit() : super(const TafsirState.loading());
}
