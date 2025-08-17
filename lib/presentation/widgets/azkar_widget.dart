import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/routes/route_names.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/data/models/azkar_activity_model.dart';
import 'package:siraj/data/models/azkar_model.dart';
import 'package:siraj/logic/cubits/azkar_cubit/azkar_cubit.dart';
import 'package:siraj/presentation/widgets/tile_widget.dart';

class AzkarWidget extends StatelessWidget {
  final int index;
  final AzkarModel azkar;

  const AzkarWidget(this.azkar, {required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    AzkarActivityModel azkarActivity = context.read<AzkarCubit>().getTodayIsAzkarActivity(azkar);
    Color colorWithOpacity = isDark ? AppColors.whiteColor.withAlpha(150) : AppColors.greenColor.withAlpha(150);

    return TileWidget(
      azkar.title,
      onTap: () {
        Navigator.of(context).pushNamed(AppRouteNames.azkarCategory, arguments: {"azkar": azkar, "cubit": context.read<AzkarCubit>()});
      },
      subTitle: azkar.subTitle,
      trailing: Text(
        azkar.count.toString(),
        style: TextStyle(color: color, fontFamily: AppFonts.number),
      ),
      bottomWidget: Column(
        children: [
          Row(
            children: [
              Text(
                ((azkarActivity.doneAzkar / azkarActivity.totalAzkar) * 100) == 100
                    ? "100"
                    : ((azkarActivity.doneAzkar / azkarActivity.totalAzkar) * 100) > 10
                    ? ((azkarActivity.doneAzkar / azkarActivity.totalAzkar) * 100).toStringAsFixed(1)
                    : ((azkarActivity.doneAzkar / azkarActivity.totalAzkar) * 100).toStringAsFixed(2),
                style: TextStyle(color: color, fontFamily: AppFonts.number),
              ),
              10.gap,
              Expanded(
                child: LinearProgressIndicator(value: azkarActivity.doneAzkar / azkarActivity.totalAzkar, minHeight: 5, backgroundColor: colorWithOpacity, valueColor: AlwaysStoppedAnimation(color), borderRadius: 5.defaultBorderRadius),
              ),
              10.gap,
              Text(
                "100",
                style: TextStyle(color: color, fontFamily: AppFonts.number),
              ),
            ],
          ),
          10.gap,
          Row(
            children: [
              Expanded(
                child: TileWidget(
                  AppStrings.total,
                  trailing: Text(
                    azkarActivity.totalAzkar.toString(),
                    style: TextStyle(color: color, fontFamily: AppFonts.number),
                  ),
                ),
              ),
              10.gap,
              Expanded(
                child: TileWidget(
                  AppStrings.done,
                  trailing: Text(
                    azkarActivity.doneAzkar.toString(),
                    style: TextStyle(color: color, fontFamily: AppFonts.number),
                  ),
                ),
              ),
              10.gap,
              Expanded(
                child: TileWidget(
                  AppStrings.notDone,
                  trailing: Text(
                    azkarActivity.notDoneAzkar.toString(),
                    style: TextStyle(color: color, fontFamily: AppFonts.number),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().scale(end: Offset(1, 1), delay: ((index + 1) * 250).milSec, begin: Offset(0, 0), duration: 250.milSec);
  }
}
