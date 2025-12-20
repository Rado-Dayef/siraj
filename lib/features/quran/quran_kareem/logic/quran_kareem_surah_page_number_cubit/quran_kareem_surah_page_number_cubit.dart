import 'package:flutter_bloc/flutter_bloc.dart';

class QuranKareemSurahPageNumberCubit extends Cubit<int> {
  final int initial;

  QuranKareemSurahPageNumberCubit(this.initial) : super(initial);

  void changePage(int page) {
    emit(page);
  }
}
