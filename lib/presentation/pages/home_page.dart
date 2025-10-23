// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/presentation/widgets/background.dart';
import 'package:internship_project/presentation/widgets/buttom_sheet.dart';
import 'package:internship_project/presentation/widgets/chapters_list_view.dart';
import 'package:internship_project/presentation/widgets/home_appbar.dart';
import 'package:internship_project/presentation/widgets/speedrun_button.dart';

final chapters = List.generate(20, (index) => 1);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomePageAppBar(),
      backgroundColor: ColorsManager.scaffoldColor,
      body: SingleChildScrollView(
        child: Stack(children: [Background(), ChaptersListView()]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SpeedRunButton(),
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
      return FullButtomSheet();
    },
  );
}
