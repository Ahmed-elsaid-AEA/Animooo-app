import 'package:flutter/material.dart';
import 'dart:io';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:animooo/core/resources/heights_manager.dart';
import 'package:animooo/core/widgets/custom_required_field.dart';
import '../../../../core/enums/select_image_status.dart';
import '../../../../core/resources/assets_values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/fonts_size_manager.dart';
import '../../../../core/widgets/custom_select_your_image_widget.dart';
import '../../../../core/widgets/spacing/vertical_space.dart';

class CategoryFormField extends StatelessWidget {
  const CategoryFormField({
    super.key,
    required this.onChanged,
    required this.onTapAtSelectImage,
    required this.selectImageStatus,
    required this.categoryImageOutputStream,
    required this.categoryNameController,
    required this.categoryDescriptionController,
    required this.categoryFormKey,
  });

  final void Function(String value) onChanged;
  final void Function(FormFieldState<File>) onTapAtSelectImage;
  final SelectImageStatus selectImageStatus;
  final Stream<File?> categoryImageOutputStream;

  final TextEditingController categoryNameController;
  final TextEditingController categoryDescriptionController;

  final GlobalKey<FormState> categoryFormKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: categoryFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRequiredField(
            controller: categoryNameController,
            title: ConstsValuesManager.categoryName,
            hintText: ConstsValuesManager.enterYourCategoryName,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ConstsValuesManager.categoryNameRequired;
              } else if (value.length < 3 || value.length > 20) {
                return ConstsValuesManager.categoryNameMustBeBetween3And20;
              }
              return null;
            },
            onChanged: onChanged,
          ),
          VerticalSpace(HeightsManager.h12),
          CustomRequiredField(
            maxLines: 3,
            onChanged: onChanged,
            controller: categoryDescriptionController,
            title: ConstsValuesManager.categoryDescription,
            hintText: ConstsValuesManager.enterYourDescription,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ConstsValuesManager.categoryDescriptionRequired;
              } else if (value.length < 20 || value.length > 200) {
                return ConstsValuesManager
                    .categoryDescriptionMustBeBetween20And200;
              }
              return null;
            },
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
            stream: categoryImageOutputStream,
            initialData: null,
            builder: (context, snapshot) => CustomSelectImageWidget(
              key: categoryImgKey,
              file: snapshot.data,
              onTapAtSelectImage: onTapAtSelectImage,
              selectImageStatus: selectImageStatus,
            ),
          ),
        ],
      ),
    );
  }
}
