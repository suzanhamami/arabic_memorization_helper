import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/core/resources/styles_manager.dart';
import 'package:internship_project/presentation/widgets/buttom_sheet_circle.dart';
import 'package:internship_project/presentation/widgets/start_lesson_button.dart';

class FullButtomSheet extends StatelessWidget {
  const FullButtomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 391.h,
          decoration: BoxDecoration(
            color: ColorsManager.buttomSheetColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: ClipPath(
            clipper: MyCustomClipper(),
            child: Container(height: 391.h, color: ColorsManager.blueColor),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 119.h),
            Divider(
              color: ColorsManager.dividerColor,
              indent: 27.w,
              endIndent: 27.w,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 27.0),
              child: Text(
                ": سنتعلم في هذا الدرس",
                style: StylesManager.whiteBold14
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 27.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "أقسام الجهاز العصبي •",
                    style: StylesManager.whiteRegular14
                  ),
                  Text(
                    "أقسام المخ و المخيخ •",
                    style: StylesManager.whiteRegular14
                  ),
                  Text(
                    "وظائف الجهاز العصبي •",
                    style: StylesManager.whiteRegular14
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          // TODO: fix left to make it lay at the middle of the bottom sheet
          left: 30.w,
          bottom: 27.h,
          child: StartLessonButton(),
        ),
        Positioned(
          left: (MediaQuery.sizeOf(context).width / 3).w,
          top: -57.h,
          child: ButtomSheetCircle(),
        ),
      ],
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 25;
    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius))
      ..lineTo(size.width, 98.5.h)
      ..lineTo(size.width / 2, 68.5.h)
      ..lineTo(0, 98.5.h)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
