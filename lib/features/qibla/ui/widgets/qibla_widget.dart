import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/shared/widgets/err_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_icons.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/features/qibla/logic/qibla_cubit/qibla_cubit.dart';

class QiblaWidget extends StatelessWidget {
  final double size;
  final Color color;

  const QiblaWidget({this.size = 50, this.color = AppColors.whiteColor, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QiblaCubit(),
      child: BlocBuilder<QiblaCubit, QiblaState>(
        builder: (context, state) {
          return state.when(
            loading: () {
              return SizedBox(height: size, width: size, child: 25.percentOf(size).darkLoading);
            },
            success: (angle) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: angle,
                    child: Image.asset(AppIcons.qiblaCompass, width: size, height: size, color: color),
                  ),
                  20.verticalGap,
                  ContainerWidget(
                    width: size,
                    child: Text(
                      "° ${angle.radToDeg.toStringAsFixed(2)}",
                      style: TextStyle(color: color, fontFamily: AppFonts.number, fontSize: AppFonts.h2),
                    ),
                  ),
                ],
              );
            },
            failure: (message) {
              return SizedBox(
                width: size,
                height: size,
                child: ErrWidget(message: AppStrings.somethingWentWrong, onlyIcon: true, size: 80.percentOf(size)),
              );
            },
          );
        },
      ),
    );
  }
}
