
import 'package:animooo/core/resources/border_radius_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/buttons/app_button.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:animooo/view/main_page/category/widget/category_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../controller/category_page_controller.dart';
import '../../../../core/resources/assets_values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/fonts_size_manager.dart';

import '../../../../core/resources/padding_manager.dart';
import '../../../../core/widgets/spacing/vertical_space.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  late CategoryPageController _categoryPageController;

  @override
  void initState() {
    super.initState();
    _categoryPageController = CategoryPageController(context);
  }

  @override
  Widget build(BuildContext context) {
    print("build category page");
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: PaddingManager.pw16,
              vertical: PaddingManager.ph12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ConstsValuesManager.createNewCategory,
                  style: TextStyle(
                    fontSize: FontSizeManager.s20,
                    fontFamily: FontsManager.otamaEpFontFamily,
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
                VerticalSpace(HeightsManager.h12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: BorderRadiusManager.br18,
                      backgroundImage: AssetImage(
                        AssetsValuesManager.backgroundSplashScreenUnder12,
                      ),
                    ),
                    HorizontalSpace(WidthManager.w6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ahmed Elsaid",
                          style: TextStyle(
                            fontFamily: FontsManager.otamaEpFontFamily,
                            fontSize: FontSizeManager.s12,
                            color: ColorManager.kBlackColor,
                          ),
                        ),
                        VerticalSpace(HeightsManager.h4),
                        Container(
                          padding: EdgeInsets.all(PaddingManager.ph5),
                          decoration: BoxDecoration(
                            color: ColorManager.kLightGreenColor.withValues(
                              alpha: .1,
                            ),
                            borderRadius: BorderRadius.circular(
                              BorderRadiusManager.br32,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.public,
                                size: 10,
                                color: ColorManager.kLightGreenColor,
                              ),
                              HorizontalSpace(WidthManager.w3),
                              Text(
                                ConstsValuesManager.public,
                                style: TextStyle(
                                  fontSize: FontSizeManager.s10,
                                  color: ColorManager.kLightGreenColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                VerticalSpace(HeightsManager.h22),
                CategoryFormField(
                  categoryFormKey: _categoryPageController.categoryFormKey,
                  onChanged: _categoryPageController.onChanged,
                  onTapAtSelectImage:
                      _categoryPageController.onTapAtSelectImage,
                  selectImageStatus: _categoryPageController.selectImageStatus,
                  categoryImageOutputStream:
                      _categoryPageController.categoryFileImageOutPutStream,
                  categoryNameController:
                      _categoryPageController.categoryNameController,
                  categoryDescriptionController:
                      _categoryPageController.categoryDescriptionController,
                ),
                VerticalSpace(HeightsManager.h31),
                AppButton(
                  text: ConstsValuesManager.save,
                  onTap: () {
                    _categoryPageController.onTapSaveButton();
                  },
                  buttonStatusOutputStream:
                      _categoryPageController.saveButtonStatusOutPutStream,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
