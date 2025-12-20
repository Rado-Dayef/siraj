import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:siraj/core/theme/app_colors.dart';
import 'package:siraj/core/theme/app_fonts.dart';
import 'package:siraj/core/utils/constants/app_images.dart';
import 'package:siraj/core/utils/extensions/num_extension.dart';

extension WidgetExtension on Widget {
  /// Alignment
  Widget expanded({Key? key, int? flex}) {
    return Expanded(key: key, flex: flex ?? 1, child: this);
  }

  /// Padding
  Widget padding({Key? key, EdgeInsets? insets}) {
    return Padding(key: key, padding: insets ?? 0.allEdgeInsets, child: this);
  }

  /// Alignment
  Widget align({Key? key, Alignment? alignment}) {
    return Align(key: key, alignment: alignment ?? Alignment.center, child: this);
  }

  /// Center
  Widget center({Key? key, double? widthFactor, double? heightFactor}) {
    return Center(key: key, widthFactor: widthFactor, heightFactor: heightFactor, child: this);
  }

  /// Directionality
  Widget directionality({Key? key, TextDirection? textDirection}) {
    return Directionality(key: key, textDirection: textDirection ?? TextDirection.rtl, child: this);
  }

  /// ClipRRect
  Widget clipRRect({Key? key, CustomClipper<RRect>? clipper, Clip? clipBehavior, BorderRadiusGeometry? borderRadius}) {
    return ClipRRect(key: key, clipper: clipper, borderRadius: borderRadius ?? 5.defaultBorderRadius, clipBehavior: clipBehavior ?? Clip.antiAlias, child: this);
  }

  /// SafeArea
  Widget safeArea({Key? key, bool? top, bool? left, bool? right, bool? bottom, EdgeInsets? minimum, bool? maintainBottomViewPadding}) {
    return SafeArea(
      key: key,
      top: top ?? true,
      left: left ?? true,
      right: right ?? true,
      bottom: bottom ?? true,
      minimum: minimum ?? 0.allEdgeInsets,
      maintainBottomViewPadding: maintainBottomViewPadding ?? false,
      child: this,
    );
  }

  /// Default Scaffold
  Widget defaultScaffold({Key? key, String? title}) {
    return Scaffold(
      key: key,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.backgroundDark), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: title == null
              ? this
              : Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: AppFonts.h1, fontWeight: AppFonts.bold, color: AppColors.whiteColor),
                    ),
                    20.verticalGap,
                    this,
                  ],
                ).singleChildScrollView(),
        ),
      ).safeArea(),
    ).directionality();
  }

  /// SingleChildScrollView
  Widget singleChildScrollView({
    Key? key,
    bool? primary,
    bool? reverse,
    Clip? clipBehavior,
    EdgeInsets? padding,
    String? restorationId,
    Axis? scrollDirection,
    ScrollPhysics? physics,
    ScrollController? controller,
    HitTestBehavior? hitTestBehavior,
    DragStartBehavior? dragStartBehavior,
    ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior,
  }) {
    return SingleChildScrollView(
      key: key,
      primary: primary,
      controller: controller,
      reverse: reverse ?? false,
      restorationId: restorationId,
      padding: padding ?? 12.allEdgeInsets,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      physics: physics ?? ClampingScrollPhysics(),
      keyboardDismissBehavior: keyboardDismissBehavior,
      scrollDirection: scrollDirection ?? Axis.vertical,
      hitTestBehavior: hitTestBehavior ?? HitTestBehavior.opaque,
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      child: this,
    );
  }
}
