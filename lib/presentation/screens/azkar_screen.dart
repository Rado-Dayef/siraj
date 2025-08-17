import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/core/theme/colors.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/data/models/azkar_model.dart';
import 'package:siraj/logic/cubits/azkar_cubit/azkar_cubit.dart';
import 'package:siraj/presentation/widgets/azkar_widget.dart';
import 'package:siraj/presentation/widgets/err_widget.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color color = isDark ? AppColors.whiteColor : AppColors.greenColor;
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
                    AppStrings.azkar,
                    style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: color),
                  ).animate().scale(end: Offset(1, 1), begin: Offset(0, 0), duration: 500.milSec),
                  20.gap,
                  BlocProvider(
                    create: (context) => AzkarCubit(),
                    child: BlocBuilder<AzkarCubit, AzkarState>(
                      builder: (context, state) {
                        if (state is AzkarLoading) {
                          return SizedBox(
                            width: double.infinity,
                            child: isDark
                                ? 25.darkLoading.animate().scale(end: Offset(1, 1), delay: 500.milSec, begin: Offset(0, 0), duration: 500.milSec).scale(end: Offset(0, 0), delay: 6000.milSec, begin: Offset(1, 1), duration: 500.milSec)
                                : 25.lightLoading.animate().scale(end: Offset(1, 1), delay: 500.milSec, begin: Offset(0, 0), duration: 500.milSec).scale(end: Offset(0, 0), delay: 6000.milSec, begin: Offset(1, 1), duration: 500.milSec),
                          );
                        } else if (state is AzkarSuccess) {
                          return ListView.separated(
                            shrinkWrap: true,
                            itemCount: state.azkar.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (_, int index) {
                              AzkarModel azkar = state.azkar[index];
                              return AzkarWidget(azkar, index: index);
                            },
                            separatorBuilder: (_, __) {
                              return 10.gap;
                            },
                          );
                        } else if (state is AzkarFailure) {
                          return ErrWidget(message: state.message);
                        } else {
                          return ErrWidget(message: AppStrings.somethingWentWrong);
                        }
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
