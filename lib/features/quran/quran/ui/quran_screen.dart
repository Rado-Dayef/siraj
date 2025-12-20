import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/quran/quran/logic/quran_cubit/quran_cubit.dart';
import 'package:siraj/features/quran/quran/ui/widgets/quran_tab_bar_widget.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_change_filter_cubit/quran_kareem_change_filter_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_juzs_cubit/quran_kareem_juzs_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_search_cubit/quran_kareem_search_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_surahs_cubit/quran_kareem_surahs_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/ui/quran_kareem_screen.dart';
import 'package:siraj/features/quran/readings/ui/readings_screen.dart';
import 'package:siraj/features/quran/tafsir/ui/tafsir_screen.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, String>(
      builder: (context, state) {
        return Column(
          children: [
            12.verticalGap,
            Text(
              AppStrings.quran,
              style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: AppColors.whiteColor),
            ),
            20.verticalGap,
            Row(
              children: [
                QuranTabBarWidget(AppStrings.quran, isSelected: state == AppStrings.quran),
                10.horizontalGap,
                QuranTabBarWidget(AppStrings.tafsir, isSelected: state == AppStrings.tafsir),
                10.horizontalGap,
                QuranTabBarWidget(AppStrings.readings, isSelected: state == AppStrings.readings),
              ],
            ),
            20.verticalGap,
            state == AppStrings.quran
                ? MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (context) => QuranKareemJuzsCubit()),
                      BlocProvider(create: (context) => QuranKareemSurahsCubit()),
                      BlocProvider(create: (context) => QuranKareemSearchCubit()),
                      BlocProvider(create: (context) => QuranKareemChangeFilterCubit()),
                    ],
                    child: QuranKareemScreen(),
                  ).expanded()
                : state == AppStrings.quran
                ? TafsirScreen().expanded()
                : ReadingsScreen().expanded(),
          ],
        );
      },
    ).padding(insets: 12.horizontalEdgeInsets).defaultScaffold();
  }
}
