import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/presentation/pages/home_page.dart';

class LessonItemLeft extends StatelessWidget {
  bool isDone;
  bool isLocked;
  LessonItemLeft({Key? key, required this.isDone, required this.isLocked})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          LeftArrow(),
          AvatarTemp(isDone: isDone, isLocked: isLocked),
        ],
      ),
    );
  }
}

class LessonItemRight extends StatelessWidget {
  bool isDone;
  bool isLocked;
  LessonItemRight({Key? key, required this.isDone, required this.isLocked})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        buildBottomSheet(context);
      },
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          RightArrow(),
          AvatarTemp(isDone: isDone, isLocked: isLocked),
        ],
      ),
    );
  }
}

class RightArrow extends StatelessWidget {
  const RightArrow({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 32.w,
      child: Transform.rotate(
        angle: math.pi,
        child: Icon(
          Icons.play_arrow_rounded,
          color: ColorsManager.chapterItemColor,
          size: 28,
        ),
      ),
    );
  }
}

class LeftArrow extends StatelessWidget {
  const LeftArrow({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 32.w,
      child: Icon(
        Icons.play_arrow_rounded,
        color: ColorsManager.chapterItemColor,
        size: 28,
      ),
    );
  }
}

class AvatarTemp extends StatelessWidget {
  const AvatarTemp({super.key, required this.isDone, required this.isLocked});

  final bool isDone;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: ColorsManager.chapterItemColor,
      radius: 25.r,
      child: CircleAvatar(
        radius: 21.r,
        backgroundImage: AssetImage(AssetsManager.chapter1),
        child: isDone
            ? Image.asset(AssetsManager.correctIcon, width: 21.w, height: 21.h)
            : isLocked
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorsManager.halfWhite,
                ),
                child: SizedBox(
                  height: 21.h,
                  width: 21.w,
                  child: Image.asset(AssetsManager.lockIcon),
                ),
              )
            : null,
      ),
    );
  }
}
