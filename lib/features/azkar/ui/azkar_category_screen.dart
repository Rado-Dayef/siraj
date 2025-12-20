import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/shared/models/zekr_model.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';
import 'package:siraj/features/azkar/data/azkar_args_model.dart';
import 'package:siraj/features/azkar/ui/widgets/azkar_zekr_widget.dart';

class AzkarCategoryScreen extends StatelessWidget {
  final AzkarArgsModel args;

  const AzkarCategoryScreen({required this.args, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: args.azkar.count,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) {
            ZekrModel zekr = args.azkar.azkar[index];
            return AzkarZekrWidget(zekr, index: index, table: args.azkar.tableName);
          },
          separatorBuilder: (_, __) {
            return 10.verticalGap;
          },
        ),
      ],
    ).defaultScaffold(title: args.azkar.title);
  }
}
