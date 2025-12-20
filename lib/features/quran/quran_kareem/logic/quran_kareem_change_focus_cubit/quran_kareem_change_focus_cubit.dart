import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class QuranKareemChangeFocusCubit extends Cubit<bool> {
  QuranKareemChangeFocusCubit() : super(false);

  Timer? _timer;

  void changeFocus({bool? focus, Duration duration = const Duration(seconds: 5)}) {
    _timer?.cancel();
    emit(focus ?? !state);
    if ((focus ?? !state) == true) {
      _timer = Timer(duration, () {
        emit(false);
      });
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
