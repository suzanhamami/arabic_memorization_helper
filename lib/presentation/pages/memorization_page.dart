// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_project/core/resources/assets_manager.dart';

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

class MemorizationPage extends StatefulWidget {
  const MemorizationPage({super.key});

  @override
  State<MemorizationPage> createState() => _MemorizationPageState();
}

class _MemorizationPageState extends State<MemorizationPage> {
  bool isRecording = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF373737),
      body: Column(
        children: [
          SafeArea(child: SizedBox()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: 28,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 38.h,
                  width: 282.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFF0FEAC),
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
                Spacer(),
                Icon(Icons.close, color: Colors.white, size: 31),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 21.w, right: 21.w, top: 10.h),
              // height: 584.h,
              // width: 351.w,
              decoration: BoxDecoration(
                color: Color(0xFF242424),
                boxShadow: isRecording
                    ? [
                        BoxShadow(
                          color: Color.fromARGB(111, 240, 254, 172),
                          blurRadius: 7,
                          blurStyle: BlurStyle.solid,
                          // spreadRadius: ,
                        ),
                      ]
                    : null,
                border: isRecording
                    ? Border.all(color: Color(0xFFF0FEAC), width: 0.2)
                    : null,
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
              ),
              child: !isRecording
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w,
                        vertical: 39.h,
                      ),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Harum placeat tempora quo ullam quam eos consequatur sunt dolores magnam magni dicta aliquid eveniet blanditiis, rerum est maiores. Facilis dolore debitis nihil quis! Quam, vitae illo asperiores veniam, sunt odit quisquam voluptates veritatis quo numquam neque doloribus nulla, dolores similique unde.",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                    )
                  : null,
            ),
          ),
          BottomAppBar(
            padding: EdgeInsets.all(0),
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // spacing: 30,
                children: [
                  Text(
                    "الجهاز العصبي •",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  // SizedBox(width: 33.w),
                  InkWell(
                    onTap: () {
                      isRecording ? isRecording = false : isRecording = true;
                      setState(() {});
                    },
                    child: isRecording
                        ? DecoratedRecordingButton()
                        : RecordingButton(),
                  ),
                  Spacer(),
                  // SizedBox(width: 33.w),
                  Row(
                    spacing: 16.w,
                    children: [
                      Icon(Icons.wb_sunny_rounded, color: Colors.white),
                      Image.asset(AssetsManager.fontSize),
                      Image.asset(
                        AssetsManager.ear,
                        color: isRecording ? Color(0x7EFFFFFF) : Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
            Color(0xFFC6FFC2),
            Color(0xFFF0FEAC),
            Color(0xFFEDB2FF),
            Color(0xFFACDDFF),
            Color(0xFFC6FFC2),
          ],
          // stops: [0.0, 0.3, 0.6, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(250, 255, 222, 0.37),
            blurRadius: 16,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Image.asset(
        AssetsManager.record,
        color: Colors.white,
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
        color: Color(0xFF4E4E4E),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Image.asset(
        AssetsManager.record,
        color: Colors.white,
        height: 32.h,
        width: 32.w,
      ),
    );
  }
}
