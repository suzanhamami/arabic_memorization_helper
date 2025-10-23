import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/core/resources/colors_manager.dart';

List<String> typesOfQuestions = [
  "circle",
  "circle",
  "key",
  "circle",
  "circle",
  "key",
  "circle",
  "circle",
];

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 38.h,
              decoration: BoxDecoration(
                color: ColorsManager.recordingButtonYellowColor,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 14.w,
                children: [
                  ...List.generate(
                    typesOfQuestions.length,
                    (index) => Image.asset(
                      typesOfQuestions[index] == "key"
                          ? AssetsManager.key
                          : AssetsManager.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 30.w),
          IconButton(
            icon: Icon(Icons.close, color: ColorsManager.white, size: 31),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}


