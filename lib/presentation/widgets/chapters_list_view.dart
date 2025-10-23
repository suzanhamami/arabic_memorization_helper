import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/core/resources/styles_manager.dart';
import 'package:internship_project/presentation/pages/home_page.dart';
import 'package:internship_project/presentation/widgets/lesson_item.dart';

class ChaptersListView extends StatelessWidget {
  const ChaptersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 64.h, horizontal: 62.w),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemExtent: 110.8,
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        bool isRight = index % 2 == 0;
        return Row(
          mainAxisAlignment: isRight
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          spacing: 79.w,
          children: [
            if (!isRight) LessonItemLeft(isDone: false, isLocked: true),
            Text("الجهاز العصبي", style: StylesManager.whiteBold14),
            if (isRight) LessonItemRight(isDone: true, isLocked: false),
          ],
        );
      },
    );
  }
}
