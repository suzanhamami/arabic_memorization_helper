import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/core/resources/colors_manager.dart';

class DecoratedRecordingButton extends StatelessWidget {
  const DecoratedRecordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      width: 96.48.w,
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: [
            ColorsManager.recordingButtonGreenColor,
            ColorsManager.recordingButtonYellowColor,
            ColorsManager.recordingButtonPinkColor,
            ColorsManager.recordingButtonBlueColor,
            ColorsManager.recordingButtonGreenColor,
          ],
          // stops: [0.0, 0.3, 0.6, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.recordingButtonShadowColor,
            blurRadius: 16,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Image.asset(
        AssetsManager.record,
        color: ColorsManager.white,
        height: 37.h,
        width: 37.w,
      ),
    );
  }
}

class RecordingButton extends StatelessWidget {
  const RecordingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37.h,
      width: 85.w,
      decoration: BoxDecoration(
        color: ColorsManager.recordingButtonColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Image.asset(
        AssetsManager.record,
        color: ColorsManager.white,
        height: 32.h,
        width: 32.w,
      ),
    );
  }
}
