import 'package:flutter_bloc/flutter_bloc.dart';

class QuranKareemSurahPageDragDetectorCubit extends Cubit<bool> {
  QuranKareemSurahPageDragDetectorCubit() : super(false);

  void detectDrag(bool detected) {
    emit(detected);
  }
}
