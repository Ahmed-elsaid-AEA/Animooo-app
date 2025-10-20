import 'package:animooo/core/resources/assets_values_manager.dart';
import 'package:animooo/core/resources/border_radius_manager.dart';
import 'package:animooo/core/resources/colors_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/fonts_size_manager.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:animooo/core/widgets/spacing/vertical_space.dart';
import 'package:animooo/models/gategory/category_response.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/padding_manager.dart';

class HomePageCategories extends StatelessWidget {
  const HomePageCategories({
    super.key,
    required this.onPressedAddNewCategory,
    required this.onPressedAtSeeMore,
    required this.listCategoriesOutput,
  });

  final VoidCallback onPressedAddNewCategory;
  final VoidCallback onPressedAtSeeMore;
  final Stream<List<CategoryInfoModel>> listCategoriesOutput;

  @override
  Widget build(BuildContext context) {
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
          child: StreamBuilder<List<CategoryInfoModel>>(
            stream: listCategoriesOutput,
            initialData: [],
            builder: (context, snapshot) => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : snapshot.data == null
                    ? SizedBox()
                    // : index == 0
                    // ? HorizontalSpace(WidthManager.w16)
                    // : index == snapshot.data!.length - 1
                    // ? Container(
                    //     alignment: Alignment.center,
                    //     margin: EdgeInsets.only(right: 30, bottom: 20),
                    //     child: MaterialButton(
                    //       onPressed: onPressedAtSeeMore,
                    //       color: ColorManager.kGreenColor,
                    //       padding: EdgeInsets.zero,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(BorderRadiusManager.br10),
                    //         ),
                    //       ),
                    //       child: Text(
                    //         ConstsValuesManager.seeMore,
                    //         style: TextStyle(
                    //           fontSize: FontSizeManager.s12,
                    //           fontFamily: FontsManager.otamaEpFontFamily,
                    //           color: ColorManager.kWhiteColor,
                    //         ),
                    //       ),
                    //     ),
                    //   )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        //TODO ::Solve the problem of the overflow
                        /*
                                *
                  A RenderFlex overflowed by 30 pixels on the bottom.

                  The relevant error-causing widget was:
                    Column Column:file:///G:/udemy/flutter%20Intermediate%20%20level/animooo/lib/view/main_page/widgets/home_page_categories.dart:46:19
                  */
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                color: Colors.red,
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundImage: NetworkImage(
                                    //TODO :: add cashNetworkImage
                                    snapshot.data![index].imagePath,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: -3,
                                child: Badge.count(
                                  maxCount: 9,
                                  count: 10,
                                  textStyle: TextStyle(
                                    fontSize: FontSizeManager.s12,
                                    fontFamily: FontsManager.poppinsFontFamily,
                                  ),
                                  padding: EdgeInsets.all(4),
                                  backgroundColor: ColorManager.kPrimaryColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data![index].name,
                            style: TextStyle(
                              fontSize: FontSizeManager.s16,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontsManager.otamaEpFontFamily,
                            ),
                          ),
                        ],
                      );
              },
              separatorBuilder: (context, index) =>
                  HorizontalSpace(WidthManager.w20),
              itemCount: snapshot.data!.length, //+ 2,
            ),
          ),
        ),
        VerticalSpace(HeightsManager.h22),
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
