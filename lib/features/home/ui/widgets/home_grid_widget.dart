import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/shared/widgets/container_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/extensions/widget_extension.dart';

class HomeGridWidget extends StatelessWidget {
  final String icon, title, route;

  const HomeGridWidget({required this.icon, required this.title, required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      onTap: () => Navigator.of(context).pushNamed(route),
      child: Column(
        children: [
          Image.asset(icon, width: 100, height: 100, color: AppColors.whiteColor),
          10.verticalGap,
          Text(
            title,
            style: TextStyle(color: AppColors.whiteColor, fontSize: AppFonts.h1),
          ),
        ],
      ),
    ).expanded();
  }
}
