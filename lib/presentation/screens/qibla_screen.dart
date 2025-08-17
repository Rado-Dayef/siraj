import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/presentation/widgets/qibla_widget.dart';

class QiblaScreen extends StatelessWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    Color colorWithOpacity = isDark ? AppColors.whiteColor.withAlpha(150) : AppColors.greenColor.withAlpha(150);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.qibla,
                    style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: color),
                  ).animate().scale(end: Offset(1, 1), begin: Offset(0, 0), duration: 500.milSec),
                  20.gap,
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "﴿ قَدْ نَرَىٰ تَقَلُّبَ وَجْهِكَ فِي السَّمَاءِ ۖ فَلَنُوَلِّيَنَّكَ قِبْلَةً تَرْضَاهَا ۚ فَوَلِّ وَجْهَكَ شَطْرَ الْمَسْجِدِ الْحَرَامِ ۚ وَحَيْثُ مَا كُنتُمْ فَوَلُّوا وُجُوهَكُمْ شَطْرَهُ ۗ وَإِنَّ الَّذِينَ أُوتُوا الْكِتَابَ لَيَعْلَمُونَ أَنَّهُ الْحَقُّ مِن رَّبِّهِمْ ۗ وَمَا اللَّهُ بِغَافِلٍ عَمَّا يَعْمَلُونَ ﴾",
                          style: TextStyle(color: color, fontFamily: AppFonts.quran, fontSize: AppFonts.h3),
                        ),
                        TextSpan(
                          text: "  [ ",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                        TextSpan(
                          text: "البقرة",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.arabic, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                        TextSpan(
                          text: " : ",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                        TextSpan(
                          text: "142",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.number, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                        TextSpan(
                          text: " ]",
                          style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
                        ),
                      ],
                    ),
                  ).animate().scale(end: Offset(1, 1), delay: 500.milSec, begin: Offset(0, 0), duration: 500.milSec),
                  15.gap,
                  QiblaWidget(size: MediaQuery.of(context).size.width / 1.5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
