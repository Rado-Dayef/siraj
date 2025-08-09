import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:siraj/core/theme/colors.dart';

extension NumExtension on num {
  /// Loading
  Widget get darkLoading {
    return LoadingAnimationWidget.fourRotatingDots(color: AppColors.whiteColor, size: toDouble());
  }

  Widget get lightLoading {
    return LoadingAnimationWidget.fourRotatingDots(color: AppColors.greenColor, size: toDouble());
  }

  /// Gap
  SizedBox get gap {
    return SizedBox(height: toDouble(), width: toDouble());
  }

  /// Edge Insets
  EdgeInsets get edgeInsetsAll {
    return EdgeInsets.all(toDouble());
  }

  EdgeInsets get edgeInsetsVertical {
    return EdgeInsets.symmetric(vertical: toDouble());
  }

  EdgeInsets get edgeInsetsHorizontal {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }

  /// Border Radius
  BorderRadius get borderRadiusAll {
    return BorderRadius.circular(toDouble());
  }

  BorderRadius get defaultBorderRadius {
    return BorderRadius.only(
      topLeft: Radius.circular(toDouble()),
      bottomRight: Radius.circular(toDouble()),
      topRight: Radius.circular(toDouble() + 20),
      bottomLeft: Radius.circular(toDouble() + 20),
    );
  }

  /// Duration
  Duration get hour {
    return Duration(hours: toInt());
  }

  Duration get min {
    return Duration(minutes: toInt());
  }

  Duration get sec {
    return Duration(seconds: toInt());
  }

  Duration get milSec {
    return Duration(milliseconds: toInt());
  }

  Duration get micSec {
    return Duration(microseconds: toInt());
  }
}
