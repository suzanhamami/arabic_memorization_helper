import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_project/core/resources/colors_manager.dart';
import 'package:internship_project/core/resources/styles_manager.dart';

List<String> menuItems = ["علوم", "رياضيات"];

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.appBarColor,
      surfaceTintColor: ColorsManager.appBarColor,
      elevation: 10,
      shadowColor: ColorsManager.appBarColor,
      actionsPadding: EdgeInsets.symmetric(horizontal: 30),
      leadingWidth: 70.w,
      leading: Padding(
        padding: EdgeInsetsGeometry.only(left: 30),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorsManager.searchButtonColor,
          ),
          child: IconButton(
            icon: Icon(Icons.search, color: ColorsManager.black),
            onPressed: () {},
          ),
        ),
      ),
      actions: [
        DropdownMenu<String>(
          width: 110.w,
          initialSelection: "علوم",
          menuStyle: MenuStyle(
            fixedSize: WidgetStatePropertyAll(Size.fromWidth(110.w)),
            backgroundColor: WidgetStateProperty.all(ColorsManager.appBarColor),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
          textStyle: StylesManager.whiteBold24,
          inputDecorationTheme: InputDecorationTheme(
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorsManager.transparentColor),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            filled: true,
            fillColor: ColorsManager.appBarColor,
          ),
          trailingIcon: const Icon(
            Icons.arrow_drop_down,
            color: ColorsManager.white,
          ),
          selectedTrailingIcon: const Icon(
            Icons.arrow_drop_up,
            color: ColorsManager.white,
          ),
          dropdownMenuEntries: menuItems
              .map(
                (item) => DropdownMenuEntry<String>(
                  value: item,
                  label: item,
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                      ColorsManager.white,
                    ),
                    textStyle: WidgetStateProperty.all(
                      StylesManager.whiteRegular14
                    ),
                  ),
                ),
              )
              .toList(),
          onSelected: (value) {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(74.h);
}
