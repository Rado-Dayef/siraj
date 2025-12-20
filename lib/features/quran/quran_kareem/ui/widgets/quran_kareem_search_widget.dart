import 'package:flutter/material.dart';
import 'package:siraj/core/route/routes.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/features/quran/quran_kareem/data/quran_kareem_surah_screen_args_model.dart';

class QuranKareemSearchWidget extends StatelessWidget {
  final QuranKareemSurahScreenArgsModel args;

  const QuranKareemSearchWidget(this.args, {super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      onTap: () => Navigator.of(context).pushNamed(Routes.surah, arguments: args),
      child: Text(
        args.juz?.name ?? args.surah?.name ?? "",
        style: TextStyle(fontSize: AppFonts.h3, color: AppColors.whiteColor, fontFamily: AppFonts.number),
      ),
    );
  }
}
