import 'package:fluttertoast/fluttertoast.dart';
import 'package:siraj/core/theme/app_colors.dart';

extension StringExtension on String {
  Future<bool?> get showToast {
    return Fluttertoast.showToast(msg: this, textColor: AppColors.whiteColor, backgroundColor: AppColors.yellowColor);
  }
}
