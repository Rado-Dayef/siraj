import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplash(BuildContext context) {
    SplashLoading loadingState = SplashLoading();
    emit(loadingState);
    Future.delayed(8.sec, () {
      SplashFinished finishedState = SplashFinished();
      emit(finishedState);
    });
  }
}
