import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/routes/route_names.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/logic/cubits/drawer_cubit/drawer_cubit.dart';
import 'package:siraj/presentation/widgets/tile_widget.dart';

class DrawerMenuScreen extends StatelessWidget {
  const DrawerMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.greenColor : AppColors.whiteColor;
    Color background = isDark ? AppColors.greenColor.withAlpha(25) : AppColors.whiteColor.withAlpha(25);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.whiteColor : AppColors.greenColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: 10.edgeInsetsAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(!isDark ? AppAssets.logoDark : AppAssets.logoLight, width: 100, height: 100)),
                Divider(color: color, indent: 25, endIndent: 25, height: 50),
                TileWidget(
                  AppStrings.azkar,
                  onTap: () {
                    context.read<DrawerCubit>().closeDrawer();
                    Navigator.of(context).pushNamed(AppRouteNames.azkar);
                  },
                  containerColor: background,
                  textColor: color,
                  leading: isDark ? AppAssets.azkarLight : AppAssets.azkarDark,
                ),
                10.gap,
                TileWidget(
                  AppStrings.qibla,
                  onTap: () {
                    context.read<DrawerCubit>().closeDrawer();
                    Navigator.of(context).pushNamed(AppRouteNames.qibla);
                  },
                  containerColor: background,
                  textColor: color,
                  leading: isDark ? AppAssets.qiblaLight : AppAssets.qiblaDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
