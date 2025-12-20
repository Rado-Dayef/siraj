import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_juz_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_screen_args_model.dart';
import 'package:siraj/features/quran/quran_kareem/ui/widgets/quran_kareem_search_widget.dart';

class QuranKareemSearchedDataWidget extends StatelessWidget {
  final List<QuranKareemJuzModel>? juzs;
  final List<QuranKareemSurahModel>? surahs;

  const QuranKareemSearchedDataWidget({this.juzs, this.surahs, super.key});

  @override
  Widget build(BuildContext context) {
    return (juzs ?? surahs ?? []).isEmpty
        ? Text(
            AppStrings.noResultsFound,
            style: TextStyle(fontSize: AppFonts.h2, color: AppColors.whiteColor),
          ).center().padding(insets: 10.topEdgeInsets)
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                padding: 10.topEdgeInsets,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ((juzs ?? surahs ?? []).length / 2).ceil(),
                itemBuilder: (_, int index) {
                  QuranKareemSurahScreenArgsModel args = QuranKareemSurahScreenArgsModel(juz: juzs != null ? juzs![index] : null, surah: surahs != null ? surahs![index] : null);
                  return QuranKareemSearchWidget(args);
                },
                separatorBuilder: (_, __) => 10.verticalGap,
              ).expanded(),
              10.horizontalGap,
              ListView.separated(
                shrinkWrap: true,
                padding: 10.topEdgeInsets,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ((juzs ?? []).length / 2).floor(),
                itemBuilder: (_, int index) {
                  QuranKareemSurahScreenArgsModel args = QuranKareemSurahScreenArgsModel(
                    juz: juzs != null ? juzs![index + (juzs!.length / 2).ceil()] : null,
                    surah: surahs != null ? surahs![index + (surahs!.length / 2).ceil()] : null,
                  );
                  return QuranKareemSearchWidget(args);
                },
                separatorBuilder: (_, __) => 10.verticalGap,
              ).expanded(),
            ],
          );
  }
}
