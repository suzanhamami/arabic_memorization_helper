import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/core/resources/styles_manager.dart';
import 'package:internship_project/presentation/pages/memorization_page.dart';

class StartLessonButton extends StatelessWidget {
  const StartLessonButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(10),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        ),
        backgroundColor: WidgetStatePropertyAll(ColorsManager.buttonBackgroundColor),
        minimumSize: WidgetStatePropertyAll(Size(302.w, 47.h)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemorizationPage()),
        );
      },
      icon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Image.asset(
          AssetsManager.shuffle,
          height: 33,
          width: 33,
          color: ColorsManager.buttonContentColor,
        ),
      ),
      label: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          "بدء الدرس",
          style: StylesManager.greyBold14
        ),
      ),
    );
  }
}