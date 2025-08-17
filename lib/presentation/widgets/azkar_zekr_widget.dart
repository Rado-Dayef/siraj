import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/data/models/zekr_model.dart';
import 'package:siraj/logic/cubits/azkar_cubit/azkar_cubit.dart';
import 'package:siraj/presentation/widgets/container_widget.dart';

class AzkarZekrWidget extends StatelessWidget {
  final int index;
  final String table;
  final ZekrModel zekr;

  const AzkarZekrWidget(this.zekr, {required this.index, required this.table, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    Color colorWithOpacity = isDark ? AppColors.whiteColor.withAlpha(150) : AppColors.greenColor.withAlpha(150);

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
                  style: TextStyle(color: color, fontFamily: AppFonts.quran, fontSize: AppFonts.h3),
                ),
                TextSpan(
                  text: zekr.note.isEmpty ? "" : "\n[ ",
                  style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
                ),
                TextSpan(
                  text: zekr.note,
                  style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.arabic, color: colorWithOpacity, fontWeight: AppFonts.bold),
                ),
                TextSpan(
                  text: zekr.note.isEmpty ? "" : " ]",
                  style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.quran, color: colorWithOpacity, fontWeight: AppFonts.bold),
                ),
              ],
            ),
          ),
          10.gap,
          BlocBuilder<AzkarCubit, AzkarState>(
            builder: (context, state) {
              return Row(
                children: [
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      context.read<AzkarCubit>().updateZekr(zekr: zekr, table: table, action: "inc");
                    },
                    icon: Icon(Icons.add, color: color),
                  ),
                  Spacer(),
                  CircularPercentIndicator(
                    radius: (MediaQuery.of(context).size.width / 7.5) / 2,
                    lineWidth: 5,
                    animation: true,
                    progressColor: color,
                    animationDuration: 500,
                    animateFromLastPercent: true,
                    backgroundColor: colorWithOpacity,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: (zekr.count - zekr.currentCount) / zekr.count,
                    center: Text(
                      (zekr.count - zekr.currentCount).toString(),
                      style: TextStyle(fontSize: AppFonts.h5, fontFamily: AppFonts.number, color: color, fontWeight: AppFonts.bold),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      context.read<AzkarCubit>().updateZekr(zekr: zekr, table: table, action: "reset");
                    },
                    icon: Icon(Icons.restart_alt_rounded, color: color),
                  ),
                  Spacer(),
                ],
              );
            },
          ),
        ],
      ),
    ).animate().scale(end: const Offset(1, 1), delay: ((index + 1) * 250).milSec, begin: const Offset(0, 0), duration: 250.milSec);
  }
}
