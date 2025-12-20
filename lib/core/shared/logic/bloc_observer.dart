import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      debugPrint("❌ Closed ${bloc.runtimeType}");
    }
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      debugPrint("🆕 Created ${bloc.runtimeType}");
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      debugPrint("📢 Event: $event in ${bloc.runtimeType}");
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      debugPrint("🔄 State Change in ${bloc.runtimeType}: {Current State: ${change.currentState.runtimeType.toString()}, Next State: ${change.nextState.runtimeType.toString()}}");
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      debugPrint(
        "➡️ Transition in ${bloc.runtimeType}: {Current State: ${transition.currentState.runtimeType.toString()}, Next State: ${transition.nextState.runtimeType.toString()}, Event: ${transition.event.runtimeType.toString()}}",
      );
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (kDebugMode) {
      debugPrint("💥 Error in ${bloc.runtimeType}: $error");
    }
  }
}
