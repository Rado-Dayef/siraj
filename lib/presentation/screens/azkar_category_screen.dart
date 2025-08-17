import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/data/models/azkar_model.dart';
import 'package:siraj/data/models/zekr_model.dart';
import 'package:siraj/logic/cubits/azkar_cubit/azkar_cubit.dart';
import 'package:siraj/presentation/widgets/azkar_zekr_widget.dart';

class AzkarCategoryScreen extends StatelessWidget {
  const AzkarCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
    AzkarModel azkar = (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)["azkar"] as AzkarModel;
    AzkarCubit cubit = (ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>)["cubit"] as AzkarCubit;
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
                    azkar.title,
                    style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: color),
                  ).animate().scale(end: Offset(1, 1), begin: Offset(0, 0), duration: 500.milSec),
                  20.gap,
                  BlocProvider.value(
                    value: cubit,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: azkar.count,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, int index) {
                        ZekrModel zekr = azkar.azkar[index];
                        return AzkarZekrWidget(zekr, index: index, table: azkar.tableName);
                      },
                      separatorBuilder: (_, __) {
                        return 10.gap;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
