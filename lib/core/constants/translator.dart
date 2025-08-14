import 'package:siraj/core/constants/strings.dart';

class AppTranslator {
  static String convert(Object value) {
    if (value is int) {
      return toArabic(value.toString());
    } else {
      return toArabic(value as String);
    }
  }

  static String toArabic(String value) {
    return value
        .replaceAll("am", AppStrings.am)
        .replaceAll("pm", AppStrings.pm)
        .replaceAll("May", AppStrings.may)
        .replaceAll("June", AppStrings.june)
        .replaceAll("July", AppStrings.july)
        .replaceAll("March", AppStrings.march)
        .replaceAll("April", AppStrings.april)
        .replaceAll("August", AppStrings.august)
        .replaceAll("Friday", AppStrings.friday)
        .replaceAll("Sunday", AppStrings.sunday)
        .replaceAll("Monday", AppStrings.monday)
        .replaceAll("January", AppStrings.january)
        .replaceAll("Tuesday", AppStrings.tuesday)
        .replaceAll("Thursday", AppStrings.thursday)
        .replaceAll("Saturday", AppStrings.saturday)
        .replaceAll("October", AppStrings.october)
        .replaceAll("November", AppStrings.november)
        .replaceAll("December", AppStrings.december)
        .replaceAll("February", AppStrings.february)
        .replaceAll("September", AppStrings.september)
        .replaceAll("Wednesday", AppStrings.wednesday);
  }
}

extension ArabicExtensions on String {
  String get languageTranslator {
    return AppTranslator.convert(this);
  }
}
