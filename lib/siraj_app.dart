import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/routes/route_names.dart';
import 'package:siraj/core/routes/router.dart';
import 'package:siraj/core/theme/theme.dart';
import 'package:siraj/logic/cubits/prayers_cubit/prayers_cubit.dart';

class SirajApp extends StatelessWidget {
  const SirajApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => PrayersCubit())],
      child: MaterialApp(title: AppStrings.appName, theme: AppTheme.lightTheme, themeMode: ThemeMode.system, darkTheme: AppTheme.darkTheme, initialRoute: AppRouteNames.splash, onGenerateRoute: AppRouter.generateRoute),
    );
  }
}
