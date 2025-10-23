  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/assets_manager.dart';
import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/core/resources/styles_manager.dart';
import 'package:internship_project/presentation/widgets/recording_button.dart';


class MemorizationBottomBar extends StatelessWidget {
  bool isRecording;
  Function audioRecording;
  MemorizationBottomBar({
    Key? key,
    required this.isRecording,
    required this.audioRecording,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.all(0),
      color: ColorsManager.transparentColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("الجهاز العصبي •", style: StylesManager.whiteSemiBold12),
            Spacer(),
            InkWell(
              onTap: () async {
                await audioRecording();
              },
              child: isRecording
                  ? DecoratedRecordingButton()
                  : RecordingButton(),
            ),
            Spacer(),
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
    );
  }
}
