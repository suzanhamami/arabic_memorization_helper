import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/core/resources/styles_manager.dart';

class SpeedRunButton extends StatelessWidget {
  const SpeedRunButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(10),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
        backgroundColor: WidgetStatePropertyAll(ColorsManager.buttonBackgroundColor),
        minimumSize: WidgetStatePropertyAll(Size(186.w, 45.h)),
      ),
      onPressed: () {},
      icon: Image.asset(
        AssetsManager.brainStorming,
        height: 33,
        width: 33,
        color: ColorsManager.buttonContentColor,
      ),
      label: Text(
        "عصف ذهني",
        style: StylesManager.greyBold14
      ),
    );
  }
}
