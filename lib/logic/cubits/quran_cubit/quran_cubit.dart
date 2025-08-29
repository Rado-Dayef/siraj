import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/strings.dart';

class QuranCubit extends Cubit<String> {
  QuranCubit() : super(AppStrings.quran);

  void changeTab(String newTab) {
    String newTabName = newTab;
    emit(newTabName);
  }
}
