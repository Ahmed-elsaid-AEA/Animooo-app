import 'package:animooo/models/gategory/category_response.dart';
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

class AnimalFormField extends StatelessWidget {
  const AnimalFormField({
    super.key,
    required this.onChanged,
    required this.onTapAtSelectImage,
    required this.selectImageStatus,
    required this.animalImageOutputStream,
    required this.animalNameController,
    required this.animalDescriptionController,
    required this.animalFormKey,
    required this.animalPriceController,
    required this.listCategory,
    required this.onSelectedCategory,
    required this.selectedIndexCategory,
  });

  final List<CategoryInfoModel> listCategory;
  final void Function(int index) onSelectedCategory;
  final int selectedIndexCategory;
  final void Function(String value) onChanged;
  final void Function(FormFieldState<File>) onTapAtSelectImage;
  final SelectImageStatus selectImageStatus;
  final Stream<File?> animalImageOutputStream;

  final TextEditingController animalNameController;
  final TextEditingController animalDescriptionController;
  final TextEditingController animalPriceController;

  final GlobalKey<FormState> animalFormKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: animalFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRequiredField(
            controller: animalNameController,
            title: ConstsValuesManager.animalName,
            hintText: ConstsValuesManager.enterYourAnimalName,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ConstsValuesManager.animalNameIsRequired;
              } else if (value.length < 3 || value.length > 20) {
                return ConstsValuesManager.animalNameMustBeBetween3And20;
              }
              return null;
            },
            onChanged: onChanged,
          ),
          VerticalSpace(HeightsManager.h12),
          CustomRequiredField(
            maxLines: 3,
            onChanged: onChanged,
            controller: animalDescriptionController,
            title: ConstsValuesManager.animalDescription,
            hintText: ConstsValuesManager.enterYourDescription,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ConstsValuesManager.animalDescriptionIsRequired;
              } else if (value.length < 20 || value.length > 200) {
                return ConstsValuesManager
                    .animalDescriptionMustBeBetween20And200;
              }
              return null;
            },
          ),
          VerticalSpace(HeightsManager.h12),
          Text(
            ConstsValuesManager.uploadImageForYourAnimal,
            style: TextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorManager.kGreyColor,
              fontFamily: FontsManager.poppinsFontFamily,
            ),
          ),
          VerticalSpace(HeightsManager.h4),
          StreamBuilder<File?>(
            stream: animalImageOutputStream,
            initialData: null,
            builder: (context, snapshot) => CustomSelectImageWidget(
              file: snapshot.data,
              onTapAtSelectImage: onTapAtSelectImage,
              selectImageStatus: selectImageStatus,
            ),
          ),
          VerticalSpace(HeightsManager.h12),
          CustomRequiredField(
            maxLines: 1,
            onChanged: onChanged,
            controller: animalPriceController,
            title: ConstsValuesManager.animalPrice,
            hintText: ConstsValuesManager.enterYourPrice,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return ConstsValuesManager.animalPriceRequired;
              } else if (int.parse(value) <= 0) {
                return ConstsValuesManager.animalPriceMustBeGreaterThanZero;
              }
              return null;
            },
          ),
          VerticalSpace(HeightsManager.h12),

          ChoiceCategoryName(
            listCategory: listCategory,
            onSelectedCategory: onSelectedCategory,
            selectedIndexCategory: selectedIndexCategory,
          ),
        ],
      ),
    );
  }
}

class ChoiceCategoryName extends StatelessWidget {
  const ChoiceCategoryName({
    super.key,
    required this.listCategory,
    required this.onSelectedCategory,
  });

  final List<CategoryInfoModel> listCategory;
  final void Function(int index) onSelectedCategory;
  final int selectedIndexCategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ConstsValuesManager.categoryName,
            style: TextStyle(
              fontSize: FontSizeManager.s16,
              color: ColorManager.kGreyColor,
              fontFamily: FontsManager.poppinsFontFamily,
            ),
          ),
        ),
        Wrap(
          spacing: 5,
          children: List.generate(
            listCategory.length,
            (index) => ChoiceChip(
              // disabledColor: ColorManager.kWhite2Color,
              checkmarkColor: ColorManager.kWhiteColor,
              onSelected: (value) {
                onSelectedCategory(index);
              },
              selectedColor: ColorManager.kPrimaryColor,
              backgroundColor: ColorManager.kWhiteColor,
              labelStyle: TextStyle(
                fontSize: FontSizeManager.s12,
                color: selectedIndexCategory == index
                    ? ColorManager.kWhiteColor
                    : ColorManager.kGreyColor,
                fontFamily: FontsManager.poppinsFontFamily,
              ),
              label: Text(listCategory[index].name),
              selected: selectedIndexCategory == index,
            ),
          ),
        ),
      ],
    );
  }
}
