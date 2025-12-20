import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';

class QuranCubit extends Cubit<String> {
  QuranCubit() : super(AppStrings.quran);

  void changeTab(String newTab) {
    emit(newTab);
  }
}
