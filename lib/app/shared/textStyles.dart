import 'package:afrocom/app/shared/colors.dart';
import 'package:afrocom/app/shared/fonts.dart';
import 'package:flutter/cupertino.dart';

class KConstantTextStyles {
  // ignore: non_constant_identifier_names
  static TextStyle BHeading1({required double fontSize}) {
    return TextStyle(
      fontSize: fontSize,
      color: KConstantColors.whiteColor,
      fontFamily: KConstantFonts.MonteserratB,
    );
  }

  // ignore: non_constant_identifier_names
  static TextStyle MBody1({required double fontSize}) {
    return TextStyle(
        fontFamily: KConstantFonts.Monteserrat,
        color: KConstantColors.whiteColor,
        fontWeight: FontWeight.w800,
        fontSize: fontSize);
  }
}
