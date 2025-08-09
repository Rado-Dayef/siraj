import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/logic/bloc_observer.dart';
import 'package:siraj/siraj_app.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const SirajApp());
}
