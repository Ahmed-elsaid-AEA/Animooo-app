import 'package:animooo/core/enums/widget_status_enum.dart';
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
import 'package:shimmer/shimmer.dart';

import '../../../core/resources/padding_manager.dart';

class HomePageCategories extends StatelessWidget {
  const HomePageCategories({
    super.key,
    required this.onPressedAddNewCategory,
    required this.onPressedAtSeeMore,
    required this.listCategoriesOutput,
    required this.sectionCategoriesStatusOutput,
    required this.onTapAtCategory,
  });

  final VoidCallback onPressedAddNewCategory;
  final VoidCallback onPressedAtSeeMore;
  final Stream<List<CategoryInfoModel>> listCategoriesOutput;
  final Stream<WidgetStatusEnum> sectionCategoriesStatusOutput;
  final void Function(CategoryInfoModel category) onTapAtCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: PaddingManager.pw16,
          ),
          child: StreamBuilder<List<CategoryInfoModel>>(
            stream: listCategoriesOutput,
            initialData: [],
            builder: (context, snapshot) {
              return _TitleCategory(
                onPressedAddNewCategory: onPressedAddNewCategory,
                countCategory: snapshot.data!.length,
              );
            },
          ),
        ),
        VerticalSpace(HeightsManager.h22),
        SizedBox(
          height: HeightsManager.h82,
          child: StreamBuilder<WidgetStatusEnum>(
            stream: sectionCategoriesStatusOutput,
            builder: (context, snapShotStatus) {
              return IndexedStack(
                index: snapShotStatus.data == WidgetStatusEnum.loading ? 0 : 1,
                children: [
                  _LoadingItemCategories(),
                  HaveItemCategories(
                    listCategoriesOutput: listCategoriesOutput,
                    onTapAtCategory: onTapAtCategory,
                  ),
                ],
              );
              // return snapShotStatus.data == WidgetStatusEnum.loading
              //     ? FlutterLogo()
              //     : Container(
              //   color: Colors.red,
              //       child: HaveItemCategories(
              //           listCategoriesOutput: listCategoriesOutput,
              //         ),
              //     );
            },
          ),
        ),

        VerticalSpace(HeightsManager.h22),
      ],
    );
  }
}

class HaveItemCategories extends StatelessWidget {
  const HaveItemCategories({
    super.key,
    required this.listCategoriesOutput,
    required this.onTapAtCategory,
  });

  final Stream<List<CategoryInfoModel>> listCategoriesOutput;
  final void Function(CategoryInfoModel category) onTapAtCategory;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryInfoModel>>(
      stream: listCategoriesOutput,
      initialData: [],
      builder: (context, snapshot) => ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: PaddingManager.ph16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : snapshot.data == null
              ? SizedBox()
              : InkWell(
                  onTap: () {
                    onTapAtCategory(snapshot.data![index]);
                  },
                  child: Column(
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
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(
                              //TODO :: add cashNetworkImage
                              snapshot.data![index].imagePath,
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
                  ),
                );
        },
        separatorBuilder: (context, index) => HorizontalSpace(WidthManager.w20),
        itemCount: snapshot.data!.length, //+ 2,
      ),
    );
  }
}

class _TitleCategory extends StatelessWidget {
  const _TitleCategory({
    required this.onPressedAddNewCategory,
    required this.countCategory,
  });

  final VoidCallback onPressedAddNewCategory;
  final int countCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: PaddingManager.pw6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${ConstsValuesManager.categories} ( $countCategory )",
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

class _LoadingItemCategories extends StatelessWidget {
  const _LoadingItemCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: PaddingManager.ph16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Column(
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
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: CircleAvatar(radius: 32),
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

            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                margin: EdgeInsets.only(top: PaddingManager.ph4),
                color: Colors.red,
                width: WidthManager.w38,
                height: HeightsManager.h10,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => HorizontalSpace(WidthManager.w20),
      itemCount: 7,
    );
  }
}
