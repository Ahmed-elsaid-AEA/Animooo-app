

import 'package:flutter/material.dart';

import '../../../../core/resources/assets_values_manager.dart';
import '../../../../core/resources/colors_manager.dart';
import '../../../../core/resources/conts_values.dart';
import '../../../../core/resources/fonts_size_manager.dart';
import '../../../../models/gategory/category_response.dart' show CategoryInfoModel;

class ChoiceCategoryNameAnimalPage extends StatelessWidget {
  const ChoiceCategoryNameAnimalPage({
    super.key,
    required this.listCategory,
    required this.onSelectedCategory,
    required this.selectedIndexCategory,
  });

  final List<CategoryInfoModel> listCategory;
  final void Function(int index) onSelectedCategory;
  final int? selectedIndexCategory;

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
