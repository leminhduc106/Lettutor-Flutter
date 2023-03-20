import 'package:flutter/material.dart';

ThemeData baseTheme() {
  final ThemeData base = ThemeData(
    fontFamily: BaseTextStyle.appFontFamily,
    backgroundColor: Colors.white,
    dividerColor: BaseColor.hint,
    errorColor: BaseColor.red,
    focusColor: BaseColor.blue,
    hintColor: BaseColor.hint,
    primaryColor: BaseColor.blue,
  );
  return base;
}

class AppColors {
  static Color primary = Colors.blue;
  static Color primarySecondary = const Color(0xff0040F6);
  static Color greyText = Colors.grey[600] as Color;
  static Color greyBackground = Colors.grey.shade200;
}

class BaseColor {
  static const Color black = Color(0xFF222222);
  static const Color hint = Color(0xFFA3A3A3);
  static const Color lightGrey = Color(0xFFF3F3F3);
  static const Color blue = Color.fromARGB(255, 66, 120, 226);
  static const Color secondaryBlue = Color.fromARGB(255, 46, 133, 226);
  static const Color off = Color(0xFFC3CAE9);
  static const Color orange = Color(0xFFFF9900);
  static const Color secondaryOrange = Color(0xFFFFF5E5);
  static const Color red = Color(0xFFD43513);
  static const Color secondaryRed = Color(0xFFFBEAE9);
  static const Color green = Color(0xFF00C11F);
  static const Color secondaryGreen = Color(0xFFE9FCEC);
}

class BaseTextStyle {
  static const appFontFamily = "Roboto";

  static TextStyle heading1({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Regular",
        fontSize: fontSize ?? 32,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w400);
  }

  static TextStyle heading2({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Medium",
        fontSize: fontSize ?? 24,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w500);
  }

  static TextStyle heading3({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Regular",
        fontSize: fontSize ?? 24,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w400);
  }

  static TextStyle heading4({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Bold",
        fontSize: fontSize ?? 24,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w600);
  }

  static TextStyle heading5({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Regular",
        fontSize: fontSize ?? 20,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w400);
  }

  static TextStyle subtitle1({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Medium",
        fontSize: fontSize ?? 18,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w500);
  }

  static TextStyle subtitle2({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Medium",
        fontSize: fontSize ?? 14,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w500);
  }

  static TextStyle subtitle3({Color? color, double? fontSize}) {
    return TextStyle(
        decoration: TextDecoration.underline,
        fontFamily: "${BaseTextStyle.appFontFamily}-Medium",
        fontSize: fontSize ?? 16,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w500);
  }

  static TextStyle body1({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Regular",
        fontSize: fontSize ?? 18,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w400);
  }

  static TextStyle body2({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Medium",
        fontSize: fontSize ?? 14,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w400);
  }

  static TextStyle body3({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Bold",
        fontSize: fontSize ?? 16,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w600);
  }

  static TextStyle button({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Medium",
        fontSize: fontSize ?? 16,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w600);
  }

  static TextStyle caption({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Medium",
        fontSize: fontSize ?? 12,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w500);
  }

  static TextStyle navigation({Color? color, double? fontSize}) {
    return TextStyle(
        fontFamily: "${BaseTextStyle.appFontFamily}-Medium",
        fontSize: fontSize ?? 10,
        color: color ?? BaseColor.black,
        fontWeight: FontWeight.w500);
  }
}

class BaseBoxShadow {
  static BoxShadow componentBoxShadow = BoxShadow(
      color: BaseColor.blue.withOpacity(0.15),
      blurRadius: 8,
      offset: const Offset(0, 0));

  static BoxShadow common = BoxShadow(
      color: BaseColor.blue.withOpacity(0.15),
      blurRadius: 8,
      spreadRadius: -4,
      offset: const Offset(1, -2));

  static BoxShadow avatarCard = BoxShadow(
      color: BaseColor.blue.withOpacity(0.15),
      blurRadius: 8,
      spreadRadius: -1,
      offset: const Offset(0, 0));
}
