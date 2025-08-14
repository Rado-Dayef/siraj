import 'package:flutter/material.dart';
import 'package:siraj/core/theme/fonts.dart';
import 'package:siraj/presentation/widgets/container_widget.dart';

class TileWidget extends StatelessWidget {
  final Color color;
  final String title;
  final Widget trailing;

  const TileWidget(this.title, {required this.color, required this.trailing, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: AppFonts.h2, color: color),
          ),
          Spacer(),
          Expanded(flex: 0, child: trailing),
        ],
      ),
    );
  }
}
