import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/route/routes.dart';
import 'package:siraj/core/services/hive_services.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/shared/widgets/err_widget.dart';
import 'package:siraj/core/shared/widgets/tile_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_icons.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/context_extension.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_screen_args_model.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_change_filter_cubit/quran_kareem_change_filter_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_juzs_cubit/quran_kareem_juzs_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_search_cubit/quran_kareem_search_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/logic/quran_kareem_surahs_cubit/quran_kareem_surahs_cubit.dart';
import 'package:siraj/features/quran/quran_kareem/ui/widgets/quran_kareem_items_data_widget.dart';
import 'package:siraj/features/quran/quran_kareem/ui/widgets/quran_kareem_searched_data_widget.dart';

class QuranKareemScreen extends StatelessWidget {
  const QuranKareemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          cursorColor: AppColors.whiteColor,
          onTapOutside: (_) => context.hideKeyboard,
          controller: context.read<QuranKareemSearchCubit>().searchController,
          style: TextStyle(color: AppColors.whiteColor, fontSize: AppFonts.h3),
          onChanged: (_) => context.read<QuranKareemSearchCubit>().searchSurahsByName(context.read<QuranKareemChangeFilterCubit>().state.when(juzs: () => "juzs", surahs: () => "surahs")),
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: () {
                context.read<QuranKareemChangeFilterCubit>().changeFilter();
                context.read<QuranKareemChangeFilterCubit>().state.when(
                  juzs: () {
                    context.read<QuranKareemSurahsCubit>().reset();
                    context.read<QuranKareemJuzsCubit>().reload();
                  },
                  surahs: () {
                    context.read<QuranKareemJuzsCubit>().reset();
                    context.read<QuranKareemSurahsCubit>().reload();
                  },
                );
              },
              child: Icon(Icons.sort, color: AppColors.whiteColor).directionality(textDirection: TextDirection.ltr),
            ),
            hintStyle: TextStyle(color: AppColors.whiteColor.withAlpha(150), fontSize: AppFonts.h3),
            hintText: AppStrings.search,
            border: OutlineInputBorder(
              borderRadius: 5.defaultBorderRadius,
              borderSide: BorderSide(color: AppColors.whiteColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: 5.defaultBorderRadius,
              borderSide: BorderSide(color: AppColors.whiteColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: 5.defaultBorderRadius,
              borderSide: BorderSide(color: AppColors.whiteColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: 5.defaultBorderRadius,
              borderSide: BorderSide(color: AppColors.whiteColor),
            ),
          ),
        ),
        BlocBuilder<QuranKareemSearchCubit, QuranKareemSearchState>(
          builder: (context, search) {
            return search.maybeWhen(
              orElse: () => 0.verticalGap,
              loading: () => 25.darkLoading.center(),
              success: (juzsData, surahsData) => context.read<QuranKareemChangeFilterCubit>().state.when(
                juzs: () => QuranKareemSearchedDataWidget(juzs: juzsData),
                surahs: () => QuranKareemSearchedDataWidget(surahs: surahsData),
              ),
              failure: (_) => Text(
                AppStrings.noResultsFound,
                style: TextStyle(fontSize: AppFonts.h2, color: AppColors.whiteColor),
              ).center().padding(insets: 10.topEdgeInsets),
            );
          },
        ),
        10.verticalGap,
        BlocBuilder<QuranKareemChangeFilterCubit, QuranKareemChangeFilterState>(
          builder: (context, filter) {
            return Column(
                  children: [
                    TileWidget(
                      AppStrings.mushaf,
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.surah, arguments: QuranKareemSurahScreenArgsModel(initialPage: HiveServices.lastRead?.page));
                      },
                      textColor: AppColors.yellowColor,
                      border: Border.all(color: AppColors.yellowColor),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.transparentColor.withAlpha(100), AppColors.yellowColor.withAlpha(100), AppColors.transparentColor.withAlpha(100)],
                      ),
                      leading: Image.asset(AppIcons.quran, width: 24, height: 24, color: AppColors.yellowColor),
                      trailing: ContainerWidget(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.surah, arguments: QuranKareemSurahScreenArgsModel(initialPage: HiveServices.bookMark?.page));
                        },
                        border: Border.all(color: AppColors.yellowColor),
                        child: Icon(Icons.bookmark_border_rounded, color: AppColors.yellowColor, size: 16),
                      ),
                    ),
                    10.verticalGap,
                    filter.when(
                      juzs: () {
                        return BlocBuilder<QuranKareemJuzsCubit, QuranKareemJuzsState>(
                          builder: (context, state) {
                            return state.when(
                              loading: () => 25.darkLoading.center(),
                              success: (juzsData) => QuranKareemItemsDataWidget(juzs: juzsData),
                              failure: (message) => ErrWidget(message: message),
                            );
                          },
                        );
                      },
                      surahs: () {
                        return BlocBuilder<QuranKareemSurahsCubit, QuranKareemSurahsState>(
                          builder: (context, state) {
                            return state.when(
                              loading: () => 25.darkLoading.center(),
                              success: (surahsData) => QuranKareemItemsDataWidget(surahs: surahsData),
                              failure: (message) => ErrWidget(message: message),
                            );
                          },
                        );
                      },
                    ),
                    10.verticalGap,
                  ],
                )
                .singleChildScrollView(
                  controller: context.read<QuranKareemChangeFilterCubit>().state.when(
                    juzs: () {
                      return context.read<QuranKareemJuzsCubit>().controller;
                    },
                    surahs: () {
                      return context.read<QuranKareemSurahsCubit>().controller;
                    },
                  ),
                  padding: 0.allEdgeInsets,
                )
                .expanded();
          },
        ),
      ],
    );
  }
}
