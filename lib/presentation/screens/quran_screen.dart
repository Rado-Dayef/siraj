import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/logic/cubits/quran_cubit/quran_cubit.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    Color background = isDark ? AppColors.whiteColor.withAlpha(50) : AppColors.greenColor.withAlpha(25);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(isDark ? AppAssets.backgroundDark : AppAssets.backgroundLight), fit: BoxFit.cover),
            ),
            padding: 10.edgeInsetsAll,
            child: SingleChildScrollView(
              padding: 10.edgeInsetsAll,
              child: BlocProvider(
                create: (context) => QuranCubit(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.quran,
                      style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: color),
                    ).animate().scale(end: Offset(1, 1), begin: Offset(0, 0), duration: 500.milSec),
                    20.gap,
                    BlocBuilder<QuranCubit, String>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<QuranCubit>().changeTab(AppStrings.quran);
                                },
                                child: ClipRRect(
                                  borderRadius: 5.defaultBorderRadius,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: AnimatedContainer(
                                      duration: 250.milSec,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: 10.edgeInsetsAll,
                                      decoration: BoxDecoration(color: state == AppStrings.quran ? background : AppColors.transparentColor, borderRadius: 5.defaultBorderRadius),
                                      child: Center(
                                        child: Text(
                                          AppStrings.quran,
                                          style: TextStyle(fontSize: AppFonts.h2, fontWeight: state == AppStrings.quran ? AppFonts.bold : null, color: color),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            5.gap,
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<QuranCubit>().changeTab(AppStrings.tafsir);
                                },
                                child: ClipRRect(
                                  borderRadius: 5.defaultBorderRadius,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: AnimatedContainer(
                                      duration: 250.milSec,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: 10.edgeInsetsAll,
                                      decoration: BoxDecoration(color: state == AppStrings.tafsir ? background : AppColors.transparentColor, borderRadius: 5.defaultBorderRadius),
                                      child: Center(
                                        child: Text(
                                          AppStrings.tafsir,
                                          style: TextStyle(fontSize: AppFonts.h2, fontWeight: state == AppStrings.tafsir ? AppFonts.bold : null, color: color),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            5.gap,
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<QuranCubit>().changeTab(AppStrings.readings);
                                },
                                child: ClipRRect(
                                  borderRadius: 5.defaultBorderRadius,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: AnimatedContainer(
                                      duration: 250.milSec,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: 10.edgeInsetsAll,
                                      decoration: BoxDecoration(color: state == AppStrings.readings ? background : AppColors.transparentColor, borderRadius: 5.defaultBorderRadius),
                                      child: Center(
                                        child: Text(
                                          AppStrings.readings,
                                          style: TextStyle(fontSize: AppFonts.h2, fontWeight: state == AppStrings.readings ? AppFonts.bold : null, color: color),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
