import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/core/resources/colors_manager.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 218.w,
            color: ColorsManager.backgroundColor,
            child: Container(
              width: 108.w,
              child: Image.asset(AssetsManager.backgroundPath),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 218.w,
            color: ColorsManager.backgroundColor,
            child: Container(
              width: 108.w,
              child: Image.asset(AssetsManager.backgroundPath),
            ),
          ),
        ],
      ),
    );
  }
}