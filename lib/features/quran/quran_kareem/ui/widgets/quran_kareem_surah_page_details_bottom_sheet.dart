import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:siraj/core/services/audio_cache_manager.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_icons.dart';
import 'package:siraj/core/utils/constants/quran_kareem_readers.dart';
import 'package:siraj/core/utils/extensions/context_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_reader_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_page_details_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_page_details_surah_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_page_details_surah_verse_model.dart';

void quranKareemSurahPageDetailsBottomSheet(BuildContext context, {required QuranKareemSurahPageDetailsModel pageDetails}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.transparentColor,
    barrierColor: AppColors.transparentColor.withAlpha(150),
    showDragHandle: true,
    builder: (context) {
      return Container(
        padding: 12.allEdgeInsets,
        width: context.screenWidth,
        decoration: BoxDecoration(
          borderRadius: 0.onlyBorderRadius(topRight: 25, topLeft: 25),
          gradient: LinearGradient(
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
            colors: [AppColors.transparentColor.withAlpha(225), AppColors.greenColor, AppColors.transparentColor.withAlpha(225)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: pageDetails.surahs.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, int index) {
                QuranKareemSurahPageDetailsSurahModel surah = pageDetails.surahs[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        Divider(height: 50, color: AppColors.yellowColor.withAlpha(150), indent: 5.percentOf(context.screenWidth), endIndent: 2.percentOf(context.screenWidth)).expanded(),
                        SvgPicture.asset(
                          "${AppIcons.surahsBase}/${surah.number}.svg",
                          height: 24,
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(AppColors.yellowColor, BlendMode.srcIn),
                        ).align(alignment: Alignment.centerRight),
                        Divider(height: 50, color: AppColors.yellowColor.withAlpha(150), indent: 2.percentOf(context.screenWidth), endIndent: 5.percentOf(context.screenWidth)).expanded(),
                      ],
                    ),
                    12.verticalGap,
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: surah.verses.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) {
                        QuranKareemSurahPageDetailsSurahVerseModel verse = surah.verses[index];
                        return Column(
                          children: [
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: verse.text,
                                    style: TextStyle(color: AppColors.whiteColor.withAlpha(200), fontFamily: AppFonts.quran, fontSize: AppFonts.h3, height: 2.5),
                                  ),
                                  WidgetSpan(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Text(
                                          verse.number.toString(),
                                          style: TextStyle(color: AppColors.whiteColor, fontSize: AppFonts.h6),
                                        ).padding(insets: 0.onlyEdgeInsets(top: 5)),
                                        Image.asset(AppIcons.verse, height: 30, fit: BoxFit.fill),
                                      ],
                                    ).padding(insets: 0.onlyEdgeInsets(right: 10)),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    AudioCacheManager audioCache = AudioCacheManager();
                                    QuranKareemReaderModel reader = QuranKareemReaders.readersPerVerse[9];
                                    audioCache.play("${reader.baseUrl}/${verse.numberInAll}.mp3", filename: "${reader.edition}-verse-${verse.numberInAll}");
                                  },
                                  child: Icon(Icons.play_arrow),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (_, __) {
                        return 12.verticalGap;
                      },
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) {
                return 12.verticalGap;
              },
            ),
          ],
        ).singleChildScrollView(padding: 0.allEdgeInsets),
      ).directionality();
    },
  );
}
