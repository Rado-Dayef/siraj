import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/route/router.dart';
import 'package:siraj/core/shared/logic/prayers_cubit/prayers_cubit.dart';
import 'package:siraj/core/theme/app_theme.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';

class SirajApp extends StatelessWidget {
  const SirajApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => PrayersCubit())],
      child: MaterialApp(title: AppStrings.appName, theme: AppTheme.lightTheme, themeMode: ThemeMode.system, darkTheme: AppTheme.darkTheme, onGenerateRoute: AppRouter.generateRoute),
    );
  }
}
