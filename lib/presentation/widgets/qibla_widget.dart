import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siraj/core/constants/extensions.dart';
import 'package:siraj/core/constants/strings.dart';
import 'package:siraj/core/theme/assets.dart';
import 'package:siraj/logic/cubits/qibla_cubit/qibla_cubit.dart';
import 'package:siraj/presentation/widgets/err_widget.dart';

class QiblaWidget extends StatelessWidget {
  final double size;

  const QiblaWidget({this.size = 50, super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => QiblaCubit(),
      child: BlocBuilder<QiblaCubit, QiblaState>(
        builder: (context, state) {
          if (state is QiblaLoading) {
            return SizedBox(height: size, width: size, child: isDark ? 20.darkLoading : 20.lightLoading);
          } else if (state is QiblaSuccess) {
            return Transform.rotate(
              angle: state.angle,
              child: Image.asset(AppAssets.qibla, width: size, height: size),
            );
          } else {
            return SizedBox(
              height: size,
              width: size,
              child: ErrWidget(message: AppStrings.somethingWentWrong, onlyIcon: true),
            );
          }
        },
      ),
    );
  }
}
