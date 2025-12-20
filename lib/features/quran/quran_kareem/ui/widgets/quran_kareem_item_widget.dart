import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siraj/core/route/routes.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/shared/widgets/tile_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_icons.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_juz_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_screen_args_model.dart';

class QuranKareemItemWidget extends StatelessWidget {
  final bool displayLoading;
  final QuranKareemJuzModel? juz;
  final QuranKareemSurahModel? surah;

  const QuranKareemItemWidget({this.juz, this.surah, required this.displayLoading, super.key});

  @override
  Widget build(BuildContext context) {
    return displayLoading
        ? 25.darkLoading.center()
        : TileWidget(
            juz != null
                ? Row(
                    children: [
                      SvgPicture.asset("${AppIcons.juzsBase}/${juz?.number.toString() ?? ""}.svg", height: 20),
                      10.horizontalGap,
                      Text(
                        "(${juz?.name ?? ""})",
                        style: TextStyle(fontSize: AppFonts.h4, color: AppColors.whiteColor, fontFamily: AppFonts.quran),
                      ),
                    ],
                  )
                : SvgPicture.asset("${AppIcons.surahsBase}/${surah?.number.toString() ?? ""}.svg", height: 20),
            onTap: () => Navigator.of(context).pushNamed(
              Routes.surah,
              arguments: QuranKareemSurahScreenArgsModel(juz: juz, surah: surah),
            ),
            leading: surah != null
                ? Image.asset((surah?.revelationPlace ?? "") == AppStrings.madinah ? AppIcons.madinah : AppIcons.kaaba, width: 20, height: 20)
                : SizedBox(
                    width: 20,
                    height: 20,
                    child: Text(
                      juz?.number.toString() ?? "",
                      style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.number),
                    ).center(),
                  ),
            trailing: ContainerWidget(
              child: Text(
                juz != null ? "${juz?.pagesFrom ?? ""} - ${juz?.pagesTo ?? ""}" : surah?.versesCount.toString() ?? "",
                style: TextStyle(fontSize: AppFonts.h6, fontFamily: AppFonts.number),
              ).padding(insets: juz != null ? null : 0.horizontalEdgeInsets),
            ),
          );
  }
}
