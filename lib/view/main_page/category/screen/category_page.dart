import 'dart:io';

import 'package:animooo/core/resources/border_radius_manager.dart';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/resources/width_manager.dart';
import 'package:animooo/core/widgets/buttons/app_button.dart';
import 'package:animooo/core/widgets/custom_required_field.dart';
import 'package:animooo/core/widgets/custom_text_form_field.dart';
import 'package:animooo/core/widgets/spacing/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/enums/select_image_status.dart';
import '../../../../core/resources/assets_values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/fonts_size_manager.dart';

import '../../../../core/resources/padding_manager.dart';
import '../../../../core/widgets/custom_select_your_image_widget.dart';
import '../../../../core/widgets/spacing/vertical_space.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: PaddingManager.pw16,
            vertical: PaddingManager.ph12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create New Category",
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
                          color: ColorManager.kLightGreenColor.withOpacity(.1),
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

              CustomRequiredField(
                controller: TextEditingController(),
                title: ConstsValuesManager.categoryName,
                hintText: ConstsValuesManager.enterYourCategoryName,
                keyboardType: TextInputType.text,
              ),
              VerticalSpace(HeightsManager.h12),
              CustomRequiredField(
                maxLines: 3,
                controller: TextEditingController(),
                title: ConstsValuesManager.categoryDescription,
                hintText: ConstsValuesManager.enterYourDescription,
                keyboardType: TextInputType.text,
              ),
              VerticalSpace(HeightsManager.h12),
              Text(
                ConstsValuesManager.uploadImageForYourCategory,
                style: TextStyle(
                  fontSize: FontSizeManager.s16,
                  color: ColorManager.kGreyColor,
                  fontFamily: FontsManager.poppinsFontFamily,
                ),
              ),
              VerticalSpace(HeightsManager.h4),

              StreamBuilder<File?>(
                stream: Stream.empty(),
                initialData: null,
                builder: (context, snapshot) => CustomSelectImageWidget(
                  file: snapshot.data,
                  onTapAtSelectImage: (value) {},
                  selectImageStatus: SelectImageStatus.noImageSelected,
                ),
              ),
              VerticalSpace(HeightsManager.h31),
              AppButton(text: ConstsValuesManager.save, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
