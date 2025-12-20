import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siraj/core/route/routes.dart';
import 'package:siraj/core/shared/widgets/tile_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/constants/app_translator.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/prayer/data/prayer_model.dart';

class HomePrayerWidget extends StatelessWidget {
  final int index;
  final String? name;
  final bool isLoading;
  final PrayerModel? prayer;

  const HomePrayerWidget({this.name, this.prayer, this.isLoading = false, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return TileWidget(
      prayer?.name ?? name!,
      textColor: (prayer?.isCurrent ?? false) ? AppColors.yellowColor : AppColors.whiteColor,
      onTap: () => Navigator.of(context).pushNamed(Routes.prayer, arguments: prayer),
      border: Border.all(color: (prayer?.isCurrent ?? false) ? AppColors.yellowColor : AppColors.whiteColor),
      gradient: (prayer?.isCurrent ?? false)
          ? LinearGradient(
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomRight,
              colors: [AppColors.transparentColor.withAlpha(100), AppColors.yellowColor.withAlpha(100), AppColors.transparentColor.withAlpha(100)],
            )
          : null,
      trailing: isLoading
          ? 18.darkLoading.center()
          : RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: DateFormat("hh:mm").format(prayer!.adhan).toLowerCase(),
                    style: TextStyle(color: prayer!.isCurrent ? AppColors.yellowColor : AppColors.whiteColor, fontFamily: AppFonts.number),
                  ),
                  TextSpan(
                    text: AppStrings.space + DateFormat("a").format(prayer!.adhan).toLowerCase().languageTranslator,
                    style: TextStyle(fontSize: AppFonts.h4, fontFamily: AppFonts.arabic, color: prayer!.isCurrent ? AppColors.yellowColor : AppColors.whiteColor),
                  ),
                ],
              ),
            ),
    );
  }
}
