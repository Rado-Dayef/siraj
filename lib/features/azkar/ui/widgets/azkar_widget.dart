import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/route/routes.dart';
import 'package:siraj/core/shared/models/azkar_model.dart';
import 'package:siraj/core/shared/widgets/tile_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/azkar/data/azkar_activity_model.dart';
import 'package:siraj/features/azkar/data/azkar_args_model.dart';
import 'package:siraj/features/azkar/logic/azkar_cubit/azkar_cubit.dart';

class AzkarWidget extends StatelessWidget {
  final int index;
  final AzkarModel azkar;

  const AzkarWidget(this.azkar, {required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    AzkarActivityModel azkarActivity = context.read<AzkarCubit>().getTodayIsAzkarActivity(azkar);
    return TileWidget(
      azkar.title,
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.azkarCategory,
          arguments: AzkarArgsModel(azkar: azkar, cubit: context.read<AzkarCubit>()),
        );
      },
      subTitle: azkar.subTitle,
      trailing: Text(
        azkar.count.toString(),
        style: TextStyle(color: AppColors.whiteColor, fontFamily: AppFonts.number),
      ),
      bottomWidget: Column(
        children: [
          Row(
            children: [
              LinearProgressIndicator(
                value: azkarActivity.doneAzkar / azkarActivity.totalAzkar,
                minHeight: 5,
                backgroundColor: AppColors.whiteColor.withAlpha(150),
                valueColor: AlwaysStoppedAnimation(AppColors.whiteColor),
                borderRadius: 5.defaultBorderRadius,
              ).expanded(),
              10.horizontalGap,
              Text(
                "${((azkarActivity.doneAzkar / azkarActivity.totalAzkar) * 100).toStringAsFixed(0)}%",
                style: TextStyle(color: AppColors.whiteColor, fontSize: AppFonts.h6, fontFamily: AppFonts.number),
              ),
            ],
          ),
          10.verticalGap,
          Row(
            children: [
              TileWidget(
                AppStrings.done,
                trailing: Text(
                  azkarActivity.doneAzkar.toString(),
                  style: TextStyle(color: AppColors.whiteColor, fontFamily: AppFonts.number),
                ),
              ).expanded(),
              10.horizontalGap,
              TileWidget(
                AppStrings.notDone,
                trailing: Text(
                  azkarActivity.notDoneAzkar.toString(),
                  style: TextStyle(color: AppColors.whiteColor, fontFamily: AppFonts.number),
                ),
              ).expanded(),
            ],
          ),
        ],
      ),
    );
  }
}
