import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/shared/screens/not_found_screen.dart';
import 'package:siraj/features/azkar/data/azkar_args_model.dart';
import 'package:siraj/features/azkar/logic/azkar_cubit/azkar_cubit.dart';
import 'package:siraj/features/azkar/ui/azkar_category_screen.dart';
import 'package:siraj/features/azkar/ui/azkar_screen.dart';
import 'package:siraj/features/home/ui/home_screen.dart';
import 'package:siraj/features/prayer/data/prayer_model.dart';
import 'package:siraj/features/prayer/logic/prayer_azkar_cubit/prayer_azkar_cubit.dart';
import 'package:siraj/features/prayer/ui/prayer_screen.dart';
import 'package:siraj/features/qibla/ui/qibla_screen.dart';
import 'package:siraj/features/quran/quran/logic/quran_cubit/quran_cubit.dart';
import 'package:siraj/features/quran/quran/ui/quran_screen.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_screen_args_model.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_change_focus_cubit/quran_kareem_change_focus_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_surah_page_details_cubit/quran_kareem_surah_page_details_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_surah_page_drag_detector_cubit/quran_kareem_surah_page_drag_detector_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_surah_page_number_cubit/quran_kareem_surah_page_number_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/ui/quran_kareem_surah_screen.dart';
import 'package:siraj/features/splash/logic/splash_cubit/splash_cubit.dart';
import 'package:siraj/features/splash/ui/splash_screen.dart';

import 'routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => HomeScreen(),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
      case Routes.quran:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [BlocProvider(create: (context) => QuranCubit())],
            child: QuranScreen(),
          ),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
      case Routes.qibla:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => QiblaScreen(),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
      case Routes.azkar:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => BlocProvider(create: (context) => AzkarCubit(), child: AzkarScreen()),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
      case Routes.surah:
        QuranKareemSurahScreenArgsModel? args = settings.arguments as QuranKareemSurahScreenArgsModel?;
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => QuranKareemChangeFocusCubit()),
              BlocProvider(create: (context) => QuranKareemSurahPageDetailsCubit()),
              BlocProvider(create: (context) => QuranKareemSurahPageDragDetectorCubit()),
              BlocProvider(create: (context) => QuranKareemSurahPageNumberCubit(args?.initialPage ?? args?.juz?.pagesFrom ?? args?.surah?.pagesFrom ?? 1)),
            ],
            child: SurahScreen(args: args),
          ),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
      case Routes.prayer:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => BlocProvider(create: (context) => PrayerAzkarCubit(), child: PrayerScreen(settings.arguments as PrayerModel)),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
      case Routes.splash:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => BlocProvider(
            create: (context) => SplashCubit()..startSplash(context),
            child: BlocListener<SplashCubit, SplashState>(
              listener: (context, state) {
                if (state is finished) {
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
                }
              },
              child: SplashScreen(),
            ),
          ),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
      case Routes.azkarCategory:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => BlocProvider.value(
            value: (settings.arguments as AzkarArgsModel).cubit,
            child: AzkarCategoryScreen(args: settings.arguments as AzkarArgsModel),
          ),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
      default:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => NotFoundScreen(),
          transitionsBuilder: (_, animation, ___, child) {
            CurvedAnimation curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(scale: Tween(begin: 0.95, end: 1.0).animate(curved), child: child),
            );
          },
          transitionDuration: 500.milSec,
        );
    }
  }
}
