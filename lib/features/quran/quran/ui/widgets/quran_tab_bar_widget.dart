import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/quran/quran/logic/quran_cubit/quran_cubit.dart';

class QuranTabBarWidget extends StatelessWidget {
  final String category;
  final bool isSelected;

  const QuranTabBarWidget(this.category, {required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      onTap: () => context.read<QuranCubit>().changeTab(category),
      border: isSelected ? Border.all(color: AppColors.yellowColor) : null,
      gradient: isSelected
          ? LinearGradient(
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomRight,
              colors: [AppColors.transparentColor.withAlpha(100), AppColors.yellowColor.withAlpha(100), AppColors.transparentColor.withAlpha(100)],
            )
          : null,
      child: Text(
        category,
        style: TextStyle(fontSize: AppFonts.h2, fontWeight: isSelected ? AppFonts.bold : null, color: isSelected ? AppColors.yellowColor : AppColors.whiteColor),
      ),
    ).expanded();
  }
}
