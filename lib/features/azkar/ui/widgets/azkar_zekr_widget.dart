import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:siraj/core/shared/models/zekr_model.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/context_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/azkar/logic/azkar_cubit/azkar_cubit.dart';

class AzkarZekrWidget extends StatelessWidget {
  final int index;
  final String table;
  final ZekrModel zekr;

  const AzkarZekrWidget(this.zekr, {required this.index, required this.table, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      onTap: () {
        context.read<AzkarCubit>().updateZekr(zekr: zekr, table: table, action: "dec");
      },
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: [
                TextSpan(
                  text: zekr.isQuran ? "${AppStrings.basmallah}\n" : "",
                  style: TextStyle(color: AppColors.yellowColor, fontFamily: zekr.isQuran ? AppFonts.quran : AppFonts.arabic, fontSize: AppFonts.h3),
                ),
                TextSpan(
                  text: zekr.zekr,
                  style: TextStyle(color: AppColors.whiteColor, fontFamily: AppFonts.quran, fontSize: AppFonts.h3),
                ),
                TextSpan(
                  text: zekr.note.isEmpty ? "" : "\n[ ",
                  style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: AppColors.whiteColor.withAlpha(150), fontWeight: AppFonts.bold),
                ),
                TextSpan(
                  text: zekr.note,
                  style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.arabic, color: AppColors.whiteColor.withAlpha(150), fontWeight: AppFonts.bold),
                ),
                TextSpan(
                  text: zekr.note.isEmpty ? "" : " ]",
                  style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: AppColors.whiteColor.withAlpha(150), fontWeight: AppFonts.bold),
                ),
              ],
            ),
          ),
          10.verticalGap,
          BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<AzkarCubit>().updateZekr(zekr: zekr, table: table, action: "inc");
                    },
                    icon: Icon(Icons.add, color: AppColors.whiteColor),
                  ).expanded(),
                  CircularPercentIndicator(
                    radius: 6.5.percentOf(context.screenWidth),
                    lineWidth: 5,
                    animation: true,
                    progressColor: AppColors.whiteColor,
                    animationDuration: 500,
                    animateFromLastPercent: true,
                    backgroundColor: AppColors.whiteColor.withAlpha(150),
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: (zekr.count - zekr.currentCount) / zekr.count,
                    center: Text(
                      (zekr.count - zekr.currentCount).toString(),
                      style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.number, color: AppColors.whiteColor, fontWeight: AppFonts.bold),
                    ),
                  ).expanded(),
                  IconButton(
                    onPressed: () {
                      context.read<AzkarCubit>().updateZekr(zekr: zekr, table: table, action: "reset");
                    },
                    icon: Icon(Icons.restart_alt_rounded, color: AppColors.whiteColor),
                  ).expanded(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
