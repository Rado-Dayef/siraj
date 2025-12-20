import 'package:flutter/cupertino.dart';
import 'package:flutter_numkit/flutter_numkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:siraj/core/theme/app_colors.dart';

extension NumExtension on num {
  /// Loading
  Widget get darkLoading {
    return LoadingAnimationWidget.fourRotatingDots(color: AppColors.whiteColor, size: toDouble());
  }

  Widget get lightLoading {
    return LoadingAnimationWidget.fourRotatingDots(color: AppColors.greenColor, size: toDouble());
  }

  /// Border Radius
  BorderRadius get defaultBorderRadius {
    return 0.onlyBorderRadius(topLeft: toDouble(), bottomRight: toDouble(), topRight: toDouble() + 20, bottomLeft: toDouble() + 20);
  }
}
