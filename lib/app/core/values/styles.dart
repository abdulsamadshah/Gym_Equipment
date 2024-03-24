import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextStyles {
  double devicePixelRatio = MediaQuery.of(Get.context!).devicePixelRatio;
  static TextStyle headingOneStyle({Color color = Colors.black87}) {
    return TextStyle(
        color: color, fontSize: 30.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle headingTwoStyle({Color color = Colors.black87}) {
    return TextStyle(
        color: color, fontSize: 20.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle headingThreeStyle({Color color = Colors.black87}) {
    return TextStyle(
        color: color, fontSize: 18.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle headingFourStyle({Color color = Colors.black87}) {
    return TextStyle(
        color: color, fontSize: 16.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle headingFiveStyle({Color color = Colors.black87}) {
    return TextStyle(
        color: color, fontSize: 14.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle headingSixStyle(
      {Color color = Colors.black87, TextDecoration? textDecoration}) {
    return TextStyle(
        color: color,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        decoration: textDecoration);
  }

  static TextStyle subtitleNormalStyle({Color color = Colors.black87}) {
    return TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w400);
  }

  static TextStyle subtitleMediumStyle({Color color = Colors.black87}) {
    return TextStyle(
        color: color, fontSize: 12.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle subtitleBoldStyle({Color color = Colors.black87}) {
    return TextStyle(
        color: color, fontSize: 12.sp, fontWeight: FontWeight.w600);
  }

  static TextStyle listTileTitleTextStyle({Color color = Colors.white}) {
    return TextStyle(
        color: color, fontSize: 14.sp, fontWeight: FontWeight.w500);
  }

  static TextStyle listTileSubTitleTextStyle({Color color = Colors.white}) {
    return TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w500);
  }
}
