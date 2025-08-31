import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/padding_manager.dart';

class HomePageCategories extends StatelessWidget {
  const HomePageCategories({super.key, required this.onPressedAddNewCategory});

  final VoidCallback onPressedAddNewCategory;

  @override
  Widget build(BuildContext context) {
    int length = 12;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: PaddingManager.pw16,
          ),
          child: _TitleCategory(
            onPressedAddNewCategory: onPressedAddNewCategory,
          ),
        ),
        VerticalSpace(HeightsManager.h22),
        SizedBox(
          height: HeightsManager.h82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => index == 0
                ? HorizontalSpace(WidthManager.w16)
                : index == length - 1
                ? Center(child: TextButton(onPressed: () {}, child: Text("See More")))
                : Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: AssetImage(
                          'assets/image/background_splash_screen_undrer_12.png',
                        ),
                      ),

                    ],
                  ),
            separatorBuilder: (context, index) =>
                HorizontalSpace(WidthManager.w20),
            itemCount: length,
          ),
        ),
      ],
    );
  }
}

class _TitleCategory extends StatelessWidget {
  const _TitleCategory({required this.onPressedAddNewCategory});

  final VoidCallback onPressedAddNewCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: PaddingManager.pw6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${ConstsValuesManager.categories} ( 20 )",
            //TODO: add count categories
            style: TextStyle(
              fontSize: FontSizeManager.s16,
              fontFamily: FontsManager.poppinsFontFamily,
              fontWeight: FontWeight.w600,
              color: ColorManager.kBlackColor,
            ),
          ),
          TextButton(
            onPressed: onPressedAddNewCategory,
            child: Text(
              ConstsValuesManager.addNewCategory,
              style: TextStyle(
                fontSize: FontSizeManager.s12,
                fontFamily: FontsManager.otamaEpFontFamily,
                color: ColorManager.kBlackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
