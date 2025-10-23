import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/core/resources/colors_manager.dart';

class ButtomSheetCircle extends StatelessWidget {
  const ButtomSheetCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.shadowColor,
            offset: Offset(0, 4),
            blurRadius: 20,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 53.5.r,
        backgroundColor: ColorsManager.blueColor,
        child: CircleAvatar(
          radius: 44.5.r,
          backgroundImage: AssetImage(AssetsManager.chapter1),
        ),
      ),
    );
  }
}
