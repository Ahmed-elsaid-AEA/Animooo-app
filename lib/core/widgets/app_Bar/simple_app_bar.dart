import 'package:animooo/core/resources/width_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_values_manager.dart';
import '../../../core/resources/colors_manager.dart';
import '../../../core/resources/conts_values.dart';
import '../../../core/resources/fonts_size_manager.dart';
import '../../../core/resources/padding_manager.dart';

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SimpleAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: ColorManager.kWhiteColor,
      titleSpacing: 0,
      leadingWidth: WidthManager.w38,
      leading: Padding(
        padding: EdgeInsetsGeometry.only(
          left: PaddingManager.pw18,
          bottom: PaddingManager.ph4,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            CupertinoIcons.back,
            color: ColorManager.kPrimaryColor,
            size: FontSizeManager.s20,
          ),
        ),
      ),
      title: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text(
          title,
          style: TextStyle(
            fontFamily: FontsManager.otamaEpFontFamily,
            fontSize: FontSizeManager.s20,
            color: ColorManager.kPrimaryColor,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
