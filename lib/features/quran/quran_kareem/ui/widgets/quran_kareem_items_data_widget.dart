import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_juz_model.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_model.dart';
import 'package:siraj/features/quran/quran_kareem/ui/widgets/quran_kareem_item_widget.dart';

class QuranKareemItemsDataWidget extends StatelessWidget {
  final List<QuranKareemJuzModel>? juzs;
  final List<QuranKareemSurahModel>? surahs;

  const QuranKareemItemsDataWidget({this.juzs, this.surahs, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: (juzs ?? surahs ?? []).length,
      itemBuilder: (_, int index) {
        QuranKareemJuzModel? juz = juzs?[index];
        QuranKareemSurahModel? surah = surahs?[index];
        return QuranKareemItemWidget(
          juz: juz,
          surah: surah,
          displayLoading: juzs != null
              ? (index == (juzs ?? []).length - 1 && (juzs ?? []).length != 30)
              : surahs != null
              ? (index == (surahs ?? []).length - 1 && (surahs ?? []).length != 114)
              : false,
        );
      },
      separatorBuilder: (_, __) {
        return 10.verticalGap;
      },
    );
  }
}
