// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/presentation/pages/memorization_page.dart';
import 'package:internship_project/presentation/widgets/chapter_item.dart';

final chapters = List.generate(20, (index) => 1);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF373737),
        elevation: 10,
        shadowColor: Color(0xFF383838),
        bottomOpacity: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 46.w,
            height: 46.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD9D9D9),
            ),
            child: Icon(Icons.search, color: Color(0xFF000000)),
          ),
        ),
      ),
      backgroundColor: Color(0xFF373737),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 218.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF6F6F6F),
                              Color(0xFFD5D5D5),
                              // Color(0xD1D5D5D5),
                              Color(0xFF6F6F6F),
                            ],
                          ),
                        ),
                        child: Container(
                          width: 108.w,
                          child: Image.asset(AssetsManager.backgroundPath),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 218.w,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF6F6F6F),
                              Color(0xFFD5D5D5),
                              Color(0xFF6F6F6F),
                            ],
                          ),
                        ),
                        child: Container(
                          width: 108.w,
                          child: Image.asset(AssetsManager.backgroundPath),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: 64.h,
                    horizontal: 62.w,
                  ),
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
                        if (!isRight)
                          ChapterItemLeft(isDone: false, isLocked: true),
                        Text(
                          "الجهاز العصبي",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        if (isRight)
                          ChapterItemRight(isDone: true, isLocked: false),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(10),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          backgroundColor: WidgetStatePropertyAll(Color(0xFFF0FEAC)),
          minimumSize: WidgetStatePropertyAll(Size(186.w, 45.h)),
        ),
        onPressed: () {},
        icon: Image.asset(
          AssetsManager.brainStorming,
          height: 33,
          width: 33,
          color: Color(0xFF3C3932),
        ),
        label: Text(
          "عصف ذهني",
          style: TextStyle(
            color: Color(0xFF3C3932),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

buildBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: BoxConstraints(
      maxWidth: 359.w,
      maxHeight: 391.h,
      minHeight: 391.h,
    ),
    context: context,
    builder: (context) {
      // double idk = context.size!.width;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 391.h,
            decoration: BoxDecoration(
              color: Color(0xFF727272),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Container(height: 391.h, color: Color(0xFFACDDFF)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 119.h),
              Divider(color: Color(0x7EFFFFFF), indent: 27.w, endIndent: 27.w),
              Padding(
                padding: const EdgeInsets.only(right: 27.0),
                child: Text(
                  ": سنتعلم في هذا الدرس",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 27.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "أقسام الجهاز العصبي •",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "أقسام المخ و المخيخ •",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "وظائف الجهاز العصبي •",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
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
            child: ElevatedButton.icon(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll(10),
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                backgroundColor: WidgetStatePropertyAll(Color(0xFFF0FEAC)),
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
                  color: Color(0xFF3C3932),
                ),
              ),
              label: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "بدء الدرس",
                  style: TextStyle(
                    color: Color(0xFF3C3932),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: (MediaQuery.sizeOf(context).width / 3).w,
            top: -57.h,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(110, 0, 0, 0),
                    offset: Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 53.5.r,
                backgroundColor: Color(0xFFACDDFF),
                child: CircleAvatar(
                  radius: 44.5.r,
                  backgroundImage: AssetImage(AssetsManager.chapter1),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
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
