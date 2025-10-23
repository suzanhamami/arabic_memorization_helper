import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/colors_manager.dart';

class StylesManager {
  static TextStyle whiteRegular14 = TextStyle(
    color: ColorsManager.white,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static TextStyle whiteBold14 = TextStyle(
    color: ColorsManager.white,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle greyBold14 = TextStyle(
    color: ColorsManager.buttonContentColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle whiteBold24 = TextStyle(
    color: ColorsManager.white,
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle whiteSemiBold12 = TextStyle(
    color: Colors.white,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
  );
}
