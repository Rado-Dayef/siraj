import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/shared/models/azkar_model.dart';
import 'package:siraj/core/shared/widgets/err_widget.dart';
import 'package:siraj/core/utils/constants/app_strings.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/azkar/logic/azkar_cubit/azkar_cubit.dart';
import 'package:siraj/features/azkar/ui/widgets/azkar_widget.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AzkarCubit, AzkarState>(
          builder: (context, state) {
            return state.when(
              loading: () {
                return SizedBox(width: double.infinity, child: 25.darkLoading);
              },
              success: (azkar) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: azkar.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (_, int index) {
                    AzkarModel currentAzkar = azkar[index];
                    return AzkarWidget(currentAzkar, index: index);
                  },
                  separatorBuilder: (_, __) {
                    return 10.verticalGap;
                  },
                );
              },
              failure: (message) {
                return ErrWidget(message: message);
              },
            );
          },
        ),
      ],
    ).defaultScaffold(title: AppStrings.azkar);
  }
}
