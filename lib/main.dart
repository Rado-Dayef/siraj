import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/services/hive_services.dart';
import 'package:siraj/core/shared/logic/bloc_observer.dart';
import 'package:siraj/siraj_app.dart';

void main() {
  runApp(const SirajApp());
  Future.microtask(() async {
    Bloc.observer = MyBlocObserver();
    WidgetsFlutterBinding.ensureInitialized();
    await HiveServices.init();
  });
}
