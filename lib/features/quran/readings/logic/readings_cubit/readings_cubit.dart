import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:siraj/features/quran/readings/data/quran_readings_model.dart';

part 'readings_cubit.freezed.dart';
part 'readings_state.dart';

class ReadingsCubit extends Cubit<ReadingsState> {
  ReadingsCubit() : super(const ReadingsState.loading());
}
