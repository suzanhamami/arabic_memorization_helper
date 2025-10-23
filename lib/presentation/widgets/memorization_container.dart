import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/colors_manager.dart';

class MemorizationContainer extends StatelessWidget {
  const MemorizationContainer({
    super.key,
    required this.isRecording,
    required this.child,
  });

  final bool isRecording;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 21.w, right: 21.w, top: 10.h),
      width: 351.w,
      decoration: BoxDecoration(
        color: ColorsManager.memorizationContainerColor,
        boxShadow: isRecording
            ? [
                BoxShadow(
                  color: ColorsManager.memorizationContainerShadowColor,
                  blurRadius: 7,
                  blurStyle: BlurStyle.solid,
                ),
              ]
            : null,
        border: isRecording
            ? Border.all(color: ColorsManager.recordingButtonYellowColor, width: 0.2)
            : null,
        borderRadius: BorderRadius.all(Radius.circular(25.r)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 39.h),
        child: child,
      ),
    );
  }
}