import 'package:flutter/material.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/presentation/screens/home_screen.dart';
import 'package:siraj/presentation/screens/not_found_screen.dart';
import 'package:siraj/presentation/screens/prayer_screen.dart';
import 'package:siraj/presentation/screens/splash_screen.dart';

import 'route_names.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.home:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => HomeScreen(),
          transitionsBuilder: (_, animation, ___, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
            return FadeTransition(opacity: curved, child: child);
          },
          transitionDuration: 500.milSec,
        );
      case AppRouteNames.prayer:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => PrayerScreen(),
          transitionsBuilder: (_, animation, ___, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
            return FadeTransition(opacity: curved, child: child);
          },
          transitionDuration: 500.milSec,
        );
      case AppRouteNames.splash:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => SplashScreen(),
          transitionsBuilder: (_, animation, ___, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
            return FadeTransition(opacity: curved, child: child);
          },
          transitionDuration: 500.milSec,
        );
      default:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => NotFoundScreen(),
          transitionsBuilder: (_, animation, ___, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return FadeTransition(opacity: curved, child: child);
          },
          transitionDuration: 500.milSec,
        );
    }
  }
}
