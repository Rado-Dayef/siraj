import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/logic/cubits/drawer_cubit/drawer_cubit.dart';
import 'package:siraj/presentation/screens/drawer_menu_screen.dart';
import 'package:siraj/presentation/screens/home_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    Color shadowsColor = isDark ? AppColors.greenColor : AppColors.whiteColor;
    return BlocProvider(
      create: (context) => DrawerCubit(),
      child: BlocBuilder<DrawerCubit, ZoomDrawerController>(
        builder: (context, state) {
          return ZoomDrawer(
            angle: 0,
            isRtl: true,
            borderRadius: 20,
            showShadow: true,
            controller: state,
            menuBackgroundColor: color,
            closeCurve: Curves.bounceIn,
            menuScreen: DrawerMenuScreen(),
            openCurve: Curves.fastOutSlowIn,
            drawerShadowsBackgroundColor: shadowsColor,
            slideWidth: MediaQuery.of(context).size.width * 0.65,
            mainScreen: HomeScreen(),
          );
        },
      ),
    );
  }
}
