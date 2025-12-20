import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// Screen Size
  double get screenWidth {
    return MediaQuery.sizeOf(this).width;
  }

  double get screenHeight {
    return MediaQuery.sizeOf(this).height;
  }

  /// Device
  void get hideKeyboard {
    return FocusScope.of(this).unfocus();
  }
}
