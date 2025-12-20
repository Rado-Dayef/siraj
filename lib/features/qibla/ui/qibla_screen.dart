import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/context_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/qibla/ui/widgets/qibla_widget.dart';

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.qibla,
          style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: AppColors.whiteColor),
        ),
        20.verticalGap,
        RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    "﴿ قَدْ نَرَىٰ تَقَلُّبَ وَجْهِكَ فِي السَّمَاءِ ۖ فَلَنُوَلِّيَنَّكَ قِبْلَةً تَرْضَاهَا ۚ فَوَلِّ وَجْهَكَ شَطْرَ الْمَسْجِدِ الْحَرَامِ ۚ وَحَيْثُ مَا كُنتُمْ فَوَلُّوا وُجُوهَكُمْ شَطْرَهُ ۗ وَإِنَّ الَّذِينَ أُوتُوا الْكِتَابَ لَيَعْلَمُونَ أَنَّهُ الْحَقُّ مِن رَّبِّهِمْ ۗ وَمَا اللَّهُ بِغَافِلٍ عَمَّا يَعْمَلُونَ ﴾",
                style: TextStyle(color: AppColors.whiteColor, fontFamily: AppFonts.quran, fontSize: AppFonts.h3),
              ),
              TextSpan(
                text: "  [ ",
                style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: AppColors.whiteColor.withAlpha(150), fontWeight: AppFonts.bold),
              ),
              TextSpan(
                text: "البقرة",
                style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.arabic, color: AppColors.whiteColor.withAlpha(150), fontWeight: AppFonts.bold),
              ),
              TextSpan(
                text: " : ",
                style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: AppColors.whiteColor.withAlpha(150), fontWeight: AppFonts.bold),
              ),
              TextSpan(
                text: "142",
                style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.number, color: AppColors.whiteColor.withAlpha(150), fontWeight: AppFonts.bold),
              ),
              TextSpan(
                text: " ]",
                style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: AppColors.whiteColor.withAlpha(150), fontWeight: AppFonts.bold),
              ),
            ],
          ),
        ),
        20.verticalGap,
        QiblaWidget(size: context.screenWidth / 1.5).center().expanded(),
      ],
    ).padding(insets: 12.allEdgeInsets).defaultScaffold();
  }
}
